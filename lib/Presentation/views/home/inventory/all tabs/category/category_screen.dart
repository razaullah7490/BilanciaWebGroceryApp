import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/data_not_available_text.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/list_tile_shimmer.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/addEditDeleteCategory/add_category.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/bloc/category_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/category_detail_container.dart';
import '../../../../../resources/routes/navigation.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    Future.wait([
      context.read<CategoryCubit>().getCategory(),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.categoriesText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addCategoryText,
            onTap: () => Navigate.to(context, const AddCategoryScreen()),
            //    Navigator.pushNamed(context, RoutesNames.addCategoryScreen),
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
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.categoryModel.length,
                      itemBuilder: (context, index) {
                        var singleData = state.categoryModel[index];
                        log("Single Data ${singleData.status.runtimeType}");
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
