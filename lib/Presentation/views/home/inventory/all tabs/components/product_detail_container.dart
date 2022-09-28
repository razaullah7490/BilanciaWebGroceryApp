import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/delete_item_dialogue.dart';
import 'package:grocery/Presentation/common/edit_delete_container.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/products/bloc/product_cubit.dart';

import '../../../../../../Domain/models/inventory/products_model.dart';

class ProductDetailContainer extends StatelessWidget {
  final ProductModel model;
  const ProductDetailContainer({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p16,
        vertical: AppSize.p12,
      ).r,
      margin: const EdgeInsets.symmetric(vertical: AppSize.m6).r,
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        border: Border.all(
          color: AppColors.containerBorderColor,
          width: 1.w,
        ),
        borderRadius:
            BorderRadius.circular(AppBorderRadius.allDetailContainerRadius.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 80.w,
                height: 77.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: Image.file(
                    File(model.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                //for api
                // CachedNetworkImage(
                //   imageUrl: model.imageUrl,
                //   imageBuilder: (context, imageProvider) => Container(
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(
                //         AppBorderRadius.dashboardSliderBorderRadius,
                //       ),
                //       image: DecorationImage(
                //         image: imageProvider,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                //   placeholder: (context, url) => LoadingIndicator.loading(),
                //   errorWidget: (context, url, error) => Icon(
                //     Icons.error,
                //     size: AppSize.icon28.r,
                //   ),
                // ),
              ),
              CustomSizedBox.width(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText(model.productName),
                  CustomSizedBox.height(6),
                  subTitleText(
                      AppStrings.productIdText, model.productID.toString()),
                  CustomSizedBox.height(1),
                  subTitleText(AppStrings.quantityText,
                      model.productQuantity.toString()),
                ],
              ),
            ],
          ),
          editDeleteIcons(
            onTapEdit: () {
              final args = ProductModel(
                productName: model.productName,
                productID: model.productID,
                productQuantity: model.productQuantity,
                imageUrl: model.imageUrl,
              );

              Navigator.pushNamed(
                context,
                RoutesNames.editProductsScreen,
                arguments: args,
              );
            },
            onTapDelete: () => deleteProductDialogue(context),
          ),
        ],
      ),
    );
  }

  Text subTitleText(String text1, String text2) {
    return Text(
      '$text1 $text2',
      style: Styles.segoeUI(
        AppSize.text12.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Widget titleText(String text) {
    return Text(
      text,
      style: Styles.circularStdMedium(
        AppSize.text15.sp,
        AppColors.containerTextColor,
      ),
    );
  }

  Future<void> deleteProductDialogue(BuildContext context) async {
    return showDialog<void>(
      barrierColor: AppColors.deleteDialogueBarrierColor,
      context: context,
      builder: (BuildContext context) {
        return DeleteItemDialogue(
          text: AppStrings.productText,
          onDeleteButtonTap: () {
            context.read<ProductCubit>().deleteProduct(model.productID);
            Navigator.of(context).pop();
            SnackBarWidget.buildSnackBar(
              context,
              AppStrings.productDeleteSuccessText,
              AppColors.greenColor,
              Icons.check,
              true,
            );
          },
        );
      },
    );
  }
}
