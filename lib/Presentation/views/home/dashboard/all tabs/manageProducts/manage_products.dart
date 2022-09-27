import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/colors_palette.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/manage_products_upper_tiles.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/products_container.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/components/search_text_field.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/manageProducts/manage_products_view_model.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  final searchController = TextEditingController();
  bool isProductSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.manageProductText,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.p10).r,
          child: Column(
            children: [
              CustomSizedBox.height(20),
              ManageProductsUpperTiles(
                isProductSelected: isProductSelected,
                productsTap: () {
                  setState(() {
                    isProductSelected = true;
                  });
                },
                categoriesTap: () {
                  setState(() {
                    isProductSelected = false;
                  });
                },
              ),
              CustomSizedBox.height(20),
              SearchTextField(controller: searchController),
              CustomSizedBox.height(20),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: ManageProductsViewModel.productList.length,
                    itemBuilder: (context, index) {
                      var singleData =
                          ManageProductsViewModel.productList[index];
                      return ProductContainer(model: singleData);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
