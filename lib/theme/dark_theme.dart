import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/theme/colors.dart';
import 'package:protofilio/core/constants/app_size.dart';

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
        return AppSize.w1 * 1.6; // 2.w
      }
    }),
  ),
  scaffoldBackgroundColor: AppColor.darkBackground,
  useMaterial3: true,
  appBarTheme: AppBarThemeData(
    iconTheme: const IconThemeData(color: AppColor.primaryDarkText),
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: AppSize.sp20,
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
      fixedSize: Size(double.infinity, AppSize.h40),
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
      borderRadius: BorderRadius.circular(AppSize.r30),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStatePropertyAll(AppSize.r24),
      iconColor: WidgetStatePropertyAll(AppColor.primaryDarkText),
    ),
  ),
  iconTheme: IconThemeData(size: AppSize.r24, color: AppColor.primaryDarkText),
  listTileTheme: ListTileThemeData(
    contentPadding: EdgeInsets.zero,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: AppSize.sp16,
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
    contentPadding: EdgeInsets.symmetric(
      vertical: AppSize.dg16,
      horizontal: AppSize.dg16,
    ),
    hintStyle: TextStyle(
      fontSize: AppSize.sp16,
      color: AppColor.placeholderText,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),

      borderSide: BorderSide(color: Colors.red, width: AppSize.w1 * 0.4),
    ),
    filled: true,
    fillColor: AppColor.secondryDarkBackground,
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(
      fontSize: AppSize.sp14,
      color: AppColor.secondaryDarkText,
      letterSpacing: .5,
    ),
    displayMedium: TextStyle(
      fontSize: AppSize.sp28,
      color: AppColor.primaryDarkText,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: AppSize.sp32,
      color: AppColor.primaryDarkText,
      fontWeight: FontWeight.w400,
      letterSpacing: .5,
    ),
    titleMedium: GoogleFonts.poppins(
      color: AppColor.primaryDarkText,
      fontSize: AppSize.sp16,
      fontWeight: FontWeight.w400,
      letterSpacing: .5,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: AppSize.sp20,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryDarkText,
    ),

    displaySmall: GoogleFonts.plusJakartaSans(
      fontSize: AppSize.sp24,
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
      fontSize: AppSize.sp12,
      fontWeight: FontWeight.w600,
      color: AppColor.primaryDarkText,
    ),
    selectedIconTheme: IconThemeData(
      color: AppColor.primaryColor,
      size: AppSize.r24 * 1.04,
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
    side: BorderSide(color: AppColor.darkBoreder, width: AppSize.w1 * 1.6),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    labelTextStyle: WidgetStatePropertyAll(
      GoogleFonts.poppins(
        fontSize: AppSize.sp14,
        fontWeight: FontWeight.w400,
        color: AppColor.primaryDarkText,
      ),
    ),
    color: AppColor.darkBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSize.r16),
      side: BorderSide(color: AppColor.primaryColor.withAlpha(40)),
    ),
    shadowColor: AppColor.darkBackground,
    elevation: 10,
  ),
);
