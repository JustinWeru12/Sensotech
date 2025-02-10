// To parse this JSON data, do
//
//     final depotDetails = depotDetailsFromMap(jsonString);

import 'dart:convert';

List<DeviceData> depotDetailsFromMap(String str) =>
    List<DeviceData>.from(json.decode(str).map((x) => DeviceData.fromMap(x)));

String depotDetailsToMap(List<DeviceData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DeviceData {
  final String? name;
  final String? percentage;
  final dynamic ratePerDay;
  final dynamic daysRemaining;
  final String? supplyType;
  final String? maxCapacity;
  final String? volume;
  final String? volumeRemaining;
  final String? dateOfLastLog;
  final bool? redWarning;
  final bool? amberWarning;
  final bool? greenWarning;

  DeviceData({
    this.name,
    this.percentage,
    this.ratePerDay,
    this.daysRemaining,
    this.supplyType,
    this.maxCapacity,
    this.volume,
    this.volumeRemaining,
    this.dateOfLastLog,
    this.redWarning,
    this.amberWarning,
    this.greenWarning,
  });

  factory DeviceData.fromMap(Map<String, dynamic> json) => DeviceData(
        name: json["name"],
        percentage: json["percentage"],
        ratePerDay: json["ratePerDay"],
        daysRemaining: json["daysRemaining"],
        supplyType: json["supplyType"],
        maxCapacity: json["maxCapacity"],
        volume: json["volume"],
        volumeRemaining: json["volumeRemaining"],
        dateOfLastLog: json["dateOfLastLog"],
        redWarning: json["redWarning"],
        amberWarning: json["amberWarning"],
        greenWarning: json["greenWarning"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "percentage": percentage,
        "ratePerDay": ratePerDay,
        "daysRemaining": daysRemaining,
        "supplyType": supplyType,
        "maxCapacity": maxCapacity,
        "volume": volume,
        "volumeRemaining": volumeRemaining,
        "dateOfLastLog": dateOfLastLog,
        "redWarning": redWarning,
        "amberWarning": amberWarning,
        "greenWarning": greenWarning,
      };
}
