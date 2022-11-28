import 'package:grocery/Application/exports.dart';

class ResorucesScreen extends StatefulWidget {
  const ResorucesScreen({super.key});

  @override
  State<ResorucesScreen> createState() => _ResorucesScreenState();
}

class _ResorucesScreenState extends State<ResorucesScreen> {
  final searchController = TextEditingController();
  bool isLoad = false;
  @override
  void initState() {
    Future.wait([
      context.read<ResourceCubit>().getResource(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchResourceList = context.watch<ResourceCubit>().searchList;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.resourcesText,
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
                          .read<ResourceCubit>()
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
                        await context.read<ResourceCubit>().searching(barcode);
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
            text: AppStrings.addResourceText,
            onTap: () => Navigate.to(context, const AddResourceScreen()),
            //Navigator.pushNamed(context, RoutesNames.addResourceScreen),
          ),
          CustomSizedBox.height(25),
          BlocBuilder<ResourceCubit, ResourceState>(builder: (context, state) {
            if (state.status == ResourceEnum.loading) {
              return const ListTileShimmerEffect();
            }
            return state.resourceModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noResourcesAddedText,
                  )
                : searchResourceList.isEmpty && isLoad == true
                    ? noProductFound()
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: isLoad == true
                                ? searchResourceList.length
                                : state.resourceModel.length,
                            itemBuilder: (context, index) {
                              var singleData = isLoad == true
                                  ? searchResourceList[index]
                                  : state.resourceModel[index];
                              return ResourceDetailContainer(model: singleData);
                            }),
                      );
          }),
        ],
      ),
    );
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
