const String baseUrl = "https://app.bilanciaweb.it/api";

class ApiUrls {
  static const String registerUrl = "$baseUrl/auth/register";
  static const String loginUrl = "$baseUrl/auth/login";
  static const String ivaUrl = "$baseUrl/manager/iva/";
  static const String categoryUrl = "$baseUrl/manager/category/";
  static const String productUrl = "$baseUrl/insights/product";
  static const String ingredientsUrl = "$baseUrl/manager/ingredient/";
  static const String resourcesUrl = "$baseUrl/manager/resource/";
  static const String resourcesActionUrl = "$baseUrl/manager/resource-action/";
  static const String userUrl = "$baseUrl/auth/user";
  static const String deleteUrl = "$baseUrl/auth/delete";
  static const String proceedResourceUrl =
      "$baseUrl/manager/processed-resource/";
  static const String changePasswordUrl = "$baseUrl/auth/change-password/";
  static const String logoutUrl = "$baseUrl/auth/logout";
  static const String proceedResourceActionUrl =
      "$baseUrl/manager/processed-resource-action/";
  static const String requestPasswordResetUrl = "$baseUrl/auth/password_reset/";
  static const String getAllUsersUrl = "$baseUrl/manager/list_users";
  static const String tagUrl = "$baseUrl/agenda/tag/";
  static const String eventUrl = "$baseUrl/agenda/event/";
  static const String notificationUrl = "$baseUrl/manager/notification";
  static const String productionParkUrl = "$baseUrl/manager/production-park/";
  static const String commandUrl = "$baseUrl/manager/microserver";
  static const String exportUrl = "$baseUrl/manager/warehouse/";
}
