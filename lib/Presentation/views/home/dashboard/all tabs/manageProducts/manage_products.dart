import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/loading_indicator.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/manage_products_upper_tiles.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/products_container.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/search_text_field.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/manageProducts/manage_products_view_model.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/bloc/category_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/category_detail_container.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../resources/assets.dart';
import '../../../../../resources/border_radius.dart';
import '../../../../../resources/text_styles.dart';
import '../../../inventory/all tabs/components/product_detail_container.dart';
import '../../../inventory/all tabs/resources/bloc/resource_cubit.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final searchController = TextEditingController();
  bool isProductSelected = true;
  bool isLoad = false;
  @override
  void initState() {
    Future.wait([
      context.read<CategoryCubit>().getCategory(),
      context.read<ResourceCubit>().getResource(),
    ]);
    super.initState();
  }

  Pattern pattern = "-1";
  String scanResult = "";

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
              //CustomSizedBox.height(20),
              // ManageProductsUpperTiles(
              //   isProductSelected: isProductSelected,
              //   productsTap: () {
              //     setState(() {
              //       isProductSelected = true;
              //     });
              //   },
              //   categoriesTap: () {
              //     setState(() {
              //       isProductSelected = false;
              //     });
              //   },
              // ),
              CustomSizedBox.height(15),

              Row(
                children: [
                  Flexible(
                    child: SearchTextField(
                      controller: searchController,
                      onChanged: (v) {
                        setState(() {
                          context
                              .read<ResourceCubit>()
                              .searching(searchController.text);
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
                  barCodeWidget(),
                ],
              ),
              CustomSizedBox.height(10),
              if (isLoad == false)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(AppStrings.allCategoriesText),
                      BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                        if (state.status == CategoryEnum.loading) {
                          return LoadingIndicator.loadingExpanded();
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

  Widget barCodeWidget() {
    return GestureDetector(
      onTap: () async {
        await scanBarcode();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 50.w,
        height: 47.w,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius:
              BorderRadius.circular(AppBorderRadius.barcodeContainerRadius.r),
        ),
        child: Center(
          child: Image.asset(
            Assets.barcode,
            width: 26.w,
            height: 26.w,
          ),
        ),
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
          AppColors.containerTextColor,
        ),
      ),
    );
  }

  Future scanBarcode() async {
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        "#52B467",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      scanResult = "Failed, Please try again!!!";
    }

    if (!mounted) return;
    if (scanResult.isNotEmpty) {
      setState(() {
        searchController.text =
            scanResult.contains(pattern) ? "" : scanResult.toString();
        isLoad = true;
      });
    }
  }
}
