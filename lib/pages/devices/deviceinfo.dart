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
    );
  }

  SliverAppBar sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 90.0,
      collapsedHeight: 90.0,
      toolbarHeight: 90.0,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(color: kBackgroundColor),
      floating: false,
      pinned: false,
      title: Text(widget.data.name ?? "",
          overflow: TextOverflow.ellipsis,
          style: kAppBarstyle.copyWith(color: kBackgroundColor)),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: kPrimaryColor),
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
          divider(0.78),
          headingEntry(),
          smallVerticalSpacer,
          Text(
            "Tank Details",
            style: kTitleTextstyle.copyWith(
              // color: kSecondaryColor,
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          divider(0.78),
          smallVerticalSpacer,
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 10,
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
          Text(
            "Tank Level",
            style: kTitleTextstyle.copyWith(
              // color: kSecondaryColor,
              fontSize: 16,
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          divider(0.79),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
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
      ),
    );
  }

  Widget infoEntry(String title, String value, String subtitle) {
    return SizedBox(
      width: Helper.setWidth(context) * 0.45,
      child: FlatNeumorphism(
        color: kTextFallbackColor,
        radius: 5,
        child: Row(
          spacing: 12.0,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: 60,
              child: Center(
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: kTitleTextstyle.copyWith(
                    // color: kSecondaryColor,
                    fontSize: 14,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        // color: kSecondaryColor,
                        fontSize: 13,
                        color: kTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      subtitle.isNotEmpty ? subtitle : "_",
                      style: kregularTextstyle.copyWith(
                        fontSize: 13,
                        color: kTextColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider(factor) {
    return Divider(
      color: kPrimaryColor.withValues(alpha: 0.4),
      endIndent: Helper.setWidth(context, factor: factor),
      height: 2,
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
