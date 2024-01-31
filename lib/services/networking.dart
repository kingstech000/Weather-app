// ignore_for_file: avoid_print

import 'package:http/http.dart';
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  String url;

  Future getNetwork() async {
    Response myresponse = await get(Uri.parse(url));
    if (myresponse.statusCode == 200) {
      String data = myresponse.body;
      var jsonCode = jsonDecode(data);
      return jsonCode;
    } else {
      print(myresponse.statusCode);
    }
  }
}
