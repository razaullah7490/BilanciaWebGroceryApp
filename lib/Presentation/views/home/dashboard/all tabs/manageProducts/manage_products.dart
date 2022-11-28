import 'dart:developer';
import 'package:grocery/Application/exports.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final searchController = TextEditingController();
  //bool isProductSelected = true;
  bool isLoad = false;

  @override
  void initState() {
    Future.wait([
      context.read<CategoryCubit>().getCategory(),
      context.read<ResourceCubit>().getResource(),
    ]);
    super.initState();
  }

  // Pattern pattern = "-1";
  // String scanResult = "";

  @override
  Widget build(BuildContext context) {
    var searchResourceList = context.watch<ResourceCubit>().searchList;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.manageProductText,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.p10).r,
          child: Column(
            children: [
              CustomSizedBox.height(15),
              Row(
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
                      suffixIcon: isLoad
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
                          log("Barcode $barcode");
                          await context
                              .read<ResourceCubit>()
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
              CustomSizedBox.height(15),
              if (isLoad == false)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(AppStrings.allCategoriesText),
                      CustomSizedBox.height(5),
                      BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                        if (state.status == CategoryEnum.loading) {
                          return const ListTileShimmerEffect();
                        }
                        return state.categoryModel.isEmpty
                            ? DataNotAvailableText.withExpanded(
                                AppStrings.noCategoryAddedText,
                              )
                            : Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: state.categoryModel.length,
                                    itemBuilder: (context, index) {
                                      var singleData =
                                          state.categoryModel[index];
                                      return CategoryDetailContainer(
                                          model: singleData);
                                    }),
                              );
                      }),
                    ],
                  ),
                ),
              if (isLoad == true)
                BlocConsumer<ResourceCubit, ResourceState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state.status == ResourceEnum.loading) {
                        return LoadingIndicator.loadingExpanded();
                      }
                      return state.resourceModel.isEmpty
                          ? DataNotAvailableText.withExpanded(
                              AppStrings.noResourcesAddedText,
                            )
                          : searchResourceList.isEmpty
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

                                        return ProductDetailContainer(
                                            model: singleData);
                                      }),
                                );
                    }),
            ],
          ),
        ),
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

  Widget titleText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSize.p10,
        vertical: AppSize.p6,
      ).r,
      child: Text(
        text,
        style: Styles.circularStdMedium(
          AppSize.text17.sp,
          AppColors.primaryColor,
        ),
      ),
    );
  }

  // Future scanBarcode() async {
  //   try {
  //     scanResult = await FlutterBarcodeScanner.scanBarcode(
  //       "#52B467",
  //       "Cancel",
  //       true,
  //       ScanMode.BARCODE,
  //     );
  //   } on PlatformException {
  //     scanResult = "Failed, Please try again!!!";
  //   }
  //   if (!mounted) return;
  //   if (scanResult.isNotEmpty) {
  //     setState(() {
  //       isLoad = true;
  //       searchController.text =
  //           scanResult.contains(pattern) ? "" : scanResult.toString();
  //     });
  //   }
  // }
}
