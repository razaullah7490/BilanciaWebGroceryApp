// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'package:grocery/Application/exports.dart';

class CommandAddDialogue extends StatefulWidget {
  const CommandAddDialogue({
    Key? key,
  }) : super(key: key);

  @override
  State<CommandAddDialogue> createState() => _CommandAddDialogueState();
}

class _CommandAddDialogueState extends State<CommandAddDialogue> {
  List<String> commandTypeList = [
    "Registratore Telematico", //fp
    "Aggiorna cloud da bilance", //update_from_scales
    "Aggiorna bilance da cloud", //update_from_server
    "Chiusura giornaliera", //end_workday
  ];
  var selectedCommand;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: MediaQueryValues(context).width,
          height: MediaQueryValues(context).height,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              backContainer(),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 290.w,
                  height: 290.h,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(
                      AppBorderRadius.backContainerBorderRadius,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        spreadRadius: 2,
                        blurRadius: 7,
                      )
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        titleText(AppStrings.addCommandText),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.p14,
                            ).r,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                commandType(),
                                CustomSizedBox.height(10),
                                CustomDropDownWidget(
                                    hintText: AppStrings.selectCommandTypeText,
                                    value: selectedCommand,
                                    validationText:
                                        AppStrings.provideCommandTypeText,
                                    onChanged: (v) {
                                      setState(() {
                                        selectedCommand = v;
                                      });
                                    },
                                    itemsMap: commandTypeList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                              ),
                                            ))
                                        .toList()),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(),
                        BlocListener<CommandCubit, CommandState>(
                          listener: (context, state) {
                            if (state.status == CommandEnum.success) {
                              SnackBarWidget.buildSnackBar(
                                context,
                                AppStrings.commandAddedSuccessText,
                                AppColors.greenColor,
                                Icons.check,
                                true,
                              );
                              Navigator.of(context).pop();
                              Navigate.toReplace(
                                  context, const CommandScreen());
                            }
                            if (state.status == CommandEnum.error) {
                              SnackBarWidget.buildSnackBar(
                                context,
                                state.error.error,
                                AppColors.redColor,
                                Icons.close,
                                true,
                              );
                            }
                          },
                          child: BlocBuilder<CommandCubit, CommandState>(
                            builder: (context, state) {
                              if (state.status == CommandEnum.loading) {
                                return LoadingIndicator.loading();
                              }

                              return actionButton(
                                AppStrings.addText,
                                AppColors.primaryColor,
                                AppColors.whiteColor,
                                () async {
                                  if (formKey.currentState!.validate()) {
                                    await context
                                        .read<CommandCubit>()
                                        .addCommands(selectedCommand);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Align backContainer() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 240.w,
        height: 310.h,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(
            AppBorderRadius.backContainerBorderRadius,
          ),
        ),
      ),
    );
  }

  GestureDetector actionButton(
    String text,
    Color color,
    Color textColor,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSize.p32,
          vertical: AppSize.p12,
        ).r,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15).r,
            border: Border.all(
              color: AppColors.secondaryColor,
            )),
        child: Text(
          text,
          style: Styles.circularStdBook(
            AppSize.text15.sp,
            textColor,
          ),
        ),
      ),
    );
  }

  Widget commandType() {
    return Padding(
      padding: const EdgeInsets.only(left: AppSize.p2).r,
      child: Text(
        AppStrings.commandTypeText,
        style: Styles.segoeUI(
          AppSize.text15.sp,
          AppColors.containerTextColor,
        ),
      ),
    );
  }

  Widget titleText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.circularStdMedium(
            AppSize.text21.sp,
            AppColors.containerTextColor,
          ),
        ),
        CustomSizedBox.width(4),
        const Icon(
          Icons.add_circle_outline_rounded,
          color: AppColors.primaryColor,
          size: AppSize.icon28,
        ),
      ],
    );
  }
}
