// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:grocery/Presentation/common/custom_button.dart';
// import 'package:grocery/Presentation/common/snack_bar_widget.dart';
// import 'package:grocery/Presentation/resources/app_strings.dart';
// import 'package:grocery/Presentation/resources/border_radius.dart';
// import 'package:grocery/Presentation/resources/colors_palette.dart';
// import 'package:grocery/Presentation/resources/routes/routes_names.dart';
// import 'package:grocery/Presentation/resources/size.dart';
// import 'package:grocery/Presentation/resources/sized_box.dart';
// import 'package:grocery/Presentation/resources/text_styles.dart';
// import 'package:grocery/Presentation/views/auth/common/bottom_text.dart';
// import 'package:grocery/Presentation/views/auth/common/screen_pattern.dart';
//
// class ConfirmationScreen extends StatefulWidget {
//   const ConfirmationScreen({super.key});
//
//   @override
//   State<ConfirmationScreen> createState() => _ConfirmationScreenState();
// }
//
// class _ConfirmationScreenState extends State<ConfirmationScreen> {
//   final controller1 = TextEditingController();
//   final controller2 = TextEditingController();
//   final controller3 = TextEditingController();
//   final controller4 = TextEditingController();
//   final controller5 = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return ScreenPattern(
//       child: Column(
//         children: [
//           CustomSizedBox.height(55),
//           titleText(),
//           CustomSizedBox.height(5),
//           descriptionText(
//             "${AppStrings.confirmationDescriptionText} Example@example.com",
//           ),
//           CustomSizedBox.height(50),
//           otpContainer(context),
//           CustomSizedBox.height(30),
//           bottomText(
//             context,
//             AppStrings.didnotReceiveCodeText,
//             AppStrings.sendAgainText,
//             () => Navigator.of(context).pop(),
//           ),
//           CustomSizedBox.height(30),
//           CustomButton(
//             text: AppStrings.confirmText,
//             onTap: () {
//               var data = controller1.text.isNotEmpty &&
//                   controller2.text.isNotEmpty &&
//                   controller3.text.isNotEmpty &&
//                   controller4.text.isNotEmpty &&
//                   controller5.text.isNotEmpty;
//
//               if (data) {
//                 Navigator.pushNamed(context, RoutesNames.setNewPasswordScreen);
//               } else {
//                 SnackBarWidget.buildSnackBar(
//                   context,
//                   "Please fill all fields",
//                   AppColors.redColor,
//                   Icons.close,
//                   true,
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Container otpContainer(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(
//         horizontal: AppSize.p10,
//         vertical: AppSize.p18,
//       ).r,
//       margin: const EdgeInsets.symmetric(
//         horizontal: AppSize.p22,
//       ).r,
//       decoration: BoxDecoration(
//         color: AppColors.textFieldFillColor,
//         borderRadius: BorderRadius.circular(
//           AppBorderRadius.textFieldBorderRadius,
//         ),
//         border: Border.all(
//           color: AppColors.secondaryColor,
//           width: 1.w,
//         ),
//       ),
//       child: Wrap(
//         alignment: WrapAlignment.center,
//         spacing: 10,
//         direction: Axis.horizontal,
//         runSpacing: 10,
//         children: [
//           otpTextField(context, true, controller1),
//           otpTextField(context, false, controller2),
//           otpTextField(context, false, controller3),
//           otpTextField(context, false, controller4),
//           otpTextField(context, false, controller5),
//         ],
//       ),
//     );
//   }
//
//   Text titleText() {
//     return Text(
//       AppStrings.confirmationText,
//       textAlign: TextAlign.center,
//       style: Styles.circularStdMedium(
//         AppSize.text30.sp,
//         AppColors.blackColor,
//         letterSpacing: 1,
//       ),
//     );
//   }
//
//   Widget descriptionText(String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: AppSize.p25),
//       child: Text(
//         text,
//         textAlign: TextAlign.center,
//         style: Styles.segoeUI(
//           AppSize.text14.sp,
//           AppColors.blackColor,
//         ),
//       ),
//     );
//   }
//
//   Widget otpTextField(
//     BuildContext context,
//     bool autoFocus,
//     TextEditingController controller,
//   ) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.shortestSide * 0.10,
//       child: AspectRatio(
//         aspectRatio: 1.2,
//         child: TextField(
//           controller: controller,
//           autofocus: autoFocus,
//           textAlign: TextAlign.center,
//           keyboardType: TextInputType.number,
//           cursorColor: AppColors.primaryColor,
//           style: Styles.segoeUI(AppSize.text30.sp, AppColors.blackColor),
//           decoration: InputDecoration(
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: AppColors.primaryColor,
//                 width: 2.w,
//               ),
//             ),
//           ),
//           maxLines: 1,
//           onChanged: (value) {
//             if (value.length == 1) {
//               FocusScope.of(context).nextFocus();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
