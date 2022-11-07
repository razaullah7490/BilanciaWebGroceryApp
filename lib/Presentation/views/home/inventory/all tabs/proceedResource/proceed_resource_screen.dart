// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/proceed_resource_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/addEditDeleteProceedResource/add_proceed_resource.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/bloc/proceed_resource_cubit.dart';
import '../../../../../../Application/Prefs/app_prefs.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../common/shimmer effect/list_tile_shimmer.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/routes/navigation.dart';
import '../components/production_park_dailogue.dart';
import '../components/single_searchable_drop_down.dart';
import '../processedResourceAction/productionParkBloc/production_park_cubit.dart';

class ProceedResourceScreen extends StatefulWidget {
  const ProceedResourceScreen({super.key});

  @override
  State<ProceedResourceScreen> createState() => _ProceedResourceScreenState();
}

class _ProceedResourceScreenState extends State<ProceedResourceScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<ProceedResourceCubit>().getProceedResource(),
    ]);
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
      appBar: const CustomAppBar(
        title: AppStrings.processedResourceText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addProccedText,
            onTap: () => Navigate.to(context, const AddProceedResource()),
            //Navigate.to(context, const SingleSearchableDropDown()),
          ),
          CustomSizedBox.height(25),
          BlocBuilder<ProceedResourceCubit, ProceedResourceState>(
              builder: (context, state) {
            if (state.status == ProceedResourceEnum.loading) {
              return const ListTileShimmerEffect();
            }
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

  Future<void> productionParkDialogue(BuildContext context) async {
    return showDialog<void>(
        barrierColor: AppColors.deleteDialogueBarrierColor,
        context: context,
        builder: (BuildContext context) {
          return const ProductionParkDialogue();
        });
  }
}
