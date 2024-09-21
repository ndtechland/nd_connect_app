import 'package:flutter/material.dart';

class UpdateButton extends StatefulWidget {
  final VoidCallback onTap;
  String text;
  UpdateButton({Key? key,required this.onTap,required this.text}) : super(key: key);

  @override
  State<UpdateButton> createState() => _UpdateButtonState();
}

class _UpdateButtonState extends State<UpdateButton> {
  bool _isElevated = false;
  final Color mainColor = const Color(0xFF214683); // Custom button color

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
            setState(() {
              _isElevated = !_isElevated;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 50,
            width: 80,
            decoration: BoxDecoration(
              color: mainColor, // Button background color
              borderRadius: BorderRadius.circular(10), // Slightly rounded corners
              boxShadow: _isElevated
                  ? [
                // Elevated (raised) effect
                BoxShadow(
                  color: mainColor.withOpacity(0.5), // Slight shadow in button color tone
                  offset: const Offset(10, 10),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-10, -10),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ]
                  : [
                // Depth (concave) effect
                BoxShadow(
                  color: Colors.black.withOpacity(0.2), // Darker shadow for depth
                  offset: const Offset(10, 10),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-10, -10),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Center(
              child: TextButton(
               onPressed: widget.onTap,
               child:  Text(widget.text,
                style: TextStyle(
                  color: Colors.white, // White text for contrast
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

    );
  }
}

// import 'package:dsa_app/constant.dart';
// import 'package:flutter/material.dart';
// import 'package:nd_connect_techland/components/styles.dart';
//
// class NextButton extends StatefulWidget {
//   final VoidCallback onTap; // Change to VoidCallback
//   final String text;
//   final double w;
//   final double h;
//
//   const NextButton({
//     super.key,
//     required this.onTap,
//     required this.text,
//     required this.h,
//     required this.w,
//   });
//
//   @override
//   State<NextButton> createState() => _NextButtonState();
// }
//
// class _NextButtonState extends State<NextButton> {
//   bool _isElevated = false;
//   @override
//   Widget build(BuildContext context) {
//
//     return GestureDetector(
//       onTap: (){
//       setState(() {
//               _isElevated = !_isElevated;
//             });
//       },
//       child: Container(
//         width: widget.w,
//         height: widget.h,
//           decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 shape: BoxShape.circle,
//                 // when _isElevated is false, value
//                 // of inset parameter will be true
//                 // that will create depth effect.
//                 boxShadow: _isElevated
//                     ?
//                 // Elevated Effect
//                 [
//
//                   const BoxShadow(
//                     color: Color(0xFFBEBEBE),
//                     // Shadow for bottom right corner
//                     offset: Offset(10, 10),
//                     blurRadius: 30,
//                     spreadRadius: 1,
//                    // inset: false,
//                   ),
//                   const BoxShadow(
//                     color: Colors.white,
//                     // Shadow for top left corner
//                     offset: Offset(-10, -10),
//                     blurRadius: 30,
//                     spreadRadius: 1,
//                    // inset: false,
//                   ),
//                 ]
//                     :
//                 // Depth Effect
//                 [
//
//                   const BoxShadow(
//                     color: Color(0xFFBEBEBE),
//                     // Shadow for bottom right corner
//                     offset: Offset(10, 10),
//                     blurRadius: 30,
//                     spreadRadius: 1,
//                    // inset: true,
//                   ),
//                   const BoxShadow(
//                     color: Colors.white,
//                     // Shadow for top left corner
//                     offset: Offset(-10, -10),
//                     blurRadius: 30,
//                     spreadRadius: 1,
//                     //inset: true,
//                   ),
//                 ],
//               ),
//         child: TextButton(
//           onPressed: widget.onTap,
//           child: Text(
//             widget.text,
//             style: const TextStyle(
//               color: Colors.black87,
//               fontWeight: FontWeight.w800,
//               fontSize: 13,
//             ),
//           ), // Use onTap without calling it
//         ),
//       ),
//     );
//   }
// }
