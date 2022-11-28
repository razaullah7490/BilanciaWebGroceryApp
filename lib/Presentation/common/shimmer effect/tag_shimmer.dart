import 'package:grocery/Application/exports.dart';

class TagListTileShimmerEffect extends StatelessWidget {
  const TagListTileShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(AppSize.p6).r,
        children: [
          Shimmer.fromColors(
            enabled: true,
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: AppSize.p2).r,
                child: placeHolderRow(),
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 2),
            ),
          ),
        ],
      ),
    );
  }

  Widget placeHolderRow() => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p18,
          vertical: AppSize.p15,
        ).r,
        margin: const EdgeInsets.symmetric(
          vertical: AppSize.m4,
          horizontal: AppSize.m8,
        ).r,
        decoration: BoxDecoration(
          border: Border.all(width: 1.w),
          borderRadius:
              BorderRadius.circular(AppBorderRadius.allDetailContainerRadius.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox.height(5),
                Container(
                  width: 120.w,
                  height: 8.0,
                  color: Colors.white,
                ),
                CustomSizedBox.height(4),
                Container(
                  width: 90.w,
                  height: 8.0,
                  color: Colors.white,
                ),
              ],
            ),
            Container(
              width: 55.w,
              height: 21.h,
              decoration: BoxDecoration(
                border: Border.all(width: 1.w),
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ],
        ),
      );
}
