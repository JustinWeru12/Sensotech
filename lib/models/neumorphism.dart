import 'package:sensotech/constants/theme.dart';
import 'package:flutter/material.dart';

//Concave Neumorphism
class ConcaveNeumorphism extends StatelessWidget {
  const ConcaveNeumorphism(
      {super.key,
      required this.child,
      this.radius,
      this.gradient,
      this.borderRadius,
      this.shadow = true});
  final Widget child;
  final double? radius;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: gradient ??
              const LinearGradient(
                begin: Alignment(-1, 1),
                end: Alignment(1, 1),
                colors: [
                  Color.fromARGB(255, 211, 229, 203),
                  kBackgroundColor,
                ],
              ),
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 40),
          border: Border.all(color: kPrimaryColor),
          boxShadow: shadow
              ? [
                  BoxShadow(
                      color: kShadowColor.withValues(alpha: 0.45),
                      blurRadius: 40,
                      offset: const Offset(20, 20)),
                  BoxShadow(
                      color: kShadowColor.withValues(alpha: 0.3),
                      blurRadius: 40,
                      offset: const Offset(-20, -20))
                ]
              : null),
      child: Center(child: child),
    );
  }
}

//Convex Neumorphism
class ConvexNeumorphism extends StatelessWidget {
  const ConvexNeumorphism({
    super.key,
    required this.child,
    this.radius,
  });
  final Widget child;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-1, -1),
            end: Alignment(1, 1),
            colors: [
              Color.fromARGB(255, 211, 229, 203),
              kBackgroundColor,
            ],
          ),
          borderRadius: BorderRadius.circular(radius ?? 40),
          boxShadow: const [
            BoxShadow(
                color: Color(0xffcccccc),
                blurRadius: 40,
                offset: Offset(20, 20)),
            BoxShadow(
                color: Color(0xffffffff),
                blurRadius: 40,
                offset: Offset(-20, -20))
          ]),
      child: Center(
        child: child,
      ),
    );
  }
}

//Flat Neumorphism
class FlatNeumorphism extends StatelessWidget {
  const FlatNeumorphism({
    super.key,
    required this.child,
    this.radius,
    this.color,
  });
  final Widget child;
  final double? radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? kBackgroundColor,
          borderRadius: BorderRadius.circular(radius ?? 20),
          boxShadow: [
            BoxShadow(
                color: kShadowColor.withValues(alpha: 0.45),
                blurRadius: 10,
                offset: const Offset(7, 5)),
            BoxShadow(
                color: kShadowColor.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(-4, -6))
          ]),
      child: Center(
        child: child,
      ),
    );
  }
}
