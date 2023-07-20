import 'package:grocery/Application/exports.dart';

class DeleteItemDialogue2 extends StatelessWidget {
  final String text;
  final VoidCallback onDeleteButtonTap;
  const DeleteItemDialogue2({
    Key? key,
    required this.text,
    required this.onDeleteButtonTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                      CustomSizedBox.height(60),
                      circleImage(),
                      CustomSizedBox.height(30),
                      richText(),
                      CustomSizedBox.height(50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          actionButton(
                            AppStrings.cancelText,
                            AppColors.searchTextFieldColor,
                            Colors.black54,
                            () => Navigator.of(context).pop(),
                          ),
                          actionButton(
                            AppStrings.deleteText,
                            AppColors.redColor2,
                            AppColors.whiteColor,
                            onDeleteButtonTap,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
          horizontal: AppSize.p40,
          vertical: AppSize.p15,
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

  Padding richText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: AppStrings.doYouWantToDeleteText,
            style: Styles.circularStdBook(
              AppSize.text25.sp,
              AppColors.blackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                text: " $text?",
                style: Styles.circularStdMedium(
                  AppSize.text25.sp,
                  AppColors.blackColor,
                ),
              ),
            ]),
      ),
    );
  }

  Container circleImage() {
    return Container(
      width: 100.w,
      height: 100.h,
      padding: const EdgeInsets.only(right: AppSize.p6),
      decoration: const BoxDecoration(
        color: AppColors.searchTextFieldColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          Assets.delete,
          width: 50.w,
          height: 50.h,
        ),
      ),
    );
  }
}

class DeleteItemDialogue3 extends StatelessWidget {
  final String text;
  final VoidCallback onDeleteButtonTap;
  final String? headerTitle;
  final String? iconPath;
  const DeleteItemDialogue3({
    Key? key,
    required this.text,
    required this.onDeleteButtonTap,
    this.headerTitle,
    this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
                  height: 400.h,
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
                      CustomSizedBox.height(60),
                      circleImage(iconPath),
                      CustomSizedBox.height(30),
                      richText(headerTitle),
                      CustomSizedBox.height(50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          actionButton(
                            AppStrings.cancelText,
                            AppColors.searchTextFieldColor,
                            Colors.black54,
                            () => Navigator.of(context).pop(),
                          ),
                          actionButton(
                            AppStrings.deleteText,
                            AppColors.redColor2,
                            AppColors.whiteColor,
                            onDeleteButtonTap,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
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
          horizontal: AppSize.p40,
          vertical: AppSize.p15,
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

  Padding richText(String? headerTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: headerTitle ?? 'Account Deletion\n\n',
            style: Styles.circularStdBook(
              AppSize.text25.sp,
              AppColors.blackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                text: " $text",
                style: Styles.circularStdBook(
                  AppSize.text14.sp,
                  AppColors.textColor,
                ),
              ),
            ]),
      ),
    );
  }

  Container circleImage(String? iconPath) {
    return Container(
      width: 100.w,
      height: 100.h,
      padding: const EdgeInsets.only(right: AppSize.p6),
      decoration: const BoxDecoration(
        color: AppColors.searchTextFieldColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Image.asset(
          iconPath ?? Assets.delete,
          width: 50.w,
          height: 50.h,
        ),
      ),
    );
  }
}

class DeleteItemDialogue4 extends StatelessWidget {
  final String text;
  final VoidCallback onDeleteButtonTap;
  final String? headerTitle;
  final String? iconPath;
  const DeleteItemDialogue4({
    Key? key,
    required this.text,
    required this.onDeleteButtonTap,
    this.headerTitle,
    this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        //backContainer(),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: 350.w,
            height: 300.h,
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
                CustomSizedBox.height(40),
                circleImage(iconPath),
                CustomSizedBox.height(30),
                richText(headerTitle),
                //  CustomSizedBox.height(50),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     actionButton(
                //       AppStrings.cancelText,
                //       AppColors.searchTextFieldColor,
                //       Colors.black54,
                //           () => Navigator.of(context).pop(),
                //     ),
                //     actionButton(
                //       AppStrings.deleteText,
                //       AppColors.redColor2,
                //       AppColors.whiteColor,
                //       onDeleteButtonTap,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ],
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
          horizontal: AppSize.p40,
          vertical: AppSize.p15,
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

  Padding richText(String? headerTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
      child: RichText(
        textAlign: TextAlign.center,
        maxLines: 8,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
            text: headerTitle ?? 'Account Deletion\n\n',
            style: Styles.circularStdBook(
              AppSize.text25.sp,
              AppColors.blackColor,
            ),
            children: <TextSpan>[
              TextSpan(
                text: " $text",
                style: Styles.circularStdBook(
                  AppSize.text14.sp,
                  AppColors.textColor,
                ),
              ),
            ]),
      ),
    );
  }

  Widget circleImage(String? iconPath) {
    return Center(
      child: Image.asset(
        iconPath ?? Assets.delete,
        width: 100.w,
        height: 100.h,
      ),
    );
  }
}
