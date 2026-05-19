import 'package:flutter/material.dart';
import 'package:protofilio/theme/colors.dart';
import 'package:protofilio/core/constants/app_size.dart';

class CustomecCard extends StatelessWidget {
  const CustomecCard({
    super.key,
    required this.titleCard,
    required this.title,
    required this.subTitle,
    required this.leadingWidget,
    this.onTap,
  });
  final String titleCard;
  final String title;
  final String subTitle;
  final Icon leadingWidget;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titleCard,
            style: TextTheme.of(context).bodyMedium!.copyWith(
              //
              fontSize: AppSize.sp16,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSize.dg8,
                  vertical: AppSize.dg4,
                ),
                title: Text(title),
                subtitle: Text(subTitle),
                leading: leadingWidget,
                iconColor: AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
