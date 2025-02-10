// To parse this JSON data, do
//
//     final clientData = clientDataFromMap(jsonString);

import 'dart:convert';

List<ClientData> clientDataFromMap(String str) =>
    List<ClientData>.from(json.decode(str).map((x) => ClientData.fromMap(x)));

String clientDataToMap(List<ClientData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ClientData {
  final String? depotId;
  final String? name;
  final String? deviceCount;
  final String? amberCount;
  final String? redCount;
  final String? greenCOunt;

  ClientData({
    this.depotId,
    this.name,
    this.deviceCount,
    this.amberCount,
    this.redCount,
    this.greenCOunt,
  });

  factory ClientData.fromMap(Map<String, dynamic> json) => ClientData(
        depotId: json["depotId"],
        name: json["name"],
        deviceCount: json["deviceCount"],
        amberCount: json["amberCount"],
        redCount: json["redCount"],
        greenCOunt: json["greenCOunt"],
      );

  Map<String, dynamic> toMap() => {
        "depotId": depotId,
        "name": name,
        "deviceCount": deviceCount,
        "amberCount": amberCount,
        "redCount": redCount,
        "greenCOunt": greenCOunt,
      };
}
