import 'package:grocery/Application/exports.dart';

class DashBoardGridTile extends StatelessWidget {
  const DashBoardGridTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: DashBoardViewModel.dashBoardList.length,
        itemBuilder: (context, index) {
          var singleData = DashBoardViewModel.dashBoardList[index];
          return FadeAnimation(
              delay: index.toDouble(),
              child: buildGridContainer(context, singleData));
        },
      ),
    );
  }

  Widget buildGridContainer(
      BuildContext context, DashBoardGridModel singleData) {
    return GestureDetector(
      onTap: () => Navigate.to(context, singleData.onTap),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(
                horizontal: AppSize.m10, vertical: AppSize.m8)
            .r,
        decoration: BoxDecoration(
          color: singleData.backgroundColor,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.dashboardGridContainerBorderRadius,
          ).r,
          border: Border.all(
            color: singleData.borderColor,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSize.p18,
                vertical: AppSize.p10,
              ).r,
              decoration: BoxDecoration(
                color: singleData.iconColor,
                borderRadius: BorderRadius.circular(
                  AppBorderRadius.dashboardContainerBorderRadius,
                ),
              ),
              child:
                  Image.asset(singleData.imageUrl, width: 50.w, height: 50.h),
            ),
            Text(
              singleData.name,
              style: Styles.circularStdBook(
                AppSize.text15.sp,
                AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
