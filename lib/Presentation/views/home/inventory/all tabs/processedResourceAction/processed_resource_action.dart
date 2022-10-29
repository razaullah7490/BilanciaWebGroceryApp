import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/list_tile_shimmer.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/proceed_resource_action_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/proceed_resource_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/addEditDeleteProceedAction/add_proceed_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/bloc/proceed_resource_action_cubit.dart';
import '../../../../../common/add_item_button.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../common/loading_indicator.dart';
import '../../../../../resources/app_strings.dart';
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
  void initState() {
    Future.wait([
      context.read<ProceedResourceActionCubit>().getProceedResourceAction(),
    ]);
    super.initState();
  }

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
            onTap: () {
              final args = ProceedResourceData(
                id: 0,
                name: "",
                isInventoryAction: true,
              );

              Navigate.to(context, AddProceedResourceActionScreen(model: args));
            },
          ),
          CustomSizedBox.height(15),
          BlocBuilder<ProceedResourceActionCubit, ProceedResourceActionState>(
              builder: (context, state) {
            if (state.status == ProceedResourceActionEnum.loading) {
              return const ListTileShimmerEffect();
            }
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
