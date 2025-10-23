// import 'package:flutter/material.dart';

// class CloseButtonWidget extends StatelessWidget {
//   final VoidCallback onPressed;

//   final String text;

//   const CloseButtonWidget({
//     super.key,
//     required this.onPressed,
//     this.text = 'Close',
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: SizedBox(
//         height: 60.0,
//         width: double.infinity,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF1949D8),

//             foregroundColor: Colors.white,

//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12.0), // Rounded corners
//             ),

//             textStyle: const TextStyle(
//               fontSize: 24.0,
//               fontWeight: FontWeight.bold,
//             ),
//             elevation: 5.0,
//           ),
//           child: Text(text),
//         ),
//       ),
//     );
//   }
// }
