import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/proceed_resource_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/bloc/proceed_resource_cubit.dart';

import '../../../../../common/data_not_available_text.dart';

class ProceedResourceScreen extends StatefulWidget {
  const ProceedResourceScreen({super.key});

  @override
  State<ProceedResourceScreen> createState() => _ProceedResourceScreenState();
}

class _ProceedResourceScreenState extends State<ProceedResourceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.processedResourceText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addProccedText,
            onTap: () => Navigator.pushNamed(
                context, RoutesNames.addProceedResourceScreen),
          ),
          CustomSizedBox.height(25),
          BlocBuilder<ProceedResourceCubit, ProceedResourceState>(
              builder: (context, state) {
            return state.proceedResourceModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noProceedResourceAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.proceedResourceModel.length,
                        itemBuilder: (context, index) {
                          var singleData = state.proceedResourceModel[index];
                          return ProceedResourceDetailContainer(
                              model: singleData);
                        }),
                  );
          })
        ],
      ),
    );
  }
}
