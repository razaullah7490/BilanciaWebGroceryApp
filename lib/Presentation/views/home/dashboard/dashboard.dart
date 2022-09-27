import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/resources/text_styles.dart';
import 'package:grocery/Presentation/views/home/dashboard/components/dashboard_app_bar.dart';
import 'package:grocery/Presentation/views/home/dashboard/components/dashboard_grid_tile.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashBoardLargeAppBar(),
            CustomSizedBox.height(15),
            titleText(),
            CustomSizedBox.height(15),
            const DashBoardGridTile(),
          ],
        ),
      ),
    );
  }

  Widget titleText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSize.p10).r,
      child: Text(
        AppStrings.dashboardText,
        style: Styles.circularStdBook(
          AppSize.text25.sp,
          AppColors.blackColor,
        ),
      ),
    );
  }
}
