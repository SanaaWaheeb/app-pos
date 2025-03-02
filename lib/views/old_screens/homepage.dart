// import 'package:demo_nfc/config/colors.dart';
// import 'package:demo_nfc/config/images.dart';
// import 'package:demo_nfc/nearpay_services/nearpay_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

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
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Container(
//               width: MediaQuery.sizeOf(context).width * 0.5,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SvgPicture.asset(
//                       DefaultImages.nfc,
//                       color: AppColors.primaryColor,
//                       height: MediaQuery.sizeOf(context).height * 0.05,
//                     ),
//                     SvgPicture.asset(
//                       DefaultImages.product,
//                       color: AppColors.primaryColor,
//                       height: MediaQuery.sizeOf(context).height * 0.2,
//                       width: MediaQuery.sizeOf(context).width * 0.10,
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "1 Minutes Message",
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "SAR 1.00",
//                       textAlign: TextAlign.start,
//                       style: TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.secondaryColor,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           NearpayService().makePurchase(100, '123');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                         ),
//                         child: const Text(
//                           'Buy Now',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: AppColors.secondaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
