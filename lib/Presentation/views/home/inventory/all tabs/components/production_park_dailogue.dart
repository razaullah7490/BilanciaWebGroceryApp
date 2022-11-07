// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Application/Prefs/app_prefs.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/production_park_shimmer.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/common/extensions/media_query_extension.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/production_park_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../Application/Prefs/prefs_keys.dart';
import '../processedResourceAction/productionParkBloc/production_park_cubit.dart';

class ProductionParkDialogue extends StatefulWidget {
  const ProductionParkDialogue({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductionParkDialogue> createState() => _ProductionParkDialogueState();
}

class _ProductionParkDialogueState extends State<ProductionParkDialogue> {
  List<int> originActionsIds = List.empty(growable: true);
  String processedResourceActionId = '';

  Future getData() async {
    var id = await AppPrefs.getProcessedResourceId();
    setState(() {
      processedResourceActionId = id;
    });
    await context.read<ProductionParkCubit>().getProductionPark(id);
    log("PRA IDDDD $processedResourceActionId");
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQueryValues(context).width,
            height: MediaQueryValues(context).height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                backContainer(),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 330.w,
                    height: 420.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                        AppBorderRadius.backContainerBorderRadius,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 2,
                          blurRadius: 7,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        CustomSizedBox.height(20),
                        titleText(),
                        CustomSizedBox.height(12),
                        BlocBuilder<ProductionParkCubit, ProductionParkState>(
                          builder: (context, state) {
                            if (state.status == ProductionParkEnum.loading) {
                              return const ProductionParkTileShimmerEffect();
                            }
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.modelList.length,
                                  itemBuilder: (context, index) {
                                    var model = state.modelList[index];
                                    return ProductionParkDetailContainer(
                                      color: originActionsIds.contains(model.id)
                                          ? AppColors.primaryColor
                                          : AppColors.whiteColor,
                                      model: model,
                                      onTap: () async {
                                        if (!originActionsIds
                                            .contains(model.id)) {
                                          originActionsIds.add(model.id);
                                          log("LIST $originActionsIds");
                                          setState(() {});
                                        } else {
                                          originActionsIds.remove(model.id);
                                          log("LIST $originActionsIds");
                                          setState(() {});
                                        }
                                      },
                                    );
                                  }),
                            );
                          },
                        ),
                        CustomSizedBox.height(12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            actionButton(
                              AppStrings.cancelText,
                              AppColors.searchTextFieldColor,
                              Colors.black54,
                              () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs
                                    .remove(AppPrefsKeys.processedResourceId);
                                Navigator.of(context).pop();
                              },
                            ),
                            BlocBuilder<ProductionParkCubit,
                                ProductionParkState>(
                              builder: (context, state) {
                                if (state.status ==
                                    ProductionParkEnum.loading) {
                                  return LoadingIndicator.loading();
                                }
                                return actionButton(
                                  AppStrings.addText,
                                  AppColors.redColor2,
                                  AppColors.whiteColor,
                                  () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    Map<String, dynamic> map = {
                                      "origin_actions": originActionsIds,
                                      "destination_action":
                                          processedResourceActionId,
                                    };
                                    var res = await context
                                        .read<ProductionParkCubit>()
                                        .addProductionPark(map);

                                    if (res == true) {
                                      await prefs.remove(
                                          AppPrefsKeys.processedResourceId);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        CustomSizedBox.height(15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleText() {
    return Text(
      AppStrings.selectOriginActionText,
      style: Styles.circularStdBook(
        AppSize.text21.sp,
        AppColors.blackColor,
      ),
    );
  }

  GestureDetector actionButton(
    String text,
    Color color,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p32,
          vertical: AppSize.p12,
        ).r,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15).r,
            border: Border.all(
              color: AppColors.secondaryColor,
            )),
        child: Text(
          text,
          style: Styles.circularStdBook(
            AppSize.text17.sp,
            textColor,
          ),
        ),
      ),
    );
  }

  Align backContainer() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 280.w,
        height: 440.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.backContainerBorderRadius,
          ),
        ),
      ),
    );
  }
}
