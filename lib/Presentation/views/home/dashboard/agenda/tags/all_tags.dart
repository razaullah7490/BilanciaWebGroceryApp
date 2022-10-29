import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/tag_shimmer.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/tags/Bloc/tags_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/components/tag_detail_container.dart';
import '../../../../../common/add_item_button.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/routes/navigation.dart';
import '../../../../../resources/sized_box.dart';
import 'add_tag.dart';

class AllTagsScreen extends StatefulWidget {
  const AllTagsScreen({super.key});

  @override
  State<AllTagsScreen> createState() => _AllTagsScreenState();
}

class _AllTagsScreenState extends State<AllTagsScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<TagsCubit>().getAllTags(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.allTagsText,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(15),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addTagText,
            onTap: () => Navigate.to(context, const AddTagScreen()),
          ),
          CustomSizedBox.height(10),
          BlocBuilder<TagsCubit, TagsState>(
            builder: (context, state) {
              if (state.status == TagsEnum.loading) {
                return const TagListTileShimmerEffect();
              }
              return state.tagModel.isEmpty
                  ? DataNotAvailableText.withExpanded(
                      AppStrings.noTagsAddedText,
                    )
                  : Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.tagModel.length,
                        itemBuilder: (context, index) {
                          var model = state.tagModel[index];
                          return TagDetailContainer(model: model);
                        },
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
