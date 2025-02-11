import 'dart:convert';

import 'package:sensotech/classes/client.dart';
import 'package:http/http.dart' as http;
import 'package:sensotech/classes/device.dart';
import 'package:sensotech/classes/user.dart';

class CrudMethods {
  var baseUrl = 'sensotech.azurewebsites.net';
  var apiKey = 'aoaatzdyzddcexvshopflirxhsfydsrq';

  Future<UserData> login(String email, String password) async {
    final queryParameters = {
      'email': email,
      'password': password,
    };
    http.Response response = await http.get(
      Uri.https(baseUrl, '/api/SensotechApp/Login', queryParameters),
      headers: {
        'Apikey': apiKey,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return UserData.fromMap(json.decode(response.body));
    } else {
      throw Exception("Error while fetching data: ${response.body}");
    }
  }

  Future<List<ClientData>> getClientData(String id) async {
    final queryParameters = {
      'sensotechClientId': id,
    };
    http.Response response = await http.get(
      Uri.https(baseUrl, '/api/SensotechApp/GetDepotList', queryParameters),
      headers: {
        'Apikey': apiKey,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return clientDataFromMap(response.body);
    } else {
      throw Exception("Error while fetching data: ${response.body}");
    }
  }

  Future<List<DeviceData>> getDepotData(String id) async {
    final queryParameters = {
      'depotId': id,
    };
    http.Response response = await http.get(
      Uri.https(baseUrl, '/api/SensotechApp/GetDeviceList', queryParameters),
      headers: {
        'Apikey': apiKey,
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return depotDetailsFromMap(response.body);
    } else {
      throw Exception("Error while fetching data: ${response.body}");
    }
  }
}
