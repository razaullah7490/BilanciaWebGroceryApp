import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/services/manager/product_service.dart';
import 'package:grocery/Presentation/common/add_item_button.dart';
import 'package:grocery/Presentation/common/app_bar.dart';
import 'package:grocery/Presentation/common/data_not_available_text.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/navigation.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/resources/size.dart';
import 'package:grocery/Presentation/resources/sized_box.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/products/addEditDeleteProduct/add_product.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/products/bloc/product_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/product_detail_container.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.productsText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(20),
          addItemButtonWidget(
            context: context,
            text: AppStrings.addProductText,
            onTap: () => Navigate.to(context, const AddProductScreen()),
            //Navigator.pushNamed(context, RoutesNames.addProductsScreen),
            // onTap: () async {
            //   dynamic map = {
            //     'insight_type': 'Hi',
            //     'datetime_from': '12345',
            //     'datetime_to': '12345',
            //     'product': '1'
            //   };
            //   await ProductService.addProduct(map);
            // },
          ),
          CustomSizedBox.height(25),
          // BlocBuilder<ProductCubit, ProductState>(
          //   builder: (context, state) {
          //     return state.productModel.isEmpty
          //         ? DataNotAvailableText.withExpanded(
          //             AppStrings.noProductAddedText,
          //           )
          //         : Expanded(
          //             child: Padding(
          //               padding:
          //                   const EdgeInsets.symmetric(horizontal: AppSize.p8)
          //                       .r,
          //               child: ListView.builder(
          //                 shrinkWrap: true,
          //                 physics: const BouncingScrollPhysics(),
          //                 itemCount: state.productModel.length,
          //                 itemBuilder: ((context, index) {
          //                   var singleData = state.productModel[index];
          //                   return ProductDetailContainer(model: singleData);
          //                 }),
          //               ),
          //             ),
          //           );
          //   },
          // )
        ],
      ),
    );
  }
}
