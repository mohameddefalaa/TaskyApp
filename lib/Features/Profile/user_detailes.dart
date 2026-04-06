import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Shared/colors.dart';
import 'package:protofilio/core/services/perfrence_manager.dart';
import 'package:protofilio/core/widgets/custome_button.dart';
import 'package:protofilio/core/widgets/custome_text_filed.dart';

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
        padding: const EdgeInsets.all(16.0),
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
                  },
                  hinttext: 'One task at a time. One step closer.',
                  controller: biocontroller,
                  maxlins: 4,
                  minlins: 4,
                  title: 'Motivation Quote',
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 40),
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
    finalName = PerfrenceManager().getstring('Full Name');
    bio =
        PerfrenceManager().getstring('bio') ??
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
    await PerfrenceManager().setstring("bio", biocontroller.value.text);
    await PerfrenceManager().setstring(
      'Full Name',
      userNameController.value.text,
    );
  }
}
