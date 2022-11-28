import 'package:grocery/Application/exports.dart';

class ProductionParkDetailContainer extends StatefulWidget {
  final ProductionParkModel model;
  final VoidCallback onTap;
  final Color color;
  const ProductionParkDetailContainer({
    super.key,
    required this.model,
    required this.onTap,
    required this.color,
  });

  @override
  State<ProductionParkDetailContainer> createState() =>
      _ProductionParkDetailContainerState();
}

class _ProductionParkDetailContainerState
    extends State<ProductionParkDetailContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 700),
        margin: const EdgeInsets.symmetric(
          horizontal: AppSize.m15,
          vertical: AppSize.m4,
        ).r,
        padding: const EdgeInsets.symmetric(
                horizontal: AppSize.p14, vertical: AppSize.p12)
            .r,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: widget.color == AppColors.primaryColor
                ? AppColors.primaryColor
                : AppColors.containerTextColor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(
            AppBorderRadius.productionParkTileRadius,
          ).r,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                titleText(text: widget.model.actionType),
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 20.r,
                  color: widget.color == AppColors.primaryColor
                      ? AppColors.whiteColor
                      : AppColors.containerBorderColor,
                ),
              ],
            ),
            CustomSizedBox.height(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subTitleText(
                  text1: AppStrings.quantityOnlyText,
                  text2: widget.model.quantity.toString(),
                ),
                subTitleText(
                  text1: AppStrings.priceCounterText,
                  text2: widget.model.printCounter.toString(),
                ),
              ],
            ),
            CustomSizedBox.height(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subTitleText(
                  text1: AppStrings.moneyText,
                  text2: widget.model.money.toString(),
                ),
                subTitleText(
                  text1: AppStrings.moneyTypeText,
                  text2: widget.model.moneyType,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget subTitleText({
    required String text1,
    required String text2,
  }) {
    return RichText(
      text: TextSpan(
        text: '$text1: ',
        style: Styles.circularStdMedium(
          AppSize.text13.sp,
          widget.color == AppColors.primaryColor
              ? AppColors.whiteColor
              : AppColors.containerTextColor,
        ),
        children: <TextSpan>[
          TextSpan(
            text: text2,
            style: Styles.segoeUI(
              AppSize.text13.sp,
              widget.color == AppColors.primaryColor
                  ? AppColors.whiteColor
                  : AppColors.containerTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget titleText({
    required String text,
  }) {
    return Text(
      text,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: Styles.circularStdMedium(
        AppSize.text16.sp,
        widget.color == AppColors.primaryColor
            ? AppColors.whiteColor
            : AppColors.blackColor,
      ),
    );
  }
}
