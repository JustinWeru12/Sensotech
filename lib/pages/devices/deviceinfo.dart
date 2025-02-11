import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sensotech/classes/device.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/models/helper.dart';
import 'package:sensotech/models/neumorphism.dart';
import 'package:sensotech/models/spacers.dart';
import 'package:sensotech/models/tank.dart';

class DeviceInfoPage extends StatefulWidget {
  const DeviceInfoPage({super.key, required this.data});
  final DeviceData data;

  @override
  State<DeviceInfoPage> createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
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
    return SliverAppBar(
      expandedHeight: 80.0,
      backgroundColor: Colors.transparent,
      floating: false,
      leading: SizedBox.shrink(),
      pinned: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(4.0),
        child: FlexibleSpaceBar(
          background: Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 12.0),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Row(
                children: [
                  BackButton(
                    color: kBackgroundColor,
                  ),
                  Expanded(
                    child: Text(widget.data.name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: kAppBarstyle.copyWith(color: kBackgroundColor)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget body() {
    var data = widget.data;
    var percent = double.tryParse(data.percentage ?? "0.0") ?? 1;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpacer,
          smallVerticalSpacer,
          Text(
            "Supply Type",
            style: kTitleTextstyle.copyWith(
              // color: kSecondaryColor,
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          divider(0.76),
          headingEntry(),
          verticalSpacer,
          Text(
            "Capacity Remaining",
            style: kTitleTextstyle.copyWith(
              // color: kSecondaryColor,
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          divider(0.68),
          verticalSpacer,
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 20,
            children: [
              infoEntry(
                  "Maximum", "${data.maxCapacity ?? "--"}\nLitres", "Capacity"),
              infoEntry("Total", "${data.volume ?? "--"}\nLitres", "Volume"),
              infoEntry("Remaining", "${data.volumeRemaining ?? "--"}\nLitres",
                  "Volume"),
              infoEntry("Daily", "${data.ratePerDay ?? "--"}\nLitres", "Rate"),
              infoEntry(
                  "Remaining", "${data.daysRemaining ?? "--"}\nDays", "Days"),
              SizedBox(width: 155, height: 0),
            ],
          ),
          verticalSpacer,
          verticalSpacer,
          Text(
            "Tank Level",
            style: kTitleTextstyle.copyWith(
              // color: kSecondaryColor,
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          divider(0.78),
          smallVerticalSpacer,
          FuelTankWidget(
            percentageFilled: percent.toString(),
            supplyType: data.supplyType ?? "",
            color: colorFromStatus(data),
          ),
          verticalSpacer,
        ],
      ),
    );
  }

  Widget headingEntry() {
    var data = widget.data;
    var percent = double.tryParse(data.percentage ?? "0.0") ?? 1;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 5,
            children: [
              smallVerticalSpacer,
              Text(
                data.supplyType ?? "_",
                style: kregularTextstyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Updated: ${data.dateOfLastLog ?? "_"}",
                style: kregularTextstyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              smallVerticalSpacer,
            ],
          ),
        ),
        CircularPercentIndicator(
          animation: true,
          lineWidth: 10.0,
          radius: 40,
          percent: percent / 100,
          backgroundColor: Colors.grey.withValues(alpha: 0.2),
          progressColor: colorFromStatus(data),
          circularStrokeCap: CircularStrokeCap.round,
          center: Text(
            "$percent%",
            style: kregularTextstyle.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }

  Widget infoEntry(String title, String value, String subtitle) {
    return SizedBox(
      width: 155,
      child: Row(
        spacing: 12.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatNeumorphism(
              radius: 10,
              color: kPrimaryColor,
              child: SizedBox(
                height: 70,
                width: 70,
                child: Center(
                  child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: kTitleTextstyle.copyWith(
                      // color: kSecondaryColor,
                      fontSize: 14,
                      color: kBackgroundColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )),
          SizedBox(
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: kTitleTextstyle.copyWith(
                    // color: kSecondaryColor,
                    fontSize: 14,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle.isNotEmpty ? subtitle : "_",
                  style: kregularTextstyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget divider(factor) {
    return Divider(
      color: kPrimaryColor.withValues(alpha: 0.4),
      endIndent: Helper.setWidth(context, factor: factor),
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
