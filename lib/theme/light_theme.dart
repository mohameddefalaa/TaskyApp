import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/theme/colors.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xffFEFEFE),

    surface: AppColor.secondryLightBackground,
    onSurface: AppColor.primaryLightText,
    outline: AppColor.lightBoreder,
    outlineVariant: AppColor.lightBoreder,
  ),
  brightness: Brightness.light,
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppColor.primaryColor;
      } else {
        return AppColor.primaryDarkText;
        //
        // Colors.white;
      }
    }),
    thumbColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return Colors.white;
      } else {
        return Color(0xff9E9E9E);
      }
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return 0;
      } else {
        return 2.w;
      }
    }),
  ),
  scaffoldBackgroundColor: AppColor.lightBackground,
  useMaterial3: true,
  appBarTheme: AppBarThemeData(
    iconTheme: IconThemeData(color: AppColor.primaryLightText),
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryLightText,
    ),

    backgroundColor: AppColor.lightBackground,
    foregroundColor: AppColor.lightBackground,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: .5,
      shadowColor: Colors.grey,
      fixedSize: Size(double.infinity, 40.h),
      foregroundColor: Colors.transparent,
      backgroundColor: AppColor.primaryColor,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(AppColor.primaryLightText),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 1.5,
    foregroundColor: Color(0xffFFFCFC),
    backgroundColor: AppColor.primaryColor,
    shape: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.r),
      borderSide: BorderSide(color: Colors.transparent),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconSize: WidgetStatePropertyAll(24.r),
      iconColor: WidgetStatePropertyAll(Color(0xff3A4640)),
    ),
  ),
  iconTheme: IconThemeData(size: 24.r, color: AppColor.primaryLightText),
  listTileTheme: ListTileThemeData(
    contentPadding: EdgeInsets.zero,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryLightText,
    ),
    iconColor: AppColor.primaryLightText,
    textColor: AppColor.primaryLightText,
  ),
  dividerTheme: DividerThemeData(color: AppColor.lightBoreder, thickness: 1),
  inputDecorationTheme: InputDecorationThemeData(
    contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
    hintStyle: TextStyle(fontSize: 16.sp, color: AppColor.placeholderText),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),

      borderSide: BorderSide(color: AppColor.lightBoreder, width: 0.25.w),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),

      borderSide: BorderSide(color: AppColor.lightBoreder, width: 0.35.w),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),

      borderSide: BorderSide(color: AppColor.lightBoreder, width: 0.35.w),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.r),

      borderSide: BorderSide(color: Colors.red, width: 0.5.w),
    ),
    //
    filled: true,
    fillColor: Color(0xffFFFFFF),
  ),
  textTheme: TextTheme(
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14.sp,
      color: AppColor.primaryLightText, // اللون الذي كنت تضعه في الـ Style
      letterSpacing: .5,

      // الـ Letter Spacing الذي طلبته
    ),
    headlineLarge: GoogleFonts.plusJakartaSans(
      fontSize: 32.sp,
      color: AppColor.primaryLightText,
      fontWeight: FontWeight.w400,
      letterSpacing: .5, // الـ Letter Spacing الذي طلبته
    ),
    titleMedium: GoogleFonts.poppins(
      color: AppColor.primaryLightText,

      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      letterSpacing: .5,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400, // غالباً يكون شبه عريض (Semi-Bold)
      color: AppColor.primaryLightText,
    ),
    displayMedium: GoogleFonts.plusJakartaSans(
      fontSize: 28.sp,
      color: AppColor.primaryLightText,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: GoogleFonts.plusJakartaSans(
      fontSize: 24.sp,
      fontWeight: FontWeight.w400,
      color: AppColor.primaryLightText,
    ),
  ),

  // 2. التحكم في لون المؤشر (Cursor) ولون تحديد النص (Selection)
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColor.primaryLightText, // لون المؤشر
    selectionColor: Colors.green, // لون التظليل عند تحديد النص
    selectionHandleColor: Colors.black, // لون الدائرة أسفل المؤشر
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    unselectedIconTheme: IconThemeData(color: AppColor.secondaryLightText),
    selectedLabelStyle: GoogleFonts.roboto(
      fontSize: 12.sp,
      fontWeight: FontWeight.w600,
      color: Color(0xff3A4640),
    ),
    selectedIconTheme: IconThemeData(color: AppColor.primaryColor, size: 25.r),
    selectedItemColor: AppColor.primaryColor,
    unselectedItemColor: Color(0xff3A4640),
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xffF6F7F9),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(4.r),
    ),
    fillColor: WidgetStateProperty.resolveWith((state) {
      if (state.contains(WidgetState.selected)) {
        return AppColor.primaryColor;
      } else {
        return Colors.transparent;
      }
    }),
    checkColor: WidgetStatePropertyAll(AppColor.primaryDarkText),
    side: BorderSide(color: AppColor.lightBoreder, width: 2.w),
  ),
  splashFactory: NoSplash.splashFactory,
  popupMenuTheme: PopupMenuThemeData(
    labelTextStyle: WidgetStatePropertyAll(
      GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColor.primaryLightText,
      ),
    ),
    color: AppColor.lightBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16.r),
      // side: BorderSide(color: AppColor.primaryColor.withAlpha(40)),
    ),
    shadowColor: AppColor.darkBackground,
    elevation: 2,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColor.darkBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(16.r),
    ),
  ),
);
