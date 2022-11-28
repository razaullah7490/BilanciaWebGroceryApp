import 'package:grocery/Application/exports.dart';

class ProductionParkTileShimmerEffect extends StatelessWidget {
  const ProductionParkTileShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(AppSize.p10).r,
        children: [
          Shimmer.fromColors(
            enabled: true,
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 5,
              itemBuilder: (_, __) => placeHolderRow(),
              separatorBuilder: (_, __) => const SizedBox(height: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget placeHolderRow() => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSize.m8,
          vertical: AppSize.m4,
        ).r,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p14,
          vertical: AppSize.p12,
        ).r,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w),
          borderRadius:
              BorderRadius.circular(AppBorderRadius.allDetailContainerRadius.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150.w,
                  height: 8.0,
                  color: Colors.white,
                ),
                Container(
                  width: 18.w,
                  height: 18.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(),
                  ),
                ),
              ],
            ),
            CustomSizedBox.height(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 90.w,
                  height: 8.0,
                  color: Colors.white,
                ),
                Container(
                  width: 70.w,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
            CustomSizedBox.height(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 70.w,
                  height: 8.0,
                  color: Colors.white,
                ),
                Container(
                  width: 90.w,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
            CustomSizedBox.height(4),
          ],
        ),
      );
}
