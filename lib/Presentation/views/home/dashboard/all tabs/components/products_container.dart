import 'package:grocery/Application/exports.dart';

class ProductContainer extends StatelessWidget {
  final ProductModel model;
  const ProductContainer({
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
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            width: 80.w,
            height: 77.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: CachedNetworkImage(
              imageUrl: model.imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppBorderRadius.dashboardSliderBorderRadius,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => LoadingIndicator.loading(),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: AppSize.icon28.r,
              ),
            ),
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
              subTitleText(
                  AppStrings.quantityText, model.productQuantity.toString()),
            ],
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
}
