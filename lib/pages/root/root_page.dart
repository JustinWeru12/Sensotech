import 'dart:async';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter/material.dart';
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
    future?.then((v) {
      print("ClientID: $v");
    });
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
