import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/test/theme_color.dart';


class HorizontalButton extends StatefulWidget {
  final String text;
  final Function()? onClick; // Make the onClick function nullable
  final double? height;
  final double? width;

  const HorizontalButton({
    Key? key,
    required this.text,
    required this.onClick,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  _HorizontalButtonState createState() => _HorizontalButtonState();
}

class _HorizontalButtonState extends State<HorizontalButton> {
  static double _shadowHeight = 4;
  double _position = 4;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final double _height = 53 - _shadowHeight;
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          _position = 4;
        });
        if (widget.onClick != null) widget.onClick!();
      },
      onTapDown: (_) {
        setState(() {
          _position = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _position = 4;
        });
      },
      child: Container(
        height: _height + _shadowHeight,
        width: size.width * 0.58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(-0.0, -0.0),
              blurRadius: 1,
            ),
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.0),
              blurRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: MyTheme.themecolor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              AnimatedPositioned(
                curve: Curves.bounceOut,
                bottom: _position,
                duration: Duration(milliseconds: 60),
                child: Container(
                  height: _height,
                  width: size.width * 0.57,

                  //width: 200,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyTheme.ambapp)),
                  child: Center(
                    child: Text(
                      widget.text ?? 'Click me!',
                      style: GoogleFonts.poppins(
                        //fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.047,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,

                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 0,
                            offset: Offset(0, 0),
                          ),
                        ],
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}