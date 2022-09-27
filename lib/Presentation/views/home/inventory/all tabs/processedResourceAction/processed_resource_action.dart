import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/proceed_resource_action_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/bloc/proceed_resource_action_cubit.dart';

import '../../../../../common/add_item_button.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/routes/routes_names.dart';
import '../../../../../resources/sized_box.dart';

class ProcessedResourceActionScreen extends StatefulWidget {
  const ProcessedResourceActionScreen({super.key});

  @override
  State<ProcessedResourceActionScreen> createState() =>
      _ProcessedResourceActionScreenState();
}

class _ProcessedResourceActionScreenState
    extends State<ProcessedResourceActionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.processedResourceActionText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addNewText,
            onTap: () => Navigator.pushNamed(
                context, RoutesNames.addProceedResourceActionsScreen),
          ),
          CustomSizedBox.height(25),
          BlocBuilder<ProceedResourceActionCubit, ProceedResourceActionState>(
              builder: (context, state) {
            return state.resourceActionModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noProceedResourceActionAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.resourceActionModel.length,
                        itemBuilder: (context, index) {
                          var singleData = state.resourceActionModel[index];
                          return ProceedResourceActionDetailContainer(
                              model: singleData);
                        }),
                  );
          }),
        ],
      ),
    );
  }
}
