import 'package:grocery/Application/exports.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  String userId = "";

  getUserData() async {
    var userEmail = await AppPrefs.getUserEmail();
    var userFirstName = await AppPrefs.getUserFirstName();
    var userLastName = await AppPrefs.getUserLastName();
    var id = await AppPrefs.getUserId();
    setState(() {
      emailController.text = userEmail;
      firstNameController.text = userFirstName;
      lastNameController.text = userLastName;
      userId = id;
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: AppStrings.editProfileText,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSize.p15).r,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomSizedBox.height(30),
              textFields(),
              CustomSizedBox.height(50),
              BlocListener<UserCubit, UserState>(listener: (context, state) {
                if (state.status == UserEnum.success) {
                  Navigator.of(context).pop();
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.profileUpdatedSuccessText,
                    AppColors.greenColor,
                    Icons.check,
                    true,
                  );
                }
                if (state.status == UserEnum.error) {
                  SnackBarWidget.buildSnackBar(
                    context,
                    AppStrings.errorOccuredText,
                    AppColors.redColor,
                    Icons.close,
                    true,
                  );
                }
              }, child: BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state.status == UserEnum.loading) {
                    return LoadingIndicator.loading();
                  }
                  return CustomButton(
                    text: AppStrings.updateText,
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> map = {
                          "first_name": firstNameController.text,
                          "last_name": lastNameController.text,
                        };

                        var isValid =
                            await context.read<UserCubit>().editUser(map);
                        if (isValid == true) {
                          await AppPrefs.setUserFirstName(
                              firstNameController.text);
                          await AppPrefs.setUserLastName(
                              lastNameController.text);
                        }
                      }
                    },
                  );
                },
              )),
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
          CustomTextField(
            controller: firstNameController,
            labelText: AppStrings.firstNameText,
            hintText: AppStrings.enterFirstNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideFirstNameText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          CustomTextField(
            controller: lastNameController,
            labelText: AppStrings.lastNameText,
            hintText: AppStrings.enterLastNameText,
            suffixIcon: const Text(""),
            obscureText: false,
            textInputType: TextInputType.text,
            validator: (v) {
              if (v!.trim().isEmpty) {
                return AppStrings.provideLastNameText;
              } else {
                return null;
              }
            },
          ),
          CustomSizedBox.height(20),
          AbsorbPointer(
            absorbing: true,
            child: CustomTextField(
              controller: emailController,
              labelText: AppStrings.emailText,
              hintText: AppStrings.enterEmailText,
              suffixIcon: const Text(""),
              obscureText: false,
              textInputType: TextInputType.text,
              validator: (v) {
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
