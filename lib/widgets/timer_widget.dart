// import 'package:demo_nfc/config/colors.dart';
// import 'package:demo_nfc/views/old_screens/homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
// import 'package:get/get.dart';

// class TimerWidget extends StatelessWidget {
//   const TimerWidget({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         flex: 4,
//         child: Column(
//           children: [
//             const Text(
//               "Timer Count Down",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.secondaryColor,
//               ),
//             ),
//             const SizedBox(height: 30),
//             TimerCountdown(
//               timeTextStyle: const TextStyle(
//                 fontSize: 35,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.red,
//               ),
//               format: CountDownTimerFormat.hoursMinutesSeconds,
//               endTime: DateTime.now().add(
//                 const Duration(
//                   hours: 0,
//                   minutes: 0,
//                   seconds: 60,
//                 ),
//               ),
//               onEnd: () {
//                 Future.delayed(const Duration(seconds: 20), () {
//                //   Get.to(() => const HomePage());
//                 });
//               },
//             ),
//           ],
//         ),
//       );
//   }
// }
