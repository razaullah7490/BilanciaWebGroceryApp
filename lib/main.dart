import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Data/repository/agenda/event_repository.dart';
import 'package:grocery/Data/repository/agenda/tag_repository.dart';
import 'package:grocery/Data/repository/auth/change_password_repository.dart';
import 'package:grocery/Data/repository/auth/forget_password_repository.dart';
import 'package:grocery/Data/repository/auth/logout_repository.dart';
import 'package:grocery/Data/repository/auth/registration_repository.dart';
import 'package:grocery/Data/repository/auth/user_repository.dart';
import 'package:grocery/Data/repository/manager/all_users_repository.dart';
import 'package:grocery/Data/repository/manager/notification_repository.dart';
import 'package:grocery/Data/repository/manager/proceed_resource_action_repository.dart';
import 'package:grocery/Data/repository/manager/proceed_resource_repository.dart';
import 'package:grocery/Data/repository/manager/production_park_repository.dart';
import 'package:grocery/Data/repository/manager/resource_action_repository.dart';
import 'package:grocery/Data/repository/manager/resources_repository.dart';
import 'package:grocery/Data/services/agenda/event_service.dart';
import 'package:grocery/Data/services/agenda/tag_services.dart';
import 'package:grocery/Data/services/auth/change_password.dart';
import 'package:grocery/Data/services/auth/forget_password_service.dart';
import 'package:grocery/Data/services/auth/login_service.dart';
import 'package:grocery/Data/services/auth/registration_service.dart';
import 'package:grocery/Data/services/auth/user_services.dart';
import 'package:grocery/Data/services/manager/all_users_service.dart';
import 'package:grocery/Data/services/manager/category_service.dart';
import 'package:grocery/Data/services/manager/ingredients_service.dart';
import 'package:grocery/Data/services/manager/iva_service.dart';
import 'package:grocery/Data/services/manager/notification_service.dart';
import 'package:grocery/Data/services/manager/proceed_resource_action_service.dart';
import 'package:grocery/Data/services/manager/proceed_resource_service.dart';
import 'package:grocery/Data/services/manager/production_park_service.dart';
import 'package:grocery/Data/services/manager/resource_action_service.dart';
import 'package:grocery/Data/services/manager/resources_service.dart';
import 'package:grocery/Presentation/views/auth/forget/Bloc/forget_password_cubit.dart';
import 'package:grocery/Presentation/views/auth/forget/setNewPassword/set_new_password.dart';
import 'package:grocery/Presentation/views/auth/login/login_screen.dart';
import 'package:grocery/Presentation/views/auth/register/bloc/registration_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/Bloc/event_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/events/Bloc/participants_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/agenda/tags/Bloc/tags_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/changePassword/Bloc/change_password_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/all%20tabs/settings/logout%20bloc/logout_cubit.dart';
import 'package:grocery/Presentation/views/home/dashboard/notifications/bloc/notification_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/bloc/category_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/ingredients/ingredientsBloc/ingredients_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/bloc/proceed_resource_action_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/productionParkBloc/production_park_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/products/bloc/product_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/bloc/resource_action_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/bloc/resource_cubit.dart';

import 'Data/repository/auth/login_repository.dart';
import 'Data/repository/manager/category_repository.dart';
import 'Data/repository/manager/ingredient_repository.dart';
import 'Data/repository/manager/iva_repository.dart';
import 'Data/services/auth/logout_service.dart';
import 'Presentation/views/auth/login/bloc/login_cubit.dart';
import 'Presentation/views/home/dashboard/all tabs/settings/editProfile/Bloc/user_cubit.dart';
import 'Presentation/views/home/inventory/all tabs/iva/ivaBloc/manager_iva_cubit.dart';
import 'Presentation/views/home/inventory/all tabs/proceedResource/bloc/proceed_resource_cubit.dart';

Future<void> main() async {
  await init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final PendingDynamicLinkData? initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();
  var testLink = await FirebaseDynamicLinks.instance.getInitialLink();
  log("initial ${initialLink?.link ?? "Null"}");
  runApp(
    MyApp(initialLink: initialLink ?? testLink),
  );
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ScreenUtil.ensureScreenSize();
  await Future.delayed(const Duration(seconds: 1), () {
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({
    Key? key,
    required this.initialLink,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: ((context, child) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
                create: (context) => RegistrationRepository(
                      registerationService: RegisterationService(),
                    )),
            RepositoryProvider(
                create: (context) => LoginRepository(
                      loginService: LoginService(),
                    )),
            RepositoryProvider(
                create: (context) => IvaRepository(
                      ivaService: IvaService(),
                    )),
            RepositoryProvider(
                create: (context) => CategoryRepository(
                      catergoryService: CatergoryService(),
                    )),
            RepositoryProvider(
                create: (context) => IngredientRepository(
                      ingredientService: IngredientService(),
                    )),
            RepositoryProvider(
                create: (context) => ResourcesRepository(
                      resourcesService: ResourcesService(),
                    )),
            RepositoryProvider(
                create: (context) => ResourceActionRepository(
                      resourceActionService: ResourceActionService(),
                    )),
            RepositoryProvider(
                create: (context) => UserRepository(
                      userServices: UserServices(),
                    )),
            RepositoryProvider(
                create: (context) => ProceedResourceRepository(
                      proceedResourceService: ProceedResourceService(),
                    )),
            RepositoryProvider(
                create: (context) => ChangePasswordRepository(
                      changePasswordService: ChangePasswordService(),
                    )),
            RepositoryProvider(
                create: (context) => LogoutRepository(
                      logoutService: LogoutService(),
                    )),
            RepositoryProvider(
                create: (context) => ProceedResourceActionRepository(
                      proceedResourceActionService:
                          ProceedResourceActionService(),
                    )),
            RepositoryProvider(
                create: (context) => ForgetPasswordRepository(
                      forgetPasswordService: ForgetPasswordService(),
                    )),
            RepositoryProvider(
                create: (context) => AllUsersRepository(
                      allUsersService: AllUsersService(),
                    )),
            RepositoryProvider(
                create: (context) => TagRepository(
                      tagService: TagService(),
                    )),
            RepositoryProvider(
                create: (context) => EventRepository(
                      eventService: EventService(),
                    )),
            RepositoryProvider(
                create: (context) => NotificationRepository(
                      service: NotificationService(),
                    )),
            RepositoryProvider(
                create: (context) => ProductionParkRepository(
                      service: ProductionParkService(),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider<RegistrationCubit>(
                  create: (context) => RegistrationCubit(
                      repo: context.read<RegistrationRepository>())),
              BlocProvider<LoginCubit>(
                  create: (context) =>
                      LoginCubit(repo: context.read<LoginRepository>())),
              BlocProvider<ManagerIvaCubit>(
                  create: (context) =>
                      ManagerIvaCubit(repo: context.read<IvaRepository>())),
              BlocProvider<CategoryCubit>(
                  create: (context) =>
                      CategoryCubit(repo: context.read<CategoryRepository>())),
              BlocProvider<IngredientsCubit>(
                  create: (context) => IngredientsCubit(
                      repo: context.read<IngredientRepository>())),
              BlocProvider<ResourceCubit>(
                  create: (context) =>
                      ResourceCubit(repo: context.read<ResourcesRepository>())),
              BlocProvider<ResourceActionCubit>(
                  create: (context) => ResourceActionCubit(
                      repo: context.read<ResourceActionRepository>())),
              BlocProvider<ProductCubit>(
                  create: (context) => ProductCubit(modelList: [])),
              BlocProvider<ProceedResourceCubit>(
                  create: (context) => ProceedResourceCubit(
                      repo: context.read<ProceedResourceRepository>())),
              BlocProvider<ProceedResourceActionCubit>(
                  create: (context) => ProceedResourceActionCubit(
                      repo: context.read<ProceedResourceActionRepository>())),
              BlocProvider<UserCubit>(
                  create: (context) =>
                      UserCubit(repo: context.read<UserRepository>())),
              BlocProvider<ChangePasswordCubit>(
                  create: (context) => ChangePasswordCubit(
                      repo: context.read<ChangePasswordRepository>())),
              BlocProvider<LogoutCubit>(
                  create: (context) =>
                      LogoutCubit(repo: context.read<LogoutRepository>())),
              BlocProvider<ForgetPasswordCubit>(
                  create: (context) => ForgetPasswordCubit(
                      repo: context.read<ForgetPasswordRepository>())),
              BlocProvider<ParticipantsCubit>(
                  create: (context) => ParticipantsCubit(
                      repo: context.read<AllUsersRepository>())),
              BlocProvider<TagsCubit>(
                  create: (context) =>
                      TagsCubit(repo: context.read<TagRepository>())),
              BlocProvider<EventCubit>(
                  create: (context) =>
                      EventCubit(repo: context.read<EventRepository>())),
              BlocProvider<NotificationCubit>(
                  create: (context) => NotificationCubit(
                      repo: context.read<NotificationRepository>())),
              BlocProvider<ProductionParkCubit>(
                  create: (context) => ProductionParkCubit(
                      repo: context.read<ProductionParkRepository>())),
            ],
            child: MaterialApp(
              title: 'Bilancia Web',
              debugShowCheckedModeBanner: false,
              home: child,
            ),
          ),
        );
      }),
      child: widget.initialLink == null
          ? const LoginScreen()
          : SetNewPasswordScreen(initialLink: widget.initialLink),
    );
  }
}
