import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sensotech/api/crud.dart';
import 'package:sensotech/classes/client.dart';

class ClientController extends GetxController {
  // ignore: prefer_final_fields
  var clientData = <ClientData>[].obs;

  List<ClientData> get data => clientData;

  Future<void> getClient(String id) async {
    try {
      final value = await CrudMethods().getClientData(id);
      clientData.assignAll(value); // Efficient way to update observable lists
    } catch (e) {
      debugPrint("Error fetching client data: $e");
    }
  }
}
