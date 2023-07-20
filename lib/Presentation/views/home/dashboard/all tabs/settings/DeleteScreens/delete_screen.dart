import 'package:grocery/Application/Cubit/delete_account_cubit.dart';
import 'package:grocery/Application/exports.dart';

class DeleteInfo extends StatelessWidget {
  const DeleteInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Eliminare l'account"),
      body: Column(
        children: [
          SizedBox(
            height: 40.sp,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0.sp, left: 10.sp, right: 10.sp),
            child: text(
                'Scegliendo l \'eliminazione del tuo account di Bilancia Web, dichiari di essere a conoscenza e di accettare le seguenti conseguenze: \n',
                size: AppSize.text15),
          ),
          Expanded(
            flex: 9,
            child: Padding(
              padding:
                  EdgeInsets.only(bottom: 8.0.sp, left: 10.sp, right: 10.sp),
              child: text(
                  "Tutti i dati strettamente relativi all'account verranno eliminati definitivamente, inclusi i dati anagrafici, i log inerenti il tuo utente e tutti i record del database che lo referenziano, come ad esempio le partecipazioni agli eventi in agenda.\n\n Perderai l'accesso a tutte le impostazioni di personalizzazioni e preferenze.\n\n Qualsiasi eventuale sottoscrizione aggiuntiva, che essa sia a pagamento o gratuita, verrà immediatamente terminata.\n\n Le informazioni relative al tuo account verranno rimosse dai nostri server, assicurandoti il rispetto della tua privacy. \n\n Non sarai più in grado di accedere all'applicazione di Bilancia Web in futuro utilizzando l'account che stai eliminando.",
                  textColorCustom: AppColors.textColor),
            ),
          ),
          BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
            listener: (context, state) {
              if (state is DeleteAccountLoading) {
                SnackBarWidget.buildSnackBar(
                  context,
                  'Loading..',
                  AppColors.greenColor,
                  Icons.navigate_next,
                  true,
                );
              }
              if (state is DeleteAccountSuccess) {
                showDialog<void>(
                    barrierColor: AppColors.deleteDialogueBarrierColor,
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return DeleteItemDialogue4(
                        text: 'Il tuo account è stato eliminato correttamente.',
                        headerTitle: 'Account eliminato\n\n',
                        onDeleteButtonTap: () {},
                        iconPath: Assets.deleteSuccess,
                      );
                    });
                AppPrefs.clearPref();
                Future.delayed(const Duration(seconds: 2)).then((value) {
                  Navigate.toReplace(context, const LoginScreen());
                });
              }
              if (state is DeleteAccountUnknownError) {}
              // TODO: implement listener
            },
            builder: (context, state) {
              return CustomButton(
                text: "Eliminare l'account",
                onTap: () {
                  showDialog<void>(
                      barrierColor: AppColors.deleteDialogueBarrierColor,
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        // return DeleteItemDialogue4(
                        //   text:
                        //       'Your account is permanently deleted and you will no longer be able to access it.',
                        //   headerTitle: 'Account Deleted\n\n',
                        //   onDeleteButtonTap: () {},
                        //   iconPath: Assets.deleteSuccess,
                        // );
                        return DeleteItemDialogue3(
                            headerTitle: 'Cancellazione dell\n\n',
                            text:
                                "Eliminando definitivamente il tuo account non sarai più in grado di accedervi.",
                            onDeleteButtonTap: () async {
                              print("delete yes");
                              var id = await AppPrefs.getUserId();
                              context
                                  .read<DeleteAccountCubit>()
                                  .deleteAccount(id);
                              Navigator.of(context).pop(true);
                            });
                      });
                },
              );
            },
          ),
          const Spacer()
        ],
      ),
    );
  }

  Widget text(String text, {Color? textColorCustom, double? size}) {
    return SingleChildScrollView(
      child: Text(
        text,
        maxLines: 40,
        style: Styles.circularStdBook(size ?? AppSize.text14.sp,
            textColorCustom ?? AppColors.containerTextColor,
            letterSpacing: 2, customH: 1.8),
      ),
    );
  }
}
