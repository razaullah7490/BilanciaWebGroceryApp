import 'package:grocery/Application/exports.dart';

Widget bottomContainer() {
  return Expanded(
    child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          width: 150.w,
          height: 80.h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                Assets.authBack2,
              ),
              fit: BoxFit.fill,
            ),
          ),
        )),
  );
}
