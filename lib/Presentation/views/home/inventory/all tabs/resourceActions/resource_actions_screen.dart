import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/data_not_available_text.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/product_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/addEditDeleteResourceActions/add_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/bloc/resource_action_cubit.dart';
import '../../../../../common/shimmer effect/list_tile_shimmer.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/text_styles.dart';
import '../components/actions_pagination.dart';
import '../components/resource_action_detail.dart';

class ResourceActionsScreen extends StatefulWidget {
  const ResourceActionsScreen({super.key});

  @override
  State<ResourceActionsScreen> createState() => _ResourceActionsScreenState();
}

class _ResourceActionsScreenState extends State<ResourceActionsScreen> {
  int totalPages = 0;
  @override
  void initState() {
    log("INIT");
    Future.wait([
      context.read<ResourceActionCubit>().getResourceAction(1),
    ]).whenComplete(() {
      totalPages = context
          .read<ResourceActionCubit>()
          .state
          .resourceActionModel
          .totalPages!;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionsPaginationWidget(
        totalPages: totalPages,
        initialPage: 1,
        onPageChanged: (v) async {
          log("Page $v");
          await context.read<ResourceActionCubit>().getResourceAction(v);
        },
      ),
      appBar: const CustomAppBar(
        title: AppStrings.resourceActionText,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(15),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addActionText,
            onTap: () {
              final args = ResourceData(
                id: 0,
                name: '',
                isInventoryAction: true,
              );

              Navigate.to(context, AddResourceActionScreen(resourceData: args));
            },
          ),
          CustomSizedBox.height(10),
          BlocBuilder<ResourceActionCubit, ResourceActionState>(
              builder: (context, state) {
            if (state.status == ResourceActionEnum.loading) {
              return const ListTileShimmerEffect();
            }
            return state.resourceActionModel.results!.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noResourceActionAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.resourceActionModel.results!.length,
                        itemBuilder: (context, index) {
                          var singleData =
                              state.resourceActionModel.results![index];
                          return ResourceActionDetailContainer(
                            resourceActionId: singleData.resourceActionId!,
                            resourceActionName: singleData.resourceActionName!,
                            quantity: singleData.quantity!,
                            money: singleData.money!,
                            moneyType: singleData.moneyType!,
                            priceCounter: singleData.priceCounter!,
                            resource: singleData.resource!,
                            isForInternalUsage: singleData.isForInternalUsage!,
                            dateTime: singleData.dateTime!,
                          );
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
