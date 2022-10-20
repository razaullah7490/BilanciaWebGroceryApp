import "package:flutter/material.dart";

import '../../../../../resources/app_strings.dart';

class WebPortalScreen extends StatelessWidget {
  const WebPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: const Center(
        child: Text(
          AppStrings.routeErrorMessage,
        ),
      ),
    );
  }
}
