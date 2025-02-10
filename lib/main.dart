import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/pages/root/root_page.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  addLicense();
  runApp(const MyApp());
}

addLicense() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensotech',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: kSecondaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        canvasColor: kBackgroundColor.withValues(alpha: 1),
        textTheme: GoogleFonts.montserratTextTheme().apply(
          bodyColor: kTextColor,
          displayColor: kTextColor,
        ),
        brightness: Brightness.light,
      ),
      home: RootPage(),
    );
  }
}

// keytool -list -v -keystore "C:\Users\USER\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android
