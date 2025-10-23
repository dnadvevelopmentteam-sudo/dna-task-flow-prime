// import 'package:dna_taskflow_prime/core/extension/responsive_extension.dart';
// import 'package:flutter/material.dart';

// class CustomAnnouncementButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final double height;
//   final double width;

//   const CustomAnnouncementButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.height = 0,
//     this.width = double.infinity,
//     // required EdgeInsets padding,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: ElevatedButton.icon(
//         onPressed: onPressed,
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: Text(
//           text,
//           style: TextStyle(
//             fontFamily: 'Inter',
//             color: Colors.white,
//             fontSize: context.scaleFont(18),
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color.fromARGB(255, 30, 80, 200),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           elevation: 0,
//         ),
//       ),
//     );
//   }
// }
