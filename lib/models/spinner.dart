import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/constants/theme.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Helper.setHeight(context),
        width: Helper.setWidth(context),
        child: Stack(
          children: [
            const Positioned.fill(
              child: Image(
                image: AssetImage(
                  'assets/images/onb1.png',
                ),
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 3.0,
                    sigmaY: 3.0,
                  ),
                  child: Container(
                    color: kBackgroundColor.withValues(alpha: 0.2),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Center(
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.7,
                  child:
                      Image.asset('assets/icons/icon.png', fit: BoxFit.contain),
                )),
                const ProgressLoader(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ProgressLoader extends StatelessWidget {
  final Color? color;
  const ProgressLoader({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: color ?? kPrimaryColor,
        size: 60.0,
      ),
    );
  }
}
