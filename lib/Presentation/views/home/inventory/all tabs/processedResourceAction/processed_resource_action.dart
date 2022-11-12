// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/list_tile_shimmer.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/proceed_resource_action_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/proceed_resource_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/production_park_dailogue.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/addEditDeleteProceedAction/add_proceed_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/bloc/proceed_resource_action_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/productionParkBloc/production_park_cubit.dart';
import '../../../../../../Application/Prefs/app_prefs.dart';
import '../../../../../common/add_item_button.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/sized_box.dart';
import '../components/actions_pagination.dart';

class ProcessedResourceActionScreen extends StatefulWidget {
  const ProcessedResourceActionScreen({super.key});

  @override
  State<ProcessedResourceActionScreen> createState() =>
      _ProcessedResourceActionScreenState();
}

class _ProcessedResourceActionScreenState
    extends State<ProcessedResourceActionScreen> {
  int totalPages = 0;
  @override
  void initState() {
    Future.wait([
      context.read<ProceedResourceActionCubit>().getProceedResourceAction(1),
    ]).whenComplete(() {
      totalPages = context
          .read<ProceedResourceActionCubit>()
          .state
          .resourceActionModel
          .totalPages!;
      setState(() {});
    });
    showDialogue();
    super.initState();
  }

  showDialogue() async {
    var id = await AppPrefs.getProcessedResourceId();
    if (id.isNotEmpty) {
      var res = await context.read<ProductionParkCubit>().getProductionPark(id);
      if (res.isNotEmpty) {
        await productionParkDialogue(context);
        log("PRODUCTION PARK $res");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ActionsPaginationWidget(
        totalPages: totalPages,
        initialPage: 1,
        onPageChanged: (v) async {
          log("Page $v");
          await context
              .read<ProceedResourceActionCubit>()
              .getProceedResourceAction(v);
        },
      ),
      appBar: const CustomAppBar(
        title: AppStrings.processedResourceActionText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addNewText,
            onTap: () async {
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
            return state.resourceActionModel.results!.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noProceedResourceActionAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.resourceActionModel.results!.length,
                        itemBuilder: (context, index) {
                          var singleData =
                              state.resourceActionModel.results![index];

                          return ProceedResourceActionDetailContainer(
                            resourceActionId: singleData.resourceActionId!,
                            resourceActionName: singleData.resourceActionName!,
                            quantity: singleData.quantity!,
                            money: singleData.money!,
                            moneyType: singleData.moneyType!,
                            priceCounter: singleData.priceCounter!,
                            resource: singleData.resource!,
                            isForInternalUsage: singleData.isForInternalUsage!,
                            dateTime: singleData.dateTime!,
                          );
                        }),
                  );
          }),
        ],
      ),
    );
  }

  Future<void> productionParkDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return const ProductionParkDialogue();
        });
  }
}
