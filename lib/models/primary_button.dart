import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:sensotech/models/spacers.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      this.text,
      this.height,
      this.radius,
      this.onPressed,
      this.padding,
      this.color,
      this.svg,
      this.size,
      this.textColor});
  final String? text, svg;
  final double? height, radius, size;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final Color? color, textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 40.0,
      child: InkWell(
          onTap: onPressed,
          child: Container(
            // width: Helper.setWidth(context, factor: 0.8),
            height: height ?? 40,
            padding: padding,
            decoration: ShapeDecoration(
              color: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (svg != null) ...[
                  SvgPicture.asset(
                    svg!,
                    height: size ?? 34,
                    width: size ?? 34,
                  ),
                  const SizedBox(width: 10),
                  horizontalSpacer,
                ],
                Text(
                  text ?? "",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  )),
                ),
              ],
            ),
          )),
    );
  }
}
