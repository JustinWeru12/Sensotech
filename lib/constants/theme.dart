import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

//v2
const kPrimaryColor = Color(0xFF0A4D9F);
const kSecondaryColor = Color(0xFFE81A5E);
const kTertiaryColor = Color(0xFFEDAD4D);
const kBackgroundColor = Color(0xFFCEDBEB);
const kTextColor = Color(0xFF000000);
const kFormColor = Color(0xFFCEEAF5);
const kOverlayColor = Color(0xFF0A4D9F);
const kAlertColor = Color(0xFFEB001B);
const kOnAlertColor = Color(0xFF800020);
const kGreenColor = Color(0xFF00C247);
const kAppBarColor = Color(0xFF231F20);
const kShadowColor = Color(0xFF35383F);
const kTextLightColor = Color(0xFFFFFFFF);
const kTextFallbackColor = Color(0xFFFFFFFF);
const kBoxShadow = BoxShadow(
  color: kShadowColor,
  offset: Offset(0, 0),
  spreadRadius: 0,
  blurRadius: 10,
);
//fallbackImage

const fallBackImageUrl =
    "https://images.pexels.com/photos/3427609/pexels-photo-3427609.jpeg?auto=compress&cs=tinysrgb&w=600";
const fallBackAvatar =
    "https://images.pexels.com/photos/886521/pexels-photo-886521.jpeg?auto=compress&cs=tinysrgb&w=600";

const kBorderRadius = BorderRadius.all(kRadius);
const kRadius = Radius.circular(15);
const kLargeRadius = Radius.circular(20);

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.w600,
);
var kBoardingTextStyle = TextStyle(
  fontSize: 20,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w700).fontFamily,
  fontWeight: FontWeight.w700,
);
const kSubTextStyle = TextStyle(fontSize: 16);
const kAlertTextStyle = TextStyle(fontSize: 16, color: kAlertColor);

var kTitleTextstyle = TextStyle(
  fontSize: 16,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.bold).fontFamily,
  fontWeight: FontWeight.bold,
);

var kContentTextstyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w600).fontFamily,
);

var kAppBarstyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w800,
  color: kTextColor,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w800).fontFamily,
);

var kChatnumberTextstyle = TextStyle(
  fontSize: 8,
  fontWeight: FontWeight.w800,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w800).fontFamily,
);
var kregularTextstyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w500).fontFamily,
  height: 2.0,
);

var kExtrasmalextstyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w400).fontFamily,
);

var kExtra2Textstyle = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w400).fontFamily,
);
var ksmallTextstyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  fontFamily: GoogleFonts.montserrat(fontWeight: FontWeight.w400).fontFamily,
);

const gradientSelected = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kPrimaryColor,
    kSecondaryColor,
  ],
);
const primaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFF04054),
    Color(0xFFF7A137),
  ],
);
const secondaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFF6BDBFF),
    Color(0xFF00BBF7),
  ],
);

const tertiaryGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    kTertiaryColor,
    kSecondaryColor,
  ],
);

extension CustomString on String {
  String capitalizeFirstLetter() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

Widget kImageErrorBuilder(
    BuildContext ctx, Object error, StackTrace? stackTrace) {
  return FadeInImage.memoryNetwork(
    placeholder: kTransparentImage,
    imageErrorBuilder: kErrorBuilder,
    image: fallBackImageUrl,
    fit: BoxFit.cover,
  );
}

Widget kProfileImageErrorBuilder(
    BuildContext ctx, Object error, StackTrace? stackTrace) {
  return FadeInImage.memoryNetwork(
    placeholder: kTransparentImage,
    imageErrorBuilder: kErrorBuilder,
    image: fallBackAvatar,
    fit: BoxFit.cover,
  );
}

Widget kErrorBuilder(BuildContext ctx, Object error, StackTrace? stackTrace) {
  return FadeInImage.memoryNetwork(
    placeholder: kTransparentImage,
    imageErrorBuilder: kErrorBuilder,
    image:
        "https://images.pexels.com/photos/2347495/pexels-photo-2347495.jpeg?auto=compress&cs=tinysrgb&w=300",
    fit: BoxFit.cover,
  );
}

Widget sectionDivider() {
  return Container(
    height: 5,
    width: 40,
    decoration: BoxDecoration(
      color: kTextColor.withValues(alpha: 0.45),
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
