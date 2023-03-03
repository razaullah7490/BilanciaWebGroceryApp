import 'package:grocery/Application/exports.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    key,
    required this.title,
  })  : preferredSize = const Size.fromHeight(80),
        super(key: key);
  @override
  final Size preferredSize;

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: AppColors.appBarColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: AppSize.appBarIconMar).r,
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.appBarIconShadowColor.withOpacity(0.15),
                  blurRadius: 5,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: AppSize.appBarIconPad).r,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primaryColor,
                  size: AppSize.appBarIconSize.r,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: AppSize.appBarTextPad).r,
        child: Text(
          widget.title,
          style: Styles.circularStdMedium(
            AppSize.appBarTextSize.sp,
            AppColors.blackColor,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () async {
            await exportDialogue(context);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 40.w,
            margin: const EdgeInsets.only(right: 20, top: 17).r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                AppBorderRadius.appBarContainerBorderRadius,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondaryColor.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                Assets.exportImage,
                color: AppColors.primaryColor,
                width: 20.w,
                height: 20.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> exportDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
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
                        width: 280.w,
                        height: 210.h,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            text(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<ExportCubit, ExportState>(
                                  builder: (context, state) {
                                    if (state.status == ExportEnum.loading) {
                                      return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 35).r,
                                          child:
                                              LoadingIndicator.smallLoading());
                                    }
                                    return actionButton(
                                      "Conferma",
                                      AppColors.primaryColor,
                                      () async {
                                        var res = await context
                                            .read<ExportCubit>()
                                            .export();
                                        if (res == true) {
                                          Navigator.pop(this.context);
                                          SnackBarWidget.buildSnackBar(
                                            this.context,
                                            "Email sent Successfully",
                                            AppColors.greenColor,
                                            Icons.check,
                                            true,
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                                actionButton(
                                  "Annulla",
                                  AppColors.redColor2,
                                  () => Navigator.pop(context),
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
        });
  }

  Widget text() {
    return Text(
      "L'esecuzione di questa funzione causerà l'invio di una mail contenente i dati delle rimanenze di magazzino sul tuo indirizzo, proseguire?",
      textAlign: TextAlign.start,
      style: Styles.circularStdBook(
        AppSize.text16.sp,
        AppColors.blackColor,
      ),
    );
  }

  Align backContainer() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 250.w,
        height: 230.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.backContainerBorderRadius,
          ),
        ),
      ),
    );
  }

  GestureDetector actionButton(
    String text,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 110.w,
        padding: const EdgeInsets.symmetric(
          vertical: AppSize.p12,
        ).r,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15).r,
            border: Border.all(
              color: AppColors.secondaryColor,
            )),
        child: Center(
          child: Text(
            text,
            style: Styles.circularStdBook(
              AppSize.text15.sp,
              AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
