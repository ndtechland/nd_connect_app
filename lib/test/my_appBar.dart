import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nd_connect_techland/test/theme_color.dart';


PreferredSizeWidget myAppBar({
  required String title,
  required IconData leadingIcon,
  required VoidCallback onLeadingPressed,
  IconData? searchIcon,
  VoidCallback? onSearchPressed,
  IconData? userIcon,
  VoidCallback? onUserPressed,
  bool? centerTitle,
  double? titleFontSize, // Font size parameter for title
  Color? backgroundColor, // Optional background color
  IconData? actionIcon, // Optional action button icon
  VoidCallback? onActionPressed, // Callback for the action button
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: backgroundColor ??
        MyTheme.themecolor, // Use optional background color or default
    title: Text(
      title,
      style: GoogleFonts.roboto(
        color: AppColors.white,
        fontSize: titleFontSize ?? 17, // Font size for the title
        fontWeight: FontWeight.w700,
      ),
    ),
    centerTitle: centerTitle ?? true, // Center title by default
    leading: IconButton(
      icon: Icon(
        leadingIcon,
        size: 18,
      ),
      onPressed: onLeadingPressed,
      color: AppColors.white,
    ),
    actions: [
      if (searchIcon != null)
        IconButton(
          icon: Icon(
            searchIcon,
            size: 18,
            color: AppColors.white,
          ),
          onPressed: onSearchPressed,
        ),
      if (userIcon != null)
        IconButton(
          icon: Icon(
            userIcon,
            size: 18,
            color: AppColors.white,
          ),
          onPressed: onUserPressed,
        ),
      if (actionIcon != null) // Optional action button
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
                color: MyTheme.dvrskyblue7, shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(
                actionIcon,
                size: 22,
                color: MyTheme.logored,
              ),
              onPressed: onActionPressed,
            ),
          ),
        ),
    ],
  );
}