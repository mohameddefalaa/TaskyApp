import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Shared/colors.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    primary: AppColor.secondryDarkBackground,
    onSurface: AppColor.primaryDarkText,
    outline: Colors.transparent,
    outlineVariant: AppColor.secondaryDarkText,
  ),
  brightness: Brightness.dark,
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppColor.primaryColor;
      } else {
        return AppColor.secondaryDarkText;
      }
    }),
    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return const Color(0xff424242);
      }
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return 0;
      } else {
        return 2;
      }
    }),
  ),
  scaffoldBackgroundColor: AppColor.darkBackground,
  useMaterial3: true,
  appBarTheme: AppBarThemeData(
    iconTheme: const IconThemeData(color: AppColor.primaryDarkText),
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryDarkText,
    ),
    backgroundColor: AppColor.darkBackground,
    foregroundColor: AppColor.darkBackground,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: .5,
      shadowColor: Colors.black,
      fixedSize: const Size(double.infinity, 40),
      foregroundColor: Colors.transparent,
      backgroundColor: AppColor.primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(AppColor.primaryDarkText),
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 1.5,
    foregroundColor: const Color(0xffFFFCFC),
    backgroundColor: AppColor.primaryColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  ),
  iconButtonTheme: const IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStatePropertyAll(24),
      iconColor: WidgetStatePropertyAll(AppColor.primaryDarkText),
    ),
  ),
  iconTheme: const IconThemeData(size: 24, color: AppColor.primaryDarkText),
  listTileTheme: ListTileThemeData(
    contentPadding: EdgeInsets.zero,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryDarkText,
    ),
    iconColor: AppColor.primaryDarkText,
    textColor: AppColor.primaryDarkText,
  ),
  dividerTheme: const DividerThemeData(
    color: AppColor.darkBoreder,
    thickness: 1,
  ),
  inputDecorationTheme: InputDecorationThemeData(
    contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    hintStyle: const TextStyle(fontSize: 16, color: AppColor.placeholderText),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),

      borderSide: BorderSide(color: Colors.red, width: 0.5),
    ),
    filled: true,
    fillColor: AppColor.secondryDarkBackground,
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: AppColor.secondaryDarkText,
      letterSpacing: .5,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: AppColor.primaryDarkText,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 32,
      color: AppColor.primaryDarkText,
      fontWeight: FontWeight.w400,
      letterSpacing: .5,
    ),
    titleMedium: GoogleFonts.poppins(
      color: AppColor.primaryDarkText,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: .5,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryDarkText,
    ),

    displaySmall: GoogleFonts.plusJakartaSans(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryDarkText,
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColor.primaryDarkText,
    selectionColor: Colors.green,
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedIconTheme: const IconThemeData(color: AppColor.secondaryDarkText),
    selectedLabelStyle: GoogleFonts.roboto(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryDarkText,
    ),
    selectedIconTheme: const IconThemeData(
      color: AppColor.primaryColor,
      size: 25,
    ),
    selectedItemColor: AppColor.primaryColor,
    unselectedItemColor: AppColor.secondaryDarkText,
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColor.secondryDarkBackground,
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    fillColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppColor.primaryColor;
      } else {
        return Colors.transparent;
      }
    }),
    checkColor: const WidgetStatePropertyAll(AppColor.primaryDarkText),
    side: const BorderSide(color: AppColor.darkBoreder, width: 2),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    labelTextStyle: WidgetStatePropertyAll(
      GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColor.primaryDarkText,
      ),
    ),
    color: AppColor.darkBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16),
      side: BorderSide(color: AppColor.primaryColor.withAlpha(40)),
    ),
    shadowColor: AppColor.darkBackground,
    elevation: 10,
  ),
);
