import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/resources/border_radius.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/tags/all_tags.dart';
import '../../../../../../Data/errors/custom_error.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/custom_text_field.dart';
import '../../../../../common/loading_indicator.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/routes/navigation.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/sized_box.dart';
import '../../../../../resources/text_styles.dart';
import 'Bloc/tags_cubit.dart';

class AddTagScreen extends StatefulWidget {
  const AddTagScreen({super.key});

  @override
  State<AddTagScreen> createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  final formKey = GlobalKey<FormState>();
  final tagNameController = TextEditingController();
  Color selectedColor = AppColors.primaryColor;
  String color = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: AppStrings.addTagText,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
          child: Column(
            children: [
              allFields(),
              CustomSizedBox.height(40),
              BlocListener<TagsCubit, TagsState>(
                listener: (context, state) {
                  if (state.status == TagsEnum.success) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      AppStrings.tagAddedSuccessText,
                      AppColors.greenColor,
                      Icons.check,
                      true,
                    );
                    Navigator.of(context).pop();
                    Navigate.toReplace(context, const AllTagsScreen());
                  }
                  if (state.error != const CustomError(error: '')) {
                    SnackBarWidget.buildSnackBar(
                      context,
                      state.error.error,
                      AppColors.redColor,
                      Icons.close,
                      true,
                    );
                  }
                },
                child: BlocBuilder<TagsCubit, TagsState>(
                    builder: (context, state) {
                  if (state.status == TagsEnum.loading) {
                    return LoadingIndicator.loading();
                  }
                  return CustomButton(
                    text: AppStrings.addText,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        var colorToString = splitColor(selectedColor);
                        Map<String, dynamic> map = {
                          "name": tagNameController.text,
                          "color": color.isEmpty
                              ? "52B467"
                              : colorToString.toString(),
                        };
                        await context.read<TagsCubit>().addTag(map);
                      }
                    },
                  );
                }),
              ),
              CustomSizedBox.height(10),
            ],
          ),
        ),
      ),
    );
  }

  String splitColor(Color color) {
    String toString = color.toString();
    String splitString = toString.split('(0xff')[1].split(')')[0];
    return splitString;
  }

  Widget allFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(25),
          textFieldUpperText(AppStrings.tagNameText),
          CustomTextField(
            controller: tagNameController,
            labelText: AppStrings.tagNameText,
            hintText: AppStrings.enterTagText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            isLabel: false,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.providetagNameText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          textFieldUpperText(AppStrings.selectTagColorText),
          tagColorWidget(context),
        ],
      ),
    );
  }

  Widget tagColorWidget(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        pickColor(context);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(
                left: AppSize.p18, top: AppSize.p16, bottom: AppSize.p16)
            .r,
        decoration: BoxDecoration(
          color: AppColors.textFieldFillColor,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
          border: Border.all(
            color: AppColors.secondaryColor,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            Text(
              color.isEmpty
                  ? AppStrings.selectTagColorText
                  : selectedColor.toString(),
              style: Styles.circularStdBook(
                AppSize.text13.sp,
                color.isEmpty
                    ? AppColors.hintTextColor
                    : AppColors.containerTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorPicker() => ColorPicker(
        pickerColor: selectedColor,
        enableAlpha: false,
        pickerAreaBorderRadius:
            BorderRadius.circular(AppBorderRadius.dashboardSliderBorderRadius)
                .r,
        labelTypes: const [],
        onColorChanged: (color) => setState(() {
          selectedColor = color;
          this.color = color.toString();
        }),
      );

  void pickColor(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            AppStrings.pickAColorText,
            style: Styles.circularStdMedium(
              AppSize.text17.sp,
              AppColors.blackColor,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildColorPicker(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSize.p40).r,
                  child: CustomButton(
                    text: AppStrings.selectText,
                    onTap: () {
                      Navigator.of(context).pop();
                      log("Color $selectedColor");
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget textFieldUpperText(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSize.p2,
      ).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style:
                Styles.circularStdBook(AppSize.text15.sp, AppColors.blackColor),
          ),
          CustomSizedBox.height(10),
        ],
      ),
    );
  }
}
