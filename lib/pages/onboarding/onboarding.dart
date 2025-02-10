import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/models/preferences.dart';
import 'package:sensotech/pages/onboarding/models/onboardmodel.dart';
import 'package:sensotech/pages/root/root_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 24.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? kPrimaryColor : const Color(0xFF959595),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: SingleChildScrollView(
              child: SizedBox(
                height: Helper.setHeight(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PageView(
                        physics: const ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: const [
                          OnboardModel(
                            title: "Welcome to Sensotech!",
                            color: kPrimaryColor,
                            image: 'assets/images/onb1.png',
                            subtitle:
                                'Stay in control of your depot inventory with real-time sensor data, automated tracking, and instant alerts. Optimize supply chain efficiency and prevent stock issues effortlessly.',
                          ),
                          OnboardModel(
                            title: "Track, Analyze & Optimize Your Oil Storage",
                            color: kPrimaryColor,
                            image: 'assets/images/onb2.png',
                            subtitle:
                                'Sensotech helps you make informed decisions with live dashboards, smart reports, and predictive analytics. Keep stock levels optimal and reduce waste with ease.',
                          ),
                          OnboardModel(
                            title: "Never Miss a Critical Alert",
                            color: kPrimaryColor,
                            image: 'assets/images/onb3.png',
                            subtitle:
                                'Get real-time alerts for low stock, overfill risks, and unusual usage patterns. Always stay one step ahead to avoid disruptions.',
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: _buildPageIndicator(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 4.0),
                                    elevation: 5.0,
                                    backgroundColor: kPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                  onPressed: () {
                                    if (_currentPage == _numPages - 1) {
                                      UserPreferences.setCheckStatus(1);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) => RootPage()),
                                          (Route<dynamic> route) => false);
                                    } else {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  child: const Icon(
                                    Icons.chevron_right_rounded,
                                    color: kTextFallbackColor,
                                    size: 40.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
