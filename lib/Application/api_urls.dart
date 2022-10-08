const String baseUrl = "https://app.bilanciaweb.it/api";

class ApiUrls {
  //auth
  static const String registerUrl = "$baseUrl/auth/register";
  static const String loginUrl = "$baseUrl/auth/login";

  //manager
  static const String ivaUrl = "$baseUrl/manager/iva/";
  static const String categoryUrl = "$baseUrl/manager/category/";
  static const String productUrl = "$baseUrl/insights/product";
  static const String ingredientsUrl = "$baseUrl/manager/ingredient/";
  static const String resourcesUrl = "$baseUrl/manager/resource/";
  static const String resourcesActionUrl = "$baseUrl/manager/resource-action/";
  static const String userUrl = "$baseUrl/auth/user";
  static const String proceedResourceUrl =
      "$baseUrl/manager/processed-resource/";
}
