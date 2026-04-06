import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:protofilio/Shared/colors.dart';

class CustomeSvg extends StatelessWidget {
  const CustomeSvg({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.colorfilter = true,
  });

  const CustomeSvg.withoutcolor({
    super.key,
    required this.path,
    this.height,
    this.width,
  }) : colorfilter = false;
  final String path;
  final double? height;
  final double? width;
  final bool? colorfilter;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      colorFilter: colorfilter == true
          ? ColorFilter.mode(AppColor.primaryColor, BlendMode.srcIn)
          : ColorFilter.mode(
              Theme.of(context).colorScheme.onSurface,
              BlendMode.srcIn,
            ),
    );
  }
}
