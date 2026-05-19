import 'package:flutter/material.dart';
import 'package:protofilio/core/constants/storge_key.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/core/widgets/custome_text_filed.dart';
import 'package:protofilio/core/constants/app_size.dart';
// Note: The instruction asked for newsapp path but the context shows protofilio. Using the project's actual path.

class UserDetailes extends StatefulWidget {
  const UserDetailes({super.key});

  @override
  State<UserDetailes> createState() => _UserDetailesState();
}

class _UserDetailesState extends State<UserDetailes> {
  late TextEditingController userNameController;
  late TextEditingController biocontroller;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String? finalName;
  String? bio;

  @override
  void initState() {
    userNameController = TextEditingController();
    biocontroller = TextEditingController();
    getfullname();
    super.initState();
  }

  @override
  void dispose() {
    biocontroller.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Details"), centerTitle: false),
      body: Padding(
        padding: EdgeInsets.all(AppSize.dg16),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomeTextFiled(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please Enter Your Name';
                    }
                    return null;
                  },
                  hinttext: finalName ?? "",
                  controller: userNameController,
                  maxlins: 1,
                  minlins: 1,
                  title: 'User Name ',
                ),
                CustomeTextFiled(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please Enter Your Motivation Quote';
                    }
                    return null;
                  },
                  hinttext: 'One task at a time. One step closer.',
                  controller: biocontroller,
                  maxlins: 4,
                  minlins: 4,
                  title: 'Motivation Quote',
                ),
                SizedBox(height: AppSize.h20),
                CustomeButton(
                  icon: SizedBox(),
                  title: 'Save Changes',
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      FocusScope.of(context).unfocus();

                      await savenewdata();
                      if (!mounted) return;

                      Navigator.pop(context, true);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getfullname() async {
    //  final pref = await SharedPreferences.getInstance();
    finalName = PerfrenceManager().getstring(StorgeKey.username);
    bio =
        PerfrenceManager().getstring(StorgeKey.bio) ??
        "One task at a time. One step closer.";
    if (!mounted) return;
    setState(() {
      if (finalName != null || finalName!.trim().isEmpty) {
        userNameController.text = finalName!;
      }
      if (bio != null || bio!.trim().isEmpty) {
        biocontroller.text = bio!;
      } else {
        "One task at a time. One step closer.";
      }
    });
  }

  Future<void> savenewdata() async {
    // final pref = await SharedPreferences.getInstance();
    await PerfrenceManager().setstring(StorgeKey.bio, biocontroller.value.text);
    await PerfrenceManager().setstring(
      StorgeKey.username,
      userNameController.value.text,
    );
  }
}
