import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/setting_components_container.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/setting_view_model.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.settingText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p12).r,
        child: Column(
          children: [
            CustomSizedBox.height(20),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: SettingViewModel.settingList.length,
                  itemBuilder: (context, index) {
                    var singleData = SettingViewModel.settingList[index];
                    return SettingComponentsContainer(model: singleData);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
