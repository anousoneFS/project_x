// import 'package:flutter/material.dart';
//
// class TabScreen2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 25, horizontal: 45),
//         height: 110,
//         width: Get.width,
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//         ),
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
//           height: 100,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor,
//             borderRadius: BorderRadius.circular(24),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(
//                   FontAwesomeIcons.home,
//                   size: controller.currentIndex == 0 ? 26 : 22,
//                   color: controller.currentIndex == 0
//                       ? Theme.of(context).scaffoldBackgroundColor
//                       : Theme.of(context)
//                           .scaffoldBackgroundColor
//                           .withOpacity(0.5),
//                 ),
//                 onPressed: () {
//                   controller.setCurrentIndex(0);
//                 },
//               ),
//               IconButton(
//                 icon: Icon(
//                   FontAwesomeIcons.userFriends,
//                   size: controller.currentIndex == 1 ? 26 : 22,
//                   color: controller.currentIndex == 1
//                       ? Theme.of(context).scaffoldBackgroundColor
//                       : Theme.of(context)
//                           .scaffoldBackgroundColor
//                           .withOpacity(0.5),
//                 ),
//                 onPressed: () {
//                   print("hi");
//                 },
//               ),
//               IconButton(
//                 icon: Icon(
//                   FontAwesomeIcons.cog,
//                   size: controller.currentIndex == 2 ? 26 : 22,
//                   color: controller.currentIndex == 2
//                       ? Theme.of(context).scaffoldBackgroundColor
//                       : Theme.of(context)
//                           .scaffoldBackgroundColor
//                           .withOpacity(0.5),
//                 ),
//                 onPressed: () {
//                   print("hi");
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
