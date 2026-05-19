// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:protofilio/Features/Navigation/main_scren.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/Features/Home/components/custome_svg.dart';
import 'package:protofilio/core/constants/app_size.dart';

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
          padding: EdgeInsets.symmetric(
            vertical: AppSize.dg8,
            horizontal: AppSize.dg16,
          ),
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
                        height: AppSize.h40 + AppSize.h4 * 0.5,
                        width: AppSize.w40 + AppSize.w4 * 0.5,
                      ),
                      SizedBox(width: AppSize.w16),
                      Text("Tasky", style: TextTheme.of(context).displayMedium),
                    ],
                  ),
                  SizedBox(height: AppSize.h40 * 2.7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: TextTheme.of(context).displaySmall,
                      ),
                      CustomeSvg.withoutcolor(
                        path: "assets/images/waving-hand.svg",
                        height: AppSize.h28,
                        width: AppSize.w28,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSize.h8),
                  Text(
                    "Your productivity journey starts here.",
                    style: TextTheme.of(
                      context,
                    ).displaySmall!.copyWith(fontSize: AppSize.sp16),
                  ),
                  SizedBox(height: AppSize.h24),
                  SvgPicture.asset(
                    "assets/images/pana.svg",
                    height: AppSize.h40 * 5.1,
                    width: AppSize.w40 * 5.375,
                  ),
                  SizedBox(height: AppSize.h28),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      StorgeKey.username,
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ),
                  SizedBox(height: AppSize.h8),

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
                  SizedBox(height: AppSize.h24),
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
                                fontSize: AppSize.sp16,
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