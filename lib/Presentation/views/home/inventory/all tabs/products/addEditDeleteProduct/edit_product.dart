import 'package:grocery/Application/exports.dart';

class EditProductScreen extends StatefulWidget {
  final ProductModel model;
  const EditProductScreen({
    super.key,
    required this.model,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final productNameController = TextEditingController();
  final productQuantityContoller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  File? image;

  @override
  void initState() {
    productNameController.text = widget.model.productName;
    productQuantityContoller.text = widget.model.productQuantity.toString();
    image = File(widget.model.imageUrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editProductText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p22).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              textFields(),
              CustomSizedBox.height(28),
              Align(
                  alignment: Alignment.centerLeft,
                  child: textFieldUpperText(AppStrings.addImageText)),
              CustomSizedBox.height(5),
              Row(
                children: [
                  CustomBottomSheet(
                    onCameraTap: () async {
                      Navigator.of(context).pop();
                      var imagePath =
                          await CustomImagePicker.getImage(ImageSource.camera);
                      setState(() {
                        image = imagePath;
                      });
                    },
                    onGalleryTap: () async {
                      Navigator.of(context).pop();
                      var imagePath =
                          await CustomImagePicker.getImage(ImageSource.gallery);
                      setState(() {
                        image = imagePath;
                      });
                    },
                  ),
                  if (image != null) imageContainer(),
                ],
              ),
              CustomSizedBox.height(60),
              BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                if (state.status == ProductEnum.loading) {
                  return LoadingIndicator.loading();
                }
                return CustomButton(
                  text: AppStrings.updateText,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (image != null) {
                        context.read<ProductCubit>().editProduct(
                              widget.model.productID,
                              ProductModel(
                                productName: productNameController.text,
                                productID: widget.model.productID,
                                productQuantity: double.parse(
                                    productQuantityContoller.text.toString()),
                                imageUrl: image!.path.toString(),
                              ),
                            );

                        Navigator.of(context).pop();
                        SnackBarWidget.buildSnackBar(
                          context,
                          AppStrings.productUpdatedSuccessText,
                          AppColors.greenColor,
                          Icons.check,
                          true,
                        );
                      } else {
                        SnackBarWidget.buildSnackBar(
                          context,
                          AppStrings.pleaseSelectImageText,
                          AppColors.redColor,
                          Icons.close,
                          true,
                        );
                      }
                    }
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget textFields() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSizedBox.height(40),
          CustomTextField(
            controller: productNameController,
            labelText: AppStrings.productNameText,
            hintText: AppStrings.enterProductNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideProductNameText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(30),
          CustomTextField(
            controller: productQuantityContoller,
            labelText: AppStrings.quantityOnlyText,
            hintText: AppStrings.enterQuantityText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.number,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideQuantityText;
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget textFieldUpperText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSize.p2).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style:
                Styles.circularStdBook(AppSize.text15.sp, AppColors.blackColor),
          ),
          CustomSizedBox.height(10),
        ],
      ),
    );
  }

  Widget imageContainer() {
    return Container(
      padding: const EdgeInsets.all(AppSize.p6).r,
      margin: const EdgeInsets.symmetric(horizontal: AppSize.m15).r,
      width: 120.w,
      height: 110.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 1.5.w,
        ),
        borderRadius: BorderRadius.circular(
          AppBorderRadius.chooseImageContainerRadius.r,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppBorderRadius.chooseImageContainerRadius.r,
        ),
        child: Image.file(
          image!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
