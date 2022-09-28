import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Data/repository/auth/registration_repository.dart';
import 'package:grocery/Data/services/auth/login_service.dart';
import 'package:grocery/Data/services/auth/registration_service.dart';
import 'package:grocery/Data/services/manager/category_service.dart';
import 'package:grocery/Data/services/manager/iva_service.dart';
import 'package:grocery/Presentation/resources/routes/routes_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grocery/Presentation/state%20management/bloc/ivaBloc/manager_iva_cubit.dart';
import 'package:grocery/Presentation/views/auth/login/login_screen.dart';
import 'package:grocery/Presentation/views/auth/register/bloc/registration_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/category/bloc/category_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/processedResourceAction/bloc/proceed_resource_action_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/products/bloc/product_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resourceActions/bloc/resource_action_cubit.dart';
import 'package:grocery/Presentation/views/home/inventory/all%20tabs/resources/bloc/resource_cubit.dart';

import 'Data/repository/auth/login_repository.dart';
import 'Data/repository/manager/category_repository.dart';
import 'Data/repository/manager/iva_repository.dart';
import 'Presentation/views/auth/login/bloc/login_cubit.dart';
import 'Presentation/views/home/inventory/all tabs/proceedResource/bloc/proceed_resource_cubit.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                      create: (context) => CategoryCubit(
                          repo: context.read<CategoryRepository>())),
                  BlocProvider<ProductCubit>(
                      create: (context) => ProductCubit(modelList: [])),
                  BlocProvider<ResourceCubit>(
                      create: (context) => ResourceCubit(modelList: [])),
                  BlocProvider<ResourceActionCubit>(
                      create: (context) => ResourceActionCubit(modelList: [])),
                  BlocProvider<ProceedResourceCubit>(
                      create: (context) => ProceedResourceCubit(modelList: [])),
                  BlocProvider<ProceedResourceActionCubit>(
                      create: (context) =>
                          ProceedResourceActionCubit(modelList: [])),
                ],
                child: MaterialApp(
                  title: 'Bilancia Web',
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: (settings) => generateRoute(settings),
                  home: child,
                ),
              ));
        }),
        child: const LoginScreen());
  }
}
