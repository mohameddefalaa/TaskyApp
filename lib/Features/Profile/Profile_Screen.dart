import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:protofilio/Features/Profile/user_detailes.dart';
import 'package:protofilio/Features/Welcome/welcome_screen.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/theme/colors.dart';
import 'package:protofilio/core/constants/app_size.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/theme/theme_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? finalname;
  String? finalbio;
  String? userImage;

  @override
  void initState() {
    finalname == null ? getfullname() : null;
    getimage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.dg16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.dg16),

              child: Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(AppSize.r32 * 2 + AppSize.r1),
                        child: userImage != null
                            ? Image.file(File(userImage!))
                            : SvgPicture.asset(
                                "assets/images/person.svg",
                                alignment: AlignmentGeometry.center,
                                fit: BoxFit.contain,
                                height:
                                    AppSize.h40 * 2 + AppSize.h4 + AppSize.h1,
                                width:
                                    AppSize.w40 * 2 + AppSize.w4 + AppSize.w1,
                              ),
                      ),
                    ),
                    Container(
                      height: AppSize.h32 + AppSize.h4 * 0.75,
                      width: AppSize.w32 + AppSize.w4 * 0.75,
                      decoration: BoxDecoration(
                        color: AppColor.primaryDarkText,
                        borderRadius: BorderRadius.circular(AppSize.r32),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () async {
                            _showdilog(context, (XFile file) async {
                              saveimage(file);
                              setState(() {
                                userImage = (file.path);
                              });
                            });
                          },
                          icon: Icon(
                            Icons.camera_alt_outlined,
                            color: AppColor.iconPrimary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSize.h8),
            Align(
              alignment: AlignmentGeometry.center,
              child: Text(
                textAlign: TextAlign.center,
                "$finalname",
                style: TextTheme.of(context).titleLarge,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: AlignmentGeometry.center,
              child: Text(
                finalbio ?? "One task at a time. One step closer.",
                style: TextTheme.of(context).bodyMedium,
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: AlignmentGeometry.topLeft,
              child: Text(
                "Profile Info",
                style: TextTheme.of(context).titleMedium,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.person_outline),
              title: Text('User Details'),
              trailing: IconButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return UserDetailes();
                      },
                    ),
                  );
                  if (result == true) {
                    setState(() {
                      getfullname();
                    });
                  }
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: AppSize.r24, // نفس المقاس اللي في الصورة (14x14)
                ),
              ),
            ),
            Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.dark_mode_outlined),
              title: Text('Dark Mode'),
              trailing: Switch(
                value: ThemeController.themeNotifier.value == ThemeMode.dark,

                onChanged: (value) {
                  ThemeController.toggletheme();
                },
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              trailing: IconButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();
                  //   final pref = await SharedPreferences.getInstance();
                  PerfrenceManager().remove(StorgeKey.bio);
                  PerfrenceManager().remove(StorgeKey.username);
                  PerfrenceManager().remove(StorgeKey.tasksdata);
                  PerfrenceManager().remove(StorgeKey.userImage);

                  await Future.delayed(const Duration(milliseconds: 200));
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WelcomeScreen();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  }
                },
                icon: Icon(
                  Icons.arrow_forward,
                  size: AppSize.r24, // نفس المقاس اللي في الصورة (14x14)
                ),
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void getfullname() async {
    //final pref = await SharedPreferences.getInstance();
    finalname = PerfrenceManager().getstring(StorgeKey.username);
    finalbio =
        PerfrenceManager().getstring(StorgeKey.bio) ??
        "One task at a time. One step closer.";
    setState(() {});
  }

  void getimage() {
    setState(() {
      String? imagepath = PerfrenceManager().getstring(StorgeKey.userImage);
      if (imagepath != null && imagepath.isNotEmpty && imagepath != 'null') {
        userImage = (imagepath);
      } else {
        userImage = null;
      }
    });
  }

  _showdilog(BuildContext context, Function(XFile) selectedfile) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text(
            'Chose Your Source Image',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(AppSize.dg16),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  return selectedfile(image);
                } else {}
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: AppSize.w8 + AppSize.w1 * 2),
                  Text('Camera'),
                ],
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(AppSize.dg16),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  return selectedfile(image);
                } else {}
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: AppSize.w8 + AppSize.w1 * 2),
                  Text('Gallery '),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  saveimage(XFile file) async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final newfile = await File(file.path).copy('${appDir.path}/${file.name}');
    await PerfrenceManager().setstring(StorgeKey.userImage, newfile.path);
  }
}
