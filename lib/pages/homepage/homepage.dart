import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sensotech/classes/client.dart';
import 'package:sensotech/classes/user.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/controllers/client_controller.dart';
import 'package:sensotech/models/avatarmenu.dart';
import 'package:sensotech/models/emptystate.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/models/neumorphism.dart';
import 'package:sensotech/models/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sensotech/models/spacers.dart';
import 'package:sensotech/models/spinner.dart';
import 'package:sensotech/pages/devices/devicelist.dart';

class HomePage extends StatefulWidget {
  final int clientId;
  final VoidCallback logoutCallback;
  const HomePage(
      {super.key, required this.clientId, required this.logoutCallback});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool willPop = false;
  UserPreferences userPref = UserPreferences();
  final controller = Get.put(ClientController());
  List<ClientData>? clientData;
  UserData? userData;

  @override
  void initState() {
    getClient();
    getUser();
    super.initState();
  }

  getClient() async {
    await controller.getClient(widget.clientId.toString());
  }

  getUser() async {
    userData = await UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (v, _) async {
        if (v) {
          return;
        }
        _onBackPressed();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          getClient();
        },
        child: Scaffold(
          body: Obx(() {
            clientData = controller.data;
            if (controller.data.isEmpty) {
              return const Center(child: ProgressLoader());
            }
            return _body();
          }),
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        titleSection(),
        depotList(),
      ],
    );
  }

  Widget titleSection() {
    return Container(
      color: kPrimaryColor,
      child: Column(
        children: [
          SafeArea(child: Container()),
          smallVerticalSpacer,
          smallVerticalSpacer,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              horizontalSpacer,
              SizedBox(
                child: RichText(
                  text: TextSpan(
                    text: "Welcome Back 🖐\n",
                    style: kTitleTextstyle.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        height: 1.6,
                        color: kTextLightColor),
                    children: [
                      TextSpan(
                          text: userData?.fullName ?? "",
                          style: kregularTextstyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: kTextLightColor,
                              height: 1.2)),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              smallHorizontalSpacer,
              UserAvatarMenu(onLogout: widget.logoutCallback)
            ],
          ),
          verticalSpacer,
        ],
      ),
    );
  }

  Widget depotList() {
    if ((clientData ?? []).isEmpty) {
      return EmptyList(
          icon: PhosphorIconsBold.gasPump,
          title: "No Depots",
          subtitle: "There are no depots associated with your account");
    }
    return Expanded(
      child: ListView.builder(
          itemCount: clientData?.length ?? 0,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 8.0, bottom: 20.0),
          itemBuilder: (c, i) {
            var client = clientData![i];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
              child: depotCard(client),
            );
          }),
    );
  }

  Widget depotCard(ClientData client) {
    return InkWell(
      onTap: () => Helper.slideToPage(context, DeviceList(data: client)),
      child: FlatNeumorphism(
          radius: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 5,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(
                      PhosphorIconsBold.gasPump,
                      size: 22,
                      color: kBackgroundColor,
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 4,
                    children: [
                      Text(
                        client.name ?? "",
                        style: kContentTextstyle,
                      ),
                      Text(
                        "Devices: ${client.deviceCount ?? "0"}",
                        style: ksmallTextstyle,
                      ),
                    ],
                  ),
                ),
                count(kGreenColor, client.greenCOunt?.toString() ?? "0"),
                count(kTertiaryColor, client.amberCount?.toString() ?? "0"),
                count(kAlertColor, client.redCount?.toString() ?? "0"),
              ],
            ),
          )),
    );
  }

  Widget count(Color color, String count) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), // Outer circle color
          border: Border.all(color: color, width: 2), // Outer border
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Container(
              width: 40, // Inner circle size
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: color, // Inner circle color
              ),
              child: Center(
                child: Text(
                  count,
                  textAlign: TextAlign.center,
                  style: kTitleTextstyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: kBackgroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Are you sure you want to exit the app!',
                  textAlign: TextAlign.center,
                  style: kTitleTextstyle,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          backgroundColor: kAlertColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Exit",
                            style: kTitleTextstyle.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          SystemNavigator.pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          elevation: 5.0,
                          backgroundColor: kGreenColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16.0))),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Cancel",
                            style: kTitleTextstyle.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
