// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:grocery/Application/exports.dart';

class ProceedResourceScreen extends StatefulWidget {
  const ProceedResourceScreen({super.key});

  @override
  State<ProceedResourceScreen> createState() => _ProceedResourceScreenState();
}

class _ProceedResourceScreenState extends State<ProceedResourceScreen> {
  final searchController = TextEditingController();
  bool isLoad = false;
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
    var searchResourceList = context.watch<ProceedResourceCubit>().searchList;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.processedResourceText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.p10).r,
            child: Row(
              children: [
                Flexible(
                  child: SearchTextField(
                    controller: searchController,
                    onChanged: (v) async {
                      await context
                          .read<ProceedResourceCubit>()
                          .searching(searchController.text);
                      setState(() {
                        isLoad = true;
                      });
                    },
                    suffixIcon: isLoad && searchController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                searchController.clear();
                                isLoad = false;
                              });
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Icon(
                              Icons.close,
                              size: AppSize.clearSearchTextFieldIconSize.r,
                              color: AppColors.hintTextColor,
                            ),
                          )
                        : const Text(""),
                  ),
                ),
                CustomSizedBox.width(10),
                SearchBarcodeWidget(
                  onTap: () async {
                    Navigate.to(context, BarcodeScanner(
                      getBarcode: (barcode) async {
                        await context
                            .read<ProceedResourceCubit>()
                            .searching(barcode);
                        setState(() {
                          searchController.text = barcode;
                          isLoad = true;
                        });
                      },
                    ));
                  },
                ),
              ],
            ),
          ),
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
                : searchResourceList.isEmpty && isLoad == true
                    ? noProductFound()
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: isLoad == true
                                ? searchResourceList.length
                                : state.proceedResourceModel.length,
                            itemBuilder: (context, index) {
                              var singleData = isLoad == true
                                  ? searchResourceList[index]
                                  : state.proceedResourceModel[index];
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

  Expanded noProductFound() {
    return Expanded(
      child: Image.asset(
        Assets.noProductFound,
        color: AppColors.primaryColor,
        width: 200.w,
        height: 200.h,
      ),
    );
  }
}
