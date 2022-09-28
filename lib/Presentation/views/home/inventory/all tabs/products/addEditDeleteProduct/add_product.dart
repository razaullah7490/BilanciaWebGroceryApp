import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/custom_bottom_sheet.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/image_picker.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/common/snack_bar_widget.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/products/bloc/product_cubit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../../Domain/models/inventory/products_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productNameController = TextEditingController();
  final productQuantityContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.addProductText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              textFields(),
              CustomSizedBox.height(28),
              Align(
                  alignment: Alignment.centerLeft,
                  child: textFieldUpperText(AppStrings.addImageText)),
              CustomSizedBox.height(5),
              Row(
                children: [
                  CustomBottomSheet(
                    onCameraTap: () async {
                      Navigator.of(context).pop();
                      var imagePath =
                          await CustomImagePicker.getImage(ImageSource.camera);
                      setState(() {
                        image = imagePath;
                      });
                    },
                    onGalleryTap: () async {
                      Navigator.of(context).pop();
                      var imagePath =
                          await CustomImagePicker.getImage(ImageSource.gallery);
                      setState(() {
                        image = imagePath;
                      });
                    },
                  ),
                  if (image != null) imageContainer(),
                ],
              ),
              CustomSizedBox.height(60),
              BlocBuilder<ProductCubit, ProductState>(
                  builder: ((context, state) {
                if (state.status == ProductEnum.loading) {
                  return LoadingIndicator.loading();
                }
                return CustomButton(
                  text: AppStrings.addProductText,
                  onTap: () async {
                    Random random = Random();
                    int randomNumber = random.nextInt(100);

                    if (formKey.currentState!.validate()) {
                      if (image != null) {
                        context.read<ProductCubit>().addProduct(
                              ProductModel(
                                productName: productNameController.text,
                                productID: randomNumber,
                                productQuantity: double.parse(
                                    productQuantityContoller.text.toString()),
                                imageUrl: image!.path.toString(),
                              ),
                            );
                        Navigator.of(context).pop();
                        SnackBarWidget.buildSnackBar(
                          context,
                          AppStrings.productAddedSuccessText,
                          AppColors.greenColor,
                          Icons.check,
                          true,
                        );
                      } else {
                        SnackBarWidget.buildSnackBar(
                          context,
                          AppStrings.pleaseSelectImageText,
                          AppColors.redColor,
                          Icons.close,
                          true,
                        );
                      }
                    }
                  },
                );
              })),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageContainer() {
    return Container(
      padding: const EdgeInsets.all(AppSize.p6).r,
      margin: const EdgeInsets.symmetric(horizontal: AppSize.m15).r,
      width: 120.w,
      height: 110.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 1.5.w,
        ),
        borderRadius: BorderRadius.circular(
          AppBorderRadius.chooseImageContainerRadius.r,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppBorderRadius.chooseImageContainerRadius.r,
        ),
        child: Image.file(
          image!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget textFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(40),
          textFieldUpperText(AppStrings.productNameText),
          CustomTextField(
            controller: productNameController,
            labelText: AppStrings.productNameText,
            hintText: AppStrings.enterProductNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideProductNameText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(30),
          textFieldUpperText(AppStrings.quantityOnlyText),
          CustomTextField(
            controller: productQuantityContoller,
            labelText: AppStrings.quantityOnlyText,
            hintText: AppStrings.enterQuantityText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideQuantityText;
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget textFieldUpperText(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style:
              Styles.circularStdBook(AppSize.text15.sp, AppColors.blackColor),
        ),
        CustomSizedBox.height(10),
      ],
    );
  }
}
