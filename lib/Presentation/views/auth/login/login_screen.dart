// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:grocery/Application/exports.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  checkUserLogin() async {
    var token = await AppPrefs.getLoginToken();
    log("Init Token $token");
    if (token.isNotEmpty) {
      Navigate.toReplace(context, const DashBoardScreen());
    }
  }

  initDynamicLink() async {
    dynamicLinks.onLink.listen((event) {
      try {
        log("Initial Link ${event.link}");
        Navigate.toReplace(context, SetNewPasswordScreen(initialLink: event));
      } catch (e) {
        log("eeeeee $e");
      }
    }).onError((e) {
      log("login screen Error $e");
    });
  }

  transparencyDialog() async {
    // If the system can show an authorization request dialog
    if (await AppTrackingTransparency.trackingAuthorizationStatus ==
        TrackingStatus.notDetermined) {
      // Show a custom explainer dialog before the system dialog
      await showCustomTrackingDialog(context);
      // Wait for dialog popping animation
      await Future.delayed(const Duration(milliseconds: 200));
      // Request system's tracking authorization dialog
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing product. '
            'Can we continue to use your data to tailor product recommended for you?\n\nYou can change your choice anytime in the app settings. '
            'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
            ),
          ],
        ),
      );
  @override
  void initState() {
    transparencyDialog();
    checkUserLogin();
    initDynamicLink();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      imageAndName(),
                      CustomSizedBox.height(40),
                      textFields(),
                      CustomSizedBox.height(40),
                      BlocListener<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state.status == LoginEnum.success) {
                            SnackBarWidget.buildSnackBar(
                              context,
                              AppStrings.loginSuccessfullyText,
                              AppColors.greenColor,
                              Icons.check,
                              true,
                            );
                            Navigate.toReplace(
                                context, const DashBoardScreen());
                          }
                          if (state.error != const CustomError(error: '')) {
                            SnackBarWidget.buildSnackBar(
                              context,
                              state.error.error,
                              AppColors.redColor,
                              Icons.close,
                              true,
                            );
                          }
                        },
                        child: BlocBuilder<LoginCubit, LoginState>(
                            builder: (context, state) {
                          if (state.status == LoginEnum.loading) {
                            return LoadingIndicator.loading();
                          }

                          return CustomButton(
                            text: AppStrings.loginText,
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                Map<String, dynamic> map = {
                                  "username": emailController.text,
                                  "password": passwordController.text,
                                };
                                var isValid =
                                    await context.read<LoginCubit>().login(map);
                                if (isValid == true) {
                                  await AppPrefs.setUserPassword(
                                      passwordController.text);
                                }
                              }
                            },
                          );
                        }),
                      ),
                      CustomSizedBox.height(30),
                      bottomText(
                        context,
                        AppStrings.createNewAccountText,
                        AppStrings.signUpText,
                        () => Navigate.to(context, const RegisterScreen()),
                        // Navigator.pushNamed(
                        //   context,
                        //   RoutesNames.registerScreen,
                        // ),
                      ),
                    ],
                  ),
                ),
                bottomContainer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget imageAndName() {
    return Column(
      children: [
        Image.asset(Assets.authBack1),
        Text(AppStrings.loginText,
            style: Styles.circularStdBook(
              AppSize.text34.sp,
              AppColors.blackColor,
            )),
      ],
    );
  }

  Widget textFields() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p15).r,
        child: Column(
          children: [
            CustomTextField(
              controller: emailController,
              labelText: AppStrings.emailText,
              hintText: AppStrings.enterEmailText,
              suffixIcon: const Text(""),
              obscureText: false,
              textInputType: TextInputType.emailAddress,
              validator: (v) {
                Pattern pattern =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                RegExp regExp = RegExp(pattern.toString());
                if (v!.trim().isEmpty) {
                  return AppStrings.provideEmailText;
                } else if (!regExp.hasMatch(v)) {
                  return AppStrings.provideValidEmailText;
                } else {
                  return null;
                }
              },
            ),
            CustomSizedBox.height(20),
            BlocProvider(
              create: (context) => SetBoolCubit(false),
              child: BlocBuilder<SetBoolCubit, bool>(
                builder: (context, state) {
                  return CustomTextField(
                    controller: passwordController,
                    labelText: AppStrings.passwordText,
                    hintText: AppStrings.enterPasswordText,
                    suffixIcon: IconButton(
                      onPressed: () => state
                          ? context.read<SetBoolCubit>().changeState(false)
                          : context.read<SetBoolCubit>().changeState(true),
                      icon: Icon(
                        state ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 20.r,
                      ),
                    ),
                    obscureText: state,
                    textInputType: TextInputType.text,
                    validator: (v) {
                      if (v!.trim().isEmpty) {
                        return AppStrings.providePasswordText;
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
            ),
            CustomSizedBox.height(15),
            forgetPassword(),
          ],
        ),
      ),
    );
  }

  Widget forgetPassword() {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigate.to(context, const ForgetPasswordScreen()),
        // Navigator.pushNamed(context, RoutesNames.forgetPasswordScreen),
        child: Text(
          "${AppStrings.forgetPasswordText}?",
          style:
              Styles.circularStdBook(AppSize.text13.sp, AppColors.blackColor),
        ),
      ),
    );
  }
}
