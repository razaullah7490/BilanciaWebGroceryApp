import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/ingredient_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/ingredients/add_ingredients.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/ingredients/ingredientsBloc/ingredients_cubit.dart';
import '../../../../../common/add_item_button.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../common/shimmer effect/iva_and_ingredients_shimmer.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/sized_box.dart';
import 'package:grocery/Presentation/common/extensions/media_query_extension.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({super.key});

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<IngredientsCubit>().getIngredients(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.ingredientsText,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSizedBox.height(20),
            addItemButtonWidget(
              context: context,
              text: AppStrings.addIngredientText,
              onTap: () async {
                await showModalBottomSheet(
                  elevation: 10,
                  barrierColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const AddIngredientBottomSheet(),
                );
              },
            ),
            CustomSizedBox.height(15),
            BlocBuilder<IngredientsCubit, IngredientsState>(
                builder: (context, state) {
              if (state.status == IngredientsEnum.loading) {
                return const IvaAndIngredientShimmerEffect();
              }
              return state.modelList.isEmpty
                  ? SizedBox(
                      height: MediaQueryValues(context).height,
                      child: DataNotAvailableText.withOutExpanded(
                        AppStrings.noIngredientAddedText,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.modelList.length,
                      itemBuilder: (context, index) {
                        var model = state.modelList[index];
                        return IngredientDetailContainer(model: model);
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
