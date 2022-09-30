import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/data_not_available_text.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/resource_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/bloc/resource_cubit.dart';

import '../../../../../common/loading_indicator.dart';

class ResorucesScreen extends StatefulWidget {
  const ResorucesScreen({super.key});

  @override
  State<ResorucesScreen> createState() => _ResorucesScreenState();
}

class _ResorucesScreenState extends State<ResorucesScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<ResourceCubit>().getResource(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.resourcesText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addResourceText,
            onTap: () =>
                Navigator.pushNamed(context, RoutesNames.addResourceScreen),
          ),
          CustomSizedBox.height(25),
          BlocBuilder<ResourceCubit, ResourceState>(builder: (context, state) {
            if (state.status == ResourceEnum.loading) {
              return LoadingIndicator.loadingExpanded();
            }
            return state.resourceModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noResourcesAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.resourceModel.length,
                        itemBuilder: (context, index) {
                          var singleData = state.resourceModel[index];
                          return ResourceDetailContainer(model: singleData);
                        }),
                  );
          }),
        ],
      ),
    );
  }
}
