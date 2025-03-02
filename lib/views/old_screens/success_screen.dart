// import 'package:demo_nfc/config/colors.dart';
// import 'package:demo_nfc/config/images.dart';
// import 'package:demo_nfc/widgets/timer_widget.dart';
// import 'package:demo_nfc/widgets/webview.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';


// class WebViewScreen extends StatefulWidget {
//   const WebViewScreen({
//     super.key,
//   });

//   @override
//   State<WebViewScreen> createState() => _WebViewScreenState();
// }

// class _WebViewScreenState extends State<WebViewScreen> {
//   bool _timerStarted = false;

//   @override
//   void initState() {
//     super.initState();
//     // Start the timer after a delay of 5 seconds
//     Future.delayed(Duration(seconds: 5), () {
//       setState(() {
//         _timerStarted = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 245, 243, 243),
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Row(
//           children: [
//             Text(
//               'Your ',
//               style: TextStyle(
//                   color: AppColors.secondaryColor,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               'Logo',
//               style: TextStyle(
//                   color: AppColors.primaryColor,
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.language),
//             onPressed: () {
//               // Add  functionality here
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               // Add  functionality here
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Container(
//               width: Get.width * 0.9,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: Colors.white,
//                       child: SvgPicture.asset(
//                         color: AppColors.primaryColor,
//                         DefaultImages.product,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "1 Minutes Message",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.w500,
//                             color: AppColors.secondaryColor,
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           "SAR 1.00",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.secondaryColor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const WebView(),
//             Container(
//               child: _timerStarted
//                 ? const TimerWidget()
//                 : const CircularProgressIndicator()),
            
//           ],
//         ),
//       ),
//     );
//   }
// }
