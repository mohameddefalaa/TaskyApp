import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protofilio/Shared/colors.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final Widget icon;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        elevation: .5,
        shadowColor: Colors.grey,
        fixedSize: Size(MediaQuery.of(context).size.width, 40),
        foregroundColor: Colors.white,
        backgroundColor: AppColor.primaryColor,
      ),
      onPressed: onPressed,
      icon: icon,
      label: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}


/* async {
                  if (key.currentState?.validate() ?? false) {
                    final pref = await SharedPreferences.getInstance();
                    final jsonlist = pref.getString('taasksData');
                    List<dynamic> taskslist = [];
                    if (jsonlist != null) {
                      taskslist = jsonDecode(jsonlist);
                    }
                    TaskModel model = TaskModel(
                      id: taskslist.length + 1,
                      taskName: nameController.value.text,
                      isHighpreority: ishighpreority,
                      taskDesc: descController.value.text,
                    );
                    taskslist.add(model.toMap());
                    final dynamic taasksData = jsonEncode(taskslist);

                    await pref.setString("taasksData", taasksData).then((
                      value,
                    ) {
                      Navigator.of(context).pop(true);
                    });
                  }
                },
                
                
                */
                // SvgPicture.asset('assets/images/PLUS_icon.svg')