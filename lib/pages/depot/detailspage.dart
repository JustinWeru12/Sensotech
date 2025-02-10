import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sensotech/api/crud.dart';
import 'package:sensotech/classes/client.dart';
import 'package:sensotech/classes/depot_details.dart';
import 'package:sensotech/constants/theme.dart';
import 'package:sensotech/models/emptystate.dart';
import 'package:sensotech/models/neumorphism.dart';

class DepotDetails extends StatefulWidget {
  final ClientData data;
  const DepotDetails({super.key, required this.data});

  @override
  State<DepotDetails> createState() => _DepotDetailsState();
}

class _DepotDetailsState extends State<DepotDetails> {
  late Future<List<DeviceData>> future;

  @override
  void initState() {
    future = CrudMethods().getDepotData(widget.data.depotId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(widget.data.name ?? "Depot Details", style: kAppBarstyle),
      centerTitle: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget body() {
    return FutureBuilder<List<DeviceData>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemBuilder: (c, i) {
                var device = data[i];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: devicesCard(device),
                );
              });
        });
  }

  Widget devicesCard(DeviceData client) {
    return InkWell(
      onTap: () => {},
      child: FlatNeumorphism(
          radius: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Icon(
                          PhosphorIconsBold.broadcast,
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
                            "Days Remaining: ${client.daysRemaining ?? "0"}",
                            style: ksmallTextstyle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
