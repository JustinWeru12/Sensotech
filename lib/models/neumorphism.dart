import 'package:sensotech/constants/theme.dart';
import 'package:flutter/material.dart';

//Flat Neumorphism
class FlatNeumorphism extends StatelessWidget {
  const FlatNeumorphism({
    super.key,
    required this.child,
    this.radius,
    this.color,
    this.showBorder = false,
  });
  final Widget child;
  final double? radius;
  final Color? color;
  final bool showBorder;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? kTextLightColor,
          borderRadius: BorderRadius.circular(radius ?? 20),
          border: showBorder ? Border.all(color: kPrimaryColor) : null,
          boxShadow: [
            BoxShadow(
                color: kShadowColor.withValues(alpha: 0.35),
                blurRadius: 5,
                offset: const Offset(5, 3)),
            BoxShadow(
                color: kShadowColor.withValues(alpha: 0.1),
                blurRadius: 5,
                offset: const Offset(-2, -3))
          ]),
      child: Center(
        child: child,
      ),
    );
  }
}
