import 'package:flutter/material.dart';
import 'package:grocery/Presentation/resources/app_strings.dart';
import 'package:grocery/Presentation/resources/routes/routes_names.dart';
import 'package:grocery/Presentation/views/auth/forget/confirmation/confirmation_screen.dart';
import 'package:grocery/Presentation/views/auth/forget/forgetPassword/forget_password.dart';
import 'package:grocery/Presentation/views/auth/forget/passwordRecovered/successfully_recoverd_password.dart';
import 'package:grocery/Presentation/views/auth/forget/setNewPassword/set_new_password.dart';
import 'package:grocery/Presentation/views/auth/login/login_screen.dart';
import 'package:grocery/Presentation/views/auth/register/register_screen.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/manageProducts/manage_products.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/changePassword/change_password_screen.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/editProfile/edit_profile_screen.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/notificationSetting/notification_setting.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/setting_screen.dart';

import 'package:grocery/Presentation/views/home/dashboard/dashboard.dart';
import 'package:grocery/Presentation/views/home/dashboard/notifications/notifications_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/category_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/products_associated_category.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/category_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/components/product_detail_container.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/addEditDeleteProceedResource/add_proceed_resource.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/addEditDeleteProceedResource/edit_proceed_resource.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/proceedResource/proceed_resource_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/addEditDeleteProceedAction/add_proceed_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/addEditDeleteProceedAction/edit_proceed_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/processed_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/addEditDeleteResourceActions/add_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/addEditDeleteResourceActions/edit_resource_action.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/resource_actions_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/addEditDeleteResource/add_resource.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/addEditDeleteResource/edit_resource.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/resources_screen.dart';
import 'package:grocery/Presentation/views/home/inventory/inventory.dart';

import 'package:page_transition/page_transition.dart';

import '../../../Domain/models/inventory/category_model.dart';
import '../../../Domain/models/inventory/proceed_resource_action_model.dart';
import '../../../Domain/models/inventory/proceed_resource_model.dart';
import '../../../Domain/models/inventory/products_model.dart';
import '../../../Domain/models/inventory/resource_action_model.dart';
import '../../../Domain/models/inventory/resources_model.dart';
import '../../views/home/inventory/all tabs/category/addEditDeleteCategory/add_category.dart';
import '../../views/home/inventory/all tabs/category/addEditDeleteCategory/edit_category.dart';
import '../../views/home/inventory/all tabs/products/addEditDeleteProduct/add_product.dart';
import '../../views/home/inventory/all tabs/products/addEditDeleteProduct/edit_product.dart';
import '../../views/home/inventory/all tabs/products/product_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case RoutesNames.loginScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const LoginScreen(),
        settings: routeSettings,
      );

    case RoutesNames.registerScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const RegisterScreen(),
        settings: routeSettings,
      );

    case RoutesNames.forgetPasswordScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ForgetPasswordScreen(),
        settings: routeSettings,
      );

    case RoutesNames.confirmationScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ConfirmationScreen(),
        settings: routeSettings,
      );

    case RoutesNames.setNewPasswordScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const SetNewPasswordScreen(),
        settings: routeSettings,
      );

    case RoutesNames.successfullyRecoveredPasswordScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const SuccessfullyRecoveredPasswordScreen(),
        settings: routeSettings,
      );

    case RoutesNames.dashboardScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const DashBoardScreen(),
        settings: routeSettings,
      );

    case RoutesNames.notificationScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const NotificationScreen(),
        settings: routeSettings,
      );

    case RoutesNames.inventoryScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const Inventory(),
        settings: routeSettings,
      );

    case RoutesNames.manageProductsScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ManageProductsScreen(),
        settings: routeSettings,
      );

    case RoutesNames.settingScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const SettingScreen(),
        settings: routeSettings,
      );

    case RoutesNames.editProfileScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const EditProfileScreen(),
        settings: routeSettings,
      );

    case RoutesNames.changePasswordScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ChangePasswordScreen(),
        settings: routeSettings,
      );

    case RoutesNames.notificationSettingScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const NotificationSettingScreen(),
        settings: routeSettings,
      );

    case RoutesNames.productsScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ProductsScreen(),
        settings: routeSettings,
      );

    case RoutesNames.addProductsScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const AddProductScreen(),
        settings: routeSettings,
      );

    case RoutesNames.editProductsScreen:
      final ProductModel args = routeSettings.arguments as ProductModel;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: EditProductScreen(model: args),
        settings: routeSettings,
      );

    case RoutesNames.categoryScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const CategoryScreen(),
        settings: routeSettings,
      );

    case RoutesNames.addCategoryScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const AddCategoryScreen(),
        settings: routeSettings,
      );

    case RoutesNames.editCategoryScreen:
      final CategoryModel args = routeSettings.arguments as CategoryModel;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: EditCategoryScreen(model: args),
        settings: routeSettings,
      );

    case RoutesNames.resourcesScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ResorucesScreen(),
        settings: routeSettings,
      );

    case RoutesNames.addResourceScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const AddResourceScreen(),
        settings: routeSettings,
      );

    case RoutesNames.editResourceScreen:
      final ResourcesModel args = routeSettings.arguments as ResourcesModel;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: EditResourceScreen(model: args),
        settings: routeSettings,
      );

    case RoutesNames.resourceActionsScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ResourceActionsScreen(),
        settings: routeSettings,
      );

    case RoutesNames.addResourceActionsScreen:
      final ResourceData args = routeSettings.arguments as ResourceData;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: AddResourceActionScreen(resourceData: args),
        settings: routeSettings,
      );

    case RoutesNames.editResourceActionsScreen:
      final ResourceActionModel args =
          routeSettings.arguments as ResourceActionModel;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: EditResourceActionScreen(model: args),
        settings: routeSettings,
      );

    case RoutesNames.proceedResourceScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ProceedResourceScreen(),
        settings: routeSettings,
      );

    case RoutesNames.addProceedResourceScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const AddProceedResource(),
        settings: routeSettings,
      );

    case RoutesNames.editProceedResourceScreen:
      final ProceedResourcesModel args =
          routeSettings.arguments as ProceedResourcesModel;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: EditProceedResourceScreen(model: args),
        settings: routeSettings,
      );

    case RoutesNames.proceedResourceActionsScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const ProcessedResourceActionScreen(),
        settings: routeSettings,
      );

    case RoutesNames.addProceedResourceActionsScreen:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const AddProceedResourceActionScreen(),
        settings: routeSettings,
      );

    case RoutesNames.editProceedResourceActionsScreen:
      final ProcessedResourceActionModel args =
          routeSettings.arguments as ProcessedResourceActionModel;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: EditProceedResourceAction(model: args),
        settings: routeSettings,
      );

    case RoutesNames.productsAssociatedToCategoryScreen:
      final CategoryData args = routeSettings.arguments as CategoryData;
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: ProductsAssociatedToCategory(categoryData: args),
        settings: routeSettings,
      );

    default:
      return PageTransition(
        type: PageTransitionType.topToBottom,
        child: const CustomRouteErrorScreen(),
        settings: routeSettings,
      );
  }
}

class CustomRouteErrorScreen extends StatelessWidget {
  const CustomRouteErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5,
      ),
      body: const Center(
        child: Text(
          AppStrings.routeErrorMessage,
        ),
      ),
    );
  }
}
