import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/models/spacers.dart';

class OnboardModel extends StatelessWidget {
  const OnboardModel(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.image,
      required this.color});

  final String title, subtitle, image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: Helper.setWidth(context),
          height: Helper.setHeight(context, factor: 0.5),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        verticalSpacer,
        verticalSpacer,
        SizedBox(
          width: Helper.setWidth(context, factor: 0.86),
          child: Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontFeatures: const <FontFeature>[FontFeature.enable('smcp')],
              textStyle: TextStyle(
                color: color,
                fontSize: 28,
                fontWeight: FontWeight.w800,
                fontFeatures: const <FontFeature>[FontFeature.enable('smcp')],
                // letterSpacing: -0.75,
              ),
            ),
          ),
        ),
        verticalSpacer,
        verticalSpacer,
        SizedBox(
          width: Helper.setWidth(context, factor: .9),
          child: Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontFeatures: const <FontFeature>[FontFeature.enable('smcp')],
              textStyle: const TextStyle(
                color: kTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Spacer(),
        SizedBox(
          width: Helper.setWidth(context, factor: 1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Powered by ",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontFeatures: const <FontFeature>[FontFeature.enable('smcp')],
                  textStyle: const TextStyle(
                    color: kTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Image.asset(
                "assets/images/spec.png",
                fit: BoxFit.cover,
                height: 25,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
