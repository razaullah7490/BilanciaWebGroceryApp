import 'package:grocery/Application/exports.dart';

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
