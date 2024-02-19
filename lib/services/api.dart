import 'dart:convert';
import 'global.dart';
import 'package:http/http.dart' as http;

class Api {
  static var secret = Global.secretkey;

  //get Product Api
  static Future getproducts(var warehouse_id) async {
    var apiUrl = Global.productlist;
    final response = await http.post(Uri.parse(apiUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
    }, body: {
      "secret_key": secret,
      "warehouse_id": warehouse_id,
    });
    final data = jsonDecode(response.body);
    return data;
  }
}
