// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../resources/routes/routes_names.dart';
// import '../views/auth/forget/setNewPassword/set_new_password.dart';

// class DynamicLinks {
//   // static Future<String> createDynamicLink(bool short, Item item) async {
//   //   DynamicLinkParameters parameters = DynamicLinkParameters(
//   //     uriPrefix: 'https://cartrackingsystem.page.link',
//   //     link: Uri.parse(
//   //         'https://cartrackingsystem.page.link/product?id=${item.id.toString()}'),
//   //     androidParameters: const AndroidParameters(
//   //       packageName: 'com.metra.cartrackingsystem.car_tracking_system',
//   //       minimumVersion: 1,
//   //     ),
//   //   );
//   //
//   //   final ShortDynamicLink shortLink =
//   //   await FirebaseDynamicLinks.instance.buildShortLink(parameters);
//   //   Uri url = shortLink.shortUrl;
//   //
//   //   print(url.toString());
//   //   return url.toString();
//   // }

//   static Future<void> initDynamicLink(BuildContext context) async {
//     PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     try {
//       final Uri? deepLink = data?.link;
//       if (deepLink != null) {
//         print('IDDDDDDDDD: $deepLink');
//         // TODO : Navigate to your pages accordingly here
//         try {
//           Navigator.pushNamed(context, RoutesNames.loginScreen);
//           // Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //         builder: (context) => const SetNewPasswordScreen()));
//         } catch (e) {
//           if (kDebugMode) {
//             print(e);
//           }
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   static void shareLink(
//       BuildContext context, String message, String subject) async {}
// }
