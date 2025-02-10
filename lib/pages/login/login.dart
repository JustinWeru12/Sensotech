import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sensotech/api/crud.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/models/neumorphism.dart';
import 'package:sensotech/models/preferences.dart';
import 'package:sensotech/models/primary_button.dart';
import 'package:sensotech/models/spacers.dart';
import 'package:sensotech/models/spinner.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key, this.loginCallback});

  final VoidCallback? loginCallback;
  @override
  LoginSignUpPageState createState() => LoginSignUpPageState();
}

class LoginSignUpPageState extends State<LoginSignUpPage>
    with TickerProviderStateMixin {
  static final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  String? _email;
  String? _password;
  bool _isLoading = false;
  CrudMethods crudObj = CrudMethods();

  bool validateAndSave() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    if (validateAndSave()) {
      setState(() {
        _isLoading = true;
      });
      try {
        crudObj.login(_email!, _password!).then((v) {
          UserPreferences.setUser(v);
          UserPreferences.setClientID(v.sensotechClientId!);
          widget.loginCallback!();
          setState(() {
            _isLoading = false;
          });
        });
      } on Exception catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          _showErrorDialog(e);
        }
      }
    }
  }

  List<String> getSubstrings(String label) {
    List<String> substring = [];
    for (var i = 1; i <= label.length; i++) {
      substring.add(label.substring(0, i).toLowerCase());
    }
    return substring;
  }

  openLink(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppBrowserView,
    )) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: Helper.setWidth(context),
            height: Helper.setHeight(context, factor: 0.6),
            child: Image.asset(
              "assets/images/onb1.png",
              fit: BoxFit.cover,
            ),
          ),
          pageConstruct(),
        ],
      ),
    );
  }

  Widget pageConstruct() {
    return SizedBox(
      height: Helper.setHeight(context),
      width: Helper.setWidth(context),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(flex: 3),
              verticalSpacer,
              forms(),
              verticalSpacer,
              tos(),
            ],
          ),
        ),
      ),
    );
  }

  Widget forms() {
    return FlatNeumorphism(
      radius: 15,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            smallVerticalSpacer,
            Text(
              "Welcome to\nSensotech.",
              textAlign: TextAlign.center,
              style: kAppBarstyle.copyWith(color: kTextColor, fontSize: 22),
            ),
            verticalSpacer,
            _buildForm(),
            smallVerticalSpacer,
            verticalSpacer,
          ],
        ),
      ),
    );
  }

  Widget tos() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: 'By signing up you agree to the ',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.30,
                ),
              ),
              TextSpan(
                text: 'Terms and Conditions',
                recognizer: TapGestureRecognizer()
                  ..onTap = () => openLink(Uri.parse(
                      "https://sensotech.co.uk/terms-and-conditions/")),
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.30,
                ),
              ),
              const TextSpan(
                text: ' for Sensotech and understand the ',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.30,
                ),
              ),
              TextSpan(
                text: 'Privacy Policy',
                recognizer: TapGestureRecognizer()
                  ..onTap = () => openLink(
                      Uri.parse("https://sensotech.co.uk/privacy-policy/")),
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.30,
                ),
              ),
              const TextSpan(
                text: '.',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.30,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ));
  }

  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpacer,
            Text(
              "Enter Your Information Below.",
              textAlign: TextAlign.center,
              style:
                  kregularTextstyle.copyWith(color: kTextColor, fontSize: 14),
            ),
            verticalSpacer,
            smallVerticalSpacer,
            _buildEmailField(),
            smallVerticalSpacer,
            _buildPasswordField(),
            verticalSpacer,
            _isLoading == false ? submitWidgets() : _showCircularProgress(),
          ],
        ));
  }

  OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.0),
    borderSide: const BorderSide(color: kFormColor),
  );

  Widget _buildEmailField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TextFormField(
        key: const Key('email'),
        maxLines: 1,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
          filled: true,
          hintText: 'Email',
          fillColor: kFormColor,
          hintStyle: kSubTextStyle.copyWith(color: kTextColor),
          border: border,
          enabledBorder: border,
        ),
        style: kregularTextstyle.copyWith(color: kTextColor),
        keyboardType: TextInputType.emailAddress,
        validator: (String? value) {
          if (value!.isEmpty ||
              !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                  .hasMatch(value)) {
            return 'Enter a valid email';
          }
          return null;
        },
        onSaved: (value) => _email = value!.replaceAll(" ", ""),
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        maxLines: 1,
        key: const Key('password'),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10.0, right: 6.0),
          filled: true,
          hintText: 'Password',
          fillColor: kFormColor,
          hintStyle: kSubTextStyle.copyWith(color: kTextColor),
          border: border,
          enabledBorder: border,
        ),
        style: kregularTextstyle.copyWith(color: kTextColor),
        controller: _passwordTextController,
        obscureText: true,
        validator: (String? value) {
          if (value!.isEmpty) {
            return 'Enter a strong password';
          }
          return null;
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget submitWidgets() {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        children: [
          PrimaryButton(
            key: const Key('login'),
            text: 'Login',
            color: kPrimaryColor,
            textColor: kBackgroundColor,
            height: 48.0,
            onPressed: validateAndSubmit,
          ),
          smallVerticalSpacer,
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget _showCircularProgress() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: const Center(child: ProgressLoader()),
    );
  }

  void _showErrorDialog(error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 8.0),
          backgroundColor: kBackgroundColor,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: kPrimaryColor.withValues(alpha: 0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Error",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$error",
                    style: const TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
}
