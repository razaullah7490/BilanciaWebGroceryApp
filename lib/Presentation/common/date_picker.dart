import 'package:grocery/Application/exports.dart';

Future<DateTime?> datePicker(
  BuildContext context,
) async {
  final initialDate = DateTime.now();
  final newDate = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 5),
    lastDate: DateTime(DateTime.now().year + 5),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primaryColor,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: AppColors.primaryColor),
          ),
        ),
        child: child!,
      );
    },
  );

  if (newDate == null) {
    return null;
  } else {
    return newDate;
  }
}
