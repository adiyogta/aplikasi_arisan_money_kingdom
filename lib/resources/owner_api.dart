import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class OwnerApiProvider {
  Client client = Client();

  Future<Map<String, dynamic>> attemptLogOut() async {
    String value = await storage.read(key: 'jwt');
    var res = await client.post(Uri.encodeFull("$_url/owner/logout"), headers: {
      "Authorization": "Bearer $value",
      'Content-Type': 'application/json; charset=UTF-8',
    });
    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;
    print(res.body);
    return result;
  }
}
