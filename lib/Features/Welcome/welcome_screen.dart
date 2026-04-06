// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:protofilio/Features/Navigation/main_scren.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/core/widgets/custome_svg.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                        height: 42,
                        width: 42,
                      ),
                      SizedBox(width: 16),
                      Text("Tasky", style: TextTheme.of(context).displayMedium),
                    ],
                  ),
                  const SizedBox(height: 108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        style: TextTheme.of(context).displaySmall,
                      ),
                      CustomeSvg.withoutcolor(
                        path: "assets/images/waving-hand.svg",
                        height: 28,
                        width: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your productivity journey starts here.",
                    style: TextTheme.of(
                      context,
                    ).displaySmall!.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  SvgPicture.asset(
                    "assets/images/pana.svg",
                    height: 204.39,
                    width: 215,
                  ),
                  const SizedBox(height: 28),
                  Align(
                    alignment: AlignmentGeometry.centerLeft,
                    child: Text(
                      "Full Name",
                      style: TextTheme.of(context).titleMedium,
                    ),
                  ),
                  const SizedBox(height: 8),

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
                  const SizedBox(height: 24),
                  CustomeButton(
                    icon: SizedBox(),
                    title: 'Let’s Get Started',
                    onPressed: () async {
                      if (_namekey.currentState?.validate() ?? false) {
                        PerfrenceManager().setstring(
                          'Full Name',
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
                                fontSize: 16,
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