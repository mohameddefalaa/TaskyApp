import 'package:flutter/material.dart';

class ChckListTask extends StatelessWidget {
  const ChckListTask({
    super.key,
    required this.taskname,
    required this.desc,
    required this.perority,
    required this.onchange,
    required this.isdone,
    required this.onDelete,
  });
  final String taskname;
  final String desc;
  final bool? perority;
  final void Function(bool?) onchange;
  final void Function(int id) onDelete;

  final bool isdone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: isdone, onChanged: onchange),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            taskname,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextTheme.of(context).bodyMedium?.copyWith(
              color: isdone == false ? null : Color(0xffA0A0A0),
              decoration: isdone == true
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),

            //

            /*   decorationThickness: 1.5,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: Color(0xffA0A0A0),*/
          ),
        ),
      ],
    );
  }
}


/*IconButton(
          constraints: BoxConstraints(),
          iconSize: 20,
          padding: EdgeInsets.zero,
          style: ButtonStyle(),
          onPressed: () {},
          icon: Icon(
            Icons.more_vert,
            size: 20,
            color: isdone == false ? null : AppColor.tertiarytext,
          ),
        ), */