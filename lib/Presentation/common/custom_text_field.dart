import 'package:grocery/Application/exports.dart';

import '../../Application/functions.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final String hintText;
  final Widget suffixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool isLabel;
  // final List<TextInputFormatter>? inputFormatters;
  final ValueChanged? onChanged;
final String? initialValue;
// final bool? isDotReplace;
  const CustomTextField({
    @required this.controller,
    @required this.initialValue,
    required this.labelText,
    required this.hintText,
    required this.suffixIcon,
    required this.obscureText,
    required this.textInputType,
    required this.validator,
    this.isLabel = true,
    // this.inputFormatters,
    this.onChanged,
    // this.isDotReplace = false,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    focusNode!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      onChanged: widget.onChanged,
      // onChanged: (v){
      //   // widget.controller?.text = v;
      //   if(widget.isDotReplace!){
      //     commaReplaceToDot(widget.controller!, v);
      //   }
      //   if(widget.onChanged != null){
      //     widget.onChanged!(v);
      //   }
      // },
      // inputFormatters: widget.inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      onTap: requestFocus,
      validator: widget.validator,
      keyboardType: widget.textInputType,
      obscureText: widget.obscureText,
      controller: widget.controller,
      style: Styles.segoeUI(AppSize.text15.sp, AppColors.blackColor),
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon,
        floatingLabelBehavior: widget.isLabel
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        hintStyle:
            Styles.circularStdBook(AppSize.text13.sp, AppColors.hintTextColor),
        labelStyle: Styles.circularStdBook(
            AppSize.text13.sp,
            focusNode!.hasFocus
                ? AppColors.primaryColor
                : AppColors.hintTextColor),
        filled: true,
        fillColor: AppColors.textFieldFillColor,
        contentPadding: const EdgeInsets.only(
                left: AppSize.p18, top: AppSize.p16, bottom: AppSize.p16)
            .r,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppBorderRadius.textFieldBorderRadius.r),
          borderSide: const BorderSide(color: AppColors.secondaryColor),
        ),
      ),
    );
  }

  void requestFocus() {
    focusNode!.addListener(() {
      setState(() {});
    });
  }
}
