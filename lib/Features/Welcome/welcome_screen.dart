// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:protofilio/Features/Navigation/main_scren.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/Features/Home/components/custome_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late TextEditingController nameController;
  late GlobalKey<FormState> _namekey;
  @override
  void initState() {
    nameController = TextEditingController();
    _namekey = GlobalKey<FormState>();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.dg, horizontal: 16.dg),
          child: SingleChildScrollView(
            child: Form(
              key: _namekey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset(
                      //   "assets/images/AppLogo.svg",

                      // ),
                      CustomeSvg(
                        path: 'assets/images/AppLogo.svg',
                        height: 42.h,
                        width: 42.w,
                      ),
                      SizedBox(width: 16.w),
                      Text("Tasky", style: TextTheme.of(context).displayMedium),
                    ],
                  ),
                  SizedBox(height: 108.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: TextTheme.of(context).displaySmall,
                      ),
                      CustomeSvg.withoutcolor(
                        path: "assets/images/waving-hand.svg",
                        height: 28.h,
                        width: 28.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Your productivity journey starts here.",
                    style: TextTheme.of(
                      context,
                    ).displaySmall!.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 24.h),
                  SvgPicture.asset(
                    "assets/images/pana.svg",
                    height: 204.39.h,
                    width: 215.w,
                  ),
                  SizedBox(height: 28.h),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      StorgeKey.username,
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  TextFormField(
                    decoration: InputDecoration(hintText: 'ex;Mohamed Ismail'),
                    validator: (String? value) {
                      if (value == null || value.trimLeft().isEmpty) {
                        return "Full nama must be required ";
                      }
                      return null;
                    },
                    controller: nameController,
                  ),
                  SizedBox(height: 24.h),
                  CustomeButton(
                    icon: SizedBox(),
                    title: 'Let’s Get Started',
                    onPressed: () async {
                      if (_namekey.currentState?.validate() ?? false) {
                        PerfrenceManager().setstring(
                          StorgeKey.username,
                          nameController.value.text,
                        );
                        Navigator.replace(
                          context,
                          oldRoute: ModalRoute.of(
                            context,
                          )!, // يأخذ المسار الحالي
                          newRoute: MaterialPageRoute(
                            builder: (context) => const MainScren(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red.shade300,
                            content: Text(
                              "Full Name must be required ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
/*() */