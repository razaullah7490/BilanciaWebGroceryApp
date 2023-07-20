import 'dart:developer';

import 'package:grocery/Application/Cubit/delete_account_cubit.dart';

import 'Application/exports.dart';

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
            RepositoryProvider(
                create: (context) =>
                    CommandRepository(service: CommandService())),
            RepositoryProvider(
                create: (context) => ExportRepository(
                      service: ExportService(),
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
              BlocProvider<CommandCubit>(
                  create: (context) =>
                      CommandCubit(repo: context.read<CommandRepository>())),
              BlocProvider<ExportCubit>(
                  create: (context) =>
                      ExportCubit(repo: context.read<ExportRepository>())),
              BlocProvider<DeleteAccountCubit>(
                  create: (context) => DeleteAccountCubit())
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
