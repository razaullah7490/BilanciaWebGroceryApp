// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../../../Domain/models/inventory/products_model.dart';

class ManageProductsViewModel {
  static List<ProductModel> productList = [
    ProductModel(
      productName: "Vegetables",
      productID: 1,
      productQuantity: 50,
      imageUrl:
          "https://hips.hearstapps.com/hmg-prod/images/healthy-groceries-1525213305.jpg",
    ),
    ProductModel(
      productName: "Oil",
      productID: 2,
      productQuantity: 100,
      imageUrl:
          "https://img.freepik.com/premium-photo/shopping-basket-full-food-groceries-table-supermarket_8087-1865.jpg?w=2000",
    ),
    ProductModel(
      productName: "Eggs",
      productID: 3,
      productQuantity: 150,
      imageUrl:
          "https://media.istockphoto.com/photos/all-your-necessities-stored-in-one-place-picture-id1157106624?k=20&m=1157106624&s=612x612&w=0&h=jLXRK4qRL_3QITpschx1Wy2Aj2Vyy47Q1Q_R7hVcPQg=",
    ),
    ProductModel(
      productName: "Pasta",
      productID: 4,
      productQuantity: 200,
      imageUrl:
          "https://hips.hearstapps.com/hmg-prod/images/healthy-groceries-1525213305.jpg",
    ),
    ProductModel(
      productName: "Rice",
      productID: 5,
      productQuantity: 250,
      imageUrl:
          "https://img.freepik.com/premium-photo/shopping-basket-full-food-groceries-table-supermarket_8087-1865.jpg?w=2000",
    ),
  ];
}
