import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager/ui/utils/assets_paths.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          fit: BoxFit.cover,
          height: double.maxFinite,
          width: double.maxFinite,
          AssetsPaths.backgroundSvg,
        ),
        SafeArea(child: child),
      ],
    );
  }
}
