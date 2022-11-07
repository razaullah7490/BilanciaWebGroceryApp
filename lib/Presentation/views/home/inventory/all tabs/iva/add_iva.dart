// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/custom_button.dart';
import 'package:grocery/Presentation/common/custom_text_field.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/iva/ivaBloc/manager_iva_cubit.dart';
import '../../../../../common/snack_bar_widget.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/size.dart';
import '../../../../../resources/sized_box.dart';
import '../../../../../resources/text_styles.dart';

class AddIvaBottomSheet extends StatefulWidget {
  const AddIvaBottomSheet({super.key});

  @override
  State<AddIvaBottomSheet> createState() => _AddIvaBottomSheetState();
}

class _AddIvaBottomSheetState extends State<AddIvaBottomSheet> {
  final aliquotaIvaValueController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSizedBox.height(25),
            titleText(AppStrings.addAliquotaIva),
            CustomSizedBox.height(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.p18).r,
              child: CustomTextField(
                controller: aliquotaIvaValueController,
                labelText: AppStrings.valueText,
                hintText: AppStrings.enterAliquotaIva,
                suffixIcon: const Text(''),
                obscureText: false,
                textInputType: TextInputType.number,
                validator: (v) {
                  if (v!.trim().isEmpty) {
                    return AppStrings.provideValue;
                  } else {
                    return null;
                  }
                },
              ),
            ),
            CustomSizedBox.height(20),
            BlocListener<ManagerIvaCubit, ManagerIvaState>(
              listener: (context, state) {
                if (state.status == IvaEnum.success) {
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.ivaAddedSuccessText,
                    AppColors.greenColor,
                    Icons.check,
                    true,
                  );

                  Navigator.of(context).pop();
                  context.read<ManagerIvaCubit>().getIva();
                }
                if (state.status == IvaEnum.error) {
                  SnackBarWidget.buildSnackBar(
                    context,
                    state.error.error,
                    AppColors.redColor,
                    Icons.close,
                    true,
                  );
                }
              },
              child: BlocBuilder<ManagerIvaCubit, ManagerIvaState>(
                  builder: (context, state) {
                if (state.status == IvaEnum.loading) {
                  return LoadingIndicator.loading();
                }
                return CustomButton(
                  scale: 0.8,
                  text: AppStrings.addText,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      await context
                          .read<ManagerIvaCubit>()
                          .addIva(aliquotaIvaValueController.text);
                    }
                  },
                );
              }),
            ),
            CustomSizedBox.height(20),
          ],
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.circularStdMedium(
            AppSize.text17.sp,
            AppColors.containerTextColor,
          ),
        ),
        CustomSizedBox.width(4),
        const Icon(
          Icons.add_circle_outline_rounded,
          color: AppColors.primaryColor,
          size: AppSize.icon25,
        ),
      ],
    );
  }
}
