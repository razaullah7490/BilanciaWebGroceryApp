import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/data_not_available_text.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/product_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/resource_action_detail.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/bloc/resource_action_cubit.dart';
import '../../../../../common/loading_indicator.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';

class ResourceActionsScreen extends StatefulWidget {
  const ResourceActionsScreen({super.key});

  @override
  State<ResourceActionsScreen> createState() => _ResourceActionsScreenState();
}

class _ResourceActionsScreenState extends State<ResourceActionsScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<ResourceActionCubit>().getResourceAction(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.resourceActionText,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              titleText("All Actions"),
              addItemButtonWidget(
                context: context,
                text: AppStrings.addActionText,
                onTap: () {
                  final args = ResourceData(
                    id: 0,
                    name: '',
                    isInventoryAction: true,
                  );

                  Navigator.pushNamed(
                    context,
                    RoutesNames.addResourceActionsScreen,
                    arguments: args,
                  );
                },
              ),
            ],
          ),
          CustomSizedBox.height(10),
          BlocBuilder<ResourceActionCubit, ResourceActionState>(
              builder: (context, state) {
            log("state of resource actions ${state.status}");
            log(" resource actions list  ${state.resourceActionModel}");
            if (state.status == ResourceActionEnum.loading) {
              return LoadingIndicator.loadingExpanded();
            }

            return state.resourceActionModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noResourceActionAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.resourceActionModel.length,
                        itemBuilder: (context, index) {
                          var singleData = state.resourceActionModel[index];
                          return ResourceActionDetailContainer(
                              model: singleData);
                        }),
                  );
          }),
        ],
      ),
    );
  }

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p10,
        vertical: AppSize.p6,
      ).r,
      child: Text(
        text,
        style: Styles.circularStdMedium(
          AppSize.text20.sp,
          AppColors.primaryColor,
        ),
      ),
    );
  }
}
