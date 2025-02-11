import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sensotech/api/crud.dart';
import 'package:sensotech/classes/client.dart';
import 'package:sensotech/classes/device.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/models/emptystate.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/models/neumorphism.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sensotech/models/spinner.dart';
import 'package:sensotech/pages/devices/deviceinfo.dart';

class DeviceList extends StatefulWidget {
  final ClientData data;
  const DeviceList({super.key, required this.data});

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  late Future<List<DeviceData>> future;
  bool refreshing = false;

  @override
  void initState() {
    future = CrudMethods().getDepotData(widget.data.depotId!);
    super.initState();
  }

  void refreshData() async {
    setState(() {
      refreshing = true;
      future = CrudMethods().getDepotData(widget.data.depotId!);
    });
    await Future.delayed(Duration(milliseconds: 2000));
    setState(() {
      refreshing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));
        refreshData();
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            sliverAppBar(),
            SliverList(
              delegate: SliverChildListDelegate([
                body(),
              ] // Example content
                  ),
            ),
          ],
        ),
      ),
    );
  }

  SliverAppBar sliverAppBar() {
    var deviceCount = widget.data.deviceCount ?? 0;
    var subtitle =
        deviceCount == "1" ? "$deviceCount Device" : "$deviceCount Devices";
    return SliverAppBar(
      expandedHeight: 60.0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: kBackgroundColor),
      floating: false,
      pinned: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.data.name ?? "",
              overflow: TextOverflow.ellipsis,
              style: kAppBarstyle.copyWith(color: kBackgroundColor)),
          Text(subtitle,
              overflow: TextOverflow.ellipsis,
              style: kAppBarstyle.copyWith(color: kBackgroundColor)),
        ],
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: kPrimaryColor),
      ),
    );
  }

  Widget body() {
    return FutureBuilder<List<DeviceData>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(height: 300, child: ProgressLoader());
          }
          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(
                child: EmptyList(
                    icon: PhosphorIconsBold.broadcast,
                    title: "No Devices",
                    subtitle:
                        "There are no devices associated with this depot"));
          }
          List<DeviceData> data = snapshot.data ?? [];
          return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemBuilder: (c, i) {
                var device = data[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: devicesCard(device),
                );
              });
        });
  }

  Widget devicesCard(DeviceData data) {
    var percent = double.tryParse(data.percentage ?? "0.0") ?? 1;
    return InkWell(
      onTap: () => Helper.slideToPage(context, DeviceInfoPage(data: data)),
      child: FlatNeumorphism(
          radius: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(
                          PhosphorIconsBold.broadcast,
                          size: 22,
                          color: kBackgroundColor,
                        )),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 4,
                        children: [
                          Text(
                            data.name ?? "",
                            style: kContentTextstyle,
                          ),
                          Text(
                            "Days Remaining: ${data.daysRemaining ?? "0"}",
                            style: ksmallTextstyle,
                          ),
                          Text(
                            "Last Update: ${data.dateOfLastLog ?? ""}",
                            style: ksmallTextstyle,
                          ),
                        ],
                      ),
                    ),
                    CircularPercentIndicator(
                      animation: true,
                      lineWidth: 8.0,
                      radius: 30,
                      percent: percent / 100,
                      backgroundColor: Colors.grey,
                      progressColor: colorFromStatus(data),
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        "$percent%",
                        style: ksmallTextstyle.copyWith(
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: 4)
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Color colorFromStatus(DeviceData data) {
    if (data.amberWarning ?? false) {
      return kTertiaryColor;
    } else if (data.redWarning ?? false) {
      return kAlertColor;
    } else {
      return kGreenColor;
    }
  }
}
