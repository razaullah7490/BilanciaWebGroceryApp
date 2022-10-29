import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Domain/models/inventory/resources_model.dart';
import 'package:grocery/Presentation/common/shimmer%20effect/product_list_tile_shimmer.dart';
import '../../../../../common/app_bar.dart';
import '../../../../../common/data_not_available_text.dart';
import '../../../../../resources/app_strings.dart';
import '../../../../../resources/sized_box.dart';
import '../components/category_detail_container.dart';
import '../components/product_detail_container.dart';
import '../resources/bloc/resource_cubit.dart';

class ProductsAssociatedToCategory extends StatefulWidget {
  final CategoryData categoryData;
  const ProductsAssociatedToCategory({
    super.key,
    required this.categoryData,
  });

  @override
  State<ProductsAssociatedToCategory> createState() =>
      _ProductsAssociatedToCategoryState();
}

class _ProductsAssociatedToCategoryState
    extends State<ProductsAssociatedToCategory> {
  @override
  void initState() {
    context.read<ResourceCubit>().getResource();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.productsText,
      ),
      body: Column(
        children: [
          CustomSizedBox.height(10),
          BlocBuilder<ResourceCubit, ResourceState>(builder: (context, state) {
            Iterable<ResourcesModel> isExist = state.resourceModel.where((e) {
              return e.category == widget.categoryData.id;
            });

            var newList = List.from(isExist);

            if (state.status == ResourceEnum.loading) {
              return const ProductListTileShimmerEffect();
            }
            return newList.isEmpty
                ? DataNotAvailableText.withExpanded(
                    AppStrings.noResourcesAddedText,
                  )
                : Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: newList.length,
                        itemBuilder: (context, index) {
                          var singleData = newList[index];
                          return ProductDetailContainer(model: singleData);
                        }),
                  );
          }),
        ],
      ),
    );
  }
}
