import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sensotech/constants/theme.dart';
import 'dart:math' show cos, sqrt, asin;

class Helper {
  static double setHeight(BuildContext context, {factor = 1}) {
    return MediaQuery.of(context).size.height * factor;
  }

  static double setWidth(BuildContext context, {factor = 1}) {
    return MediaQuery.of(context).size.width * factor;
  }

  static slideToPage(context, screen, {maintainstate = true}) {
    Navigator.push(
        context, SlideRightToLeft(page: screen, maintainstate: maintainstate));
  }

  static scaleToPage(context, screen, {maintainstate = true}) {
    Navigator.push(
        context, ScaleFromCenter(page: screen, maintainstate: maintainstate));
  }

  static bool isDark(BuildContext context) {
    return AdaptiveTheme.of(context).brightness == Brightness.dark;
  }

  static showInDialog({
    required BuildContext context,
    required String title,
    required String subtitle,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 8.0),
          backgroundColor: kBackgroundColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    subtitle,
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.blue),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showInSnackBar(context, value, type) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      duration: const Duration(milliseconds: 2500),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: type == 'success' ? kSecondaryColor : kAlertColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Row(
                  children: [
                    const SizedBox(width: 40),
                    Expanded(
                      child: Text(
                        value,
                        style: kTitleTextstyle.copyWith(
                            fontSize: 12, color: kBackgroundColor), // TextStyle
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
                child: SvgPicture.asset(
                  "assets/icons/snack_bubbles.svg",
                  height: 38,
                  width: 40,
                  colorFilter:
                      ColorFilter.mode(getAssets(type).color, BlendMode.srcIn),
                ),
              ),
            ),
            Positioned(
              top: -18,
              left: 0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset("assets/icons/snack_top.svg",
                      height: 38,
                      colorFilter: ColorFilter.mode(
                          getAssets(type).color, BlendMode.srcIn)),
                  Positioned(
                    top: 10,
                    child: SvgPicture.asset(
                      getAssets(type).asset,
                      height: 14,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  static ContentType getAssets(String input) {
    switch (input) {
      case 'failure':
        return ContentType(AssetsPath.failure, kOnAlertColor);
      case 'success':
        return ContentType(AssetsPath.success, kPrimaryColor);
      case 'warning':
        return ContentType(AssetsPath.warning, kTertiaryColor);
      default:
        return ContentType(AssetsPath.success, kTertiaryColor);
    }
  }

  static String displayTimeAgoFromTimestamp(DateTime date,
      {bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(date);

    if ((difference.inDays / 365).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} years ago';
    } else if ((difference.inDays / 365).floor() >= 1) {
      return (numericDates) ? '1 year ago' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 2) {
      return '${(difference.inDays / 365).floor()} months ago';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 month ago' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 2) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static String getAbbreviation(String input) {
    List<String> words = input.split(' ');
    if (words.isEmpty) {
      return '';
    } else if (words.length == 1) {
      if (words[0].length >= 2) {
        return words[0].substring(0, 2).toUpperCase();
      } else {
        return words[0].toUpperCase();
      }
    } else {
      String abbreviation = '';
      for (String word in words) {
        if (word.isNotEmpty) {
          abbreviation += word[0];
        }
      }
      if (abbreviation.length >= 2) {
        return abbreviation.substring(0, 2).toUpperCase();
      } else {
        return abbreviation.toUpperCase();
      }
    }
  }
}

class SlideRightToLeft extends PageRouteBuilder {
  final Widget page;
  final bool maintainstate;
  SlideRightToLeft({required this.page, this.maintainstate = true})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          maintainState: maintainstate,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}

class ScaleFromCenter extends PageRouteBuilder {
  final Widget page;
  final bool maintainstate;
  ScaleFromCenter({required this.page, this.maintainstate = true})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          maintainState: maintainstate,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              ScaleTransition(
            alignment: Alignment.center,
            scale:
                CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
            child: child,
          ),
        );
}

class AssetsPath {
  static const String failure = 'assets/icons/snack_fail.svg';
  static const String success = 'assets/icons/snack_success.svg';
  static const String warning = 'assets/icons/snack_warning.svg';
}

class ContentType {
  final String asset;
  final Color color;

  ContentType(this.asset, this.color);
}
