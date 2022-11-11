import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/data_not_available_text.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/list_tile_shimmer.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/addEditDeleteCategory/add_category.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/bloc/category_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/category_detail_container.dart';
import '../../../../../common/not_found_widget.dart';
import '../../../../../resources/colors_palette.dart';
import '../../../../../resources/routes/navigation.dart';
import '../../../../../resources/size.dart';
import '../../../dashboard/all tabs/components/search_text_field.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final searchController = TextEditingController();
  bool isLoad = false;
  @override
  void initState() {
    Future.wait([
      context.read<CategoryCubit>().getCategory(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var searchCategoryList = context.watch<CategoryCubit>().searchList;
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.categoriesText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSize.m10).r,
            child: Row(
              children: [
                Flexible(
                  child: SearchTextField(
                    controller: searchController,
                    onChanged: (v) async {
                      await context
                          .read<CategoryCubit>()
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
              ],
            ),
          ),
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addCategoryText,
            onTap: () => Navigate.to(context, const AddCategoryScreen()),
          ),
          CustomSizedBox.height(15),
          BlocBuilder<CategoryCubit, CategoryState>(builder: ((context, state) {
            if (state.status == CategoryEnum.loading) {
              return const ListTileShimmerEffect();
            }
            return state.categoryModel.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noCategoryAddedText,
                  )
                : searchCategoryList.isEmpty && isLoad == true
                    ? const NotFoundWidget(text: AppStrings.noCategoryFoundText)
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: isLoad == true
                              ? searchCategoryList.length
                              : state.categoryModel.length,
                          itemBuilder: (context, index) {
                            var singleData = isLoad == true
                                ? searchCategoryList[index]
                                : state.categoryModel[index];
                            return CategoryDetailContainer(model: singleData);
                          },
                        ),
                      );
          })),
        ],
      ),
    );
  }
}
