import 'dart:async';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sensotech/controllers/client_controller.dart';
import 'package:sensotech/models/connection_service.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/models/preferences.dart';
import 'package:sensotech/models/spinner.dart';
import 'package:sensotech/pages/homepage/homepage.dart';
import 'package:sensotech/pages/login/login.dart';
import 'package:sensotech/pages/onboarding/onboarding.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WidgetsBindingObserver {
  int? check = 0;
  Future<int?>? future;

  void loginCallback() {
    future = UserPreferences.getClientID();
    future?.then((v) {});
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    WidgetsBinding.instance.addObserver(this);
    getDone();
    loginCallback();
    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      if (!hasConnection) {
        Helper.showInSnackBar(context, "You are offline", 'failure');
      }
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {}

  getDone() async {
    var res = await UserPreferences.getCheckStatus();
    setState(() {
      check = res;
    });
  }

  void logOut() {
    UserPreferences.logOut();
    Get.delete<ClientController>();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RootPage()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return future == null ? buildWaitingScreen() : body();
  }

  Widget buildWaitingScreen() {
    return const LoadingWidget();
  }

  FutureBuilder<int?> body() {
    return FutureBuilder<int?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildWaitingScreen();
          } else {
            if (check == null) {
              return OnboardingScreen();
            } else if (snapshot.hasData && snapshot.data != null) {
              return HomePage(
                clientId: snapshot.data!,
                logoutCallback: logOut,
              );
            } else {
              return LoginSignUpPage(
                loginCallback: loginCallback,
              );
            }
          }
        });
  }
}
