import 'dart:async';
import 'package:aplikasi_arisan/page/model/bank_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class BankApiProvider {
  Future<BankModel> fetchBankList() async {
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: _url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    try {
      Response response = await _dio.get('/bank');
      return BankModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return BankModel.withError("Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> attemptBuatBank(String nama) async {
    String value = await storage.read(key: 'jwt');
    print(value);

    var res = await http.post(Uri.encodeFull("$_url/bank"),
        body: json.encode({
          "nama": nama,
        }),
        headers: {
          "Authorization": "Bearer $value",
          'Content-Type': 'application/json; charset=UTF-8',
        });
    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;

    return result;
  }

  Future<Map<String, dynamic>> attemptHapusBank(String id) async {
    print(id);
    String value = await storage.read(key: 'jwt');
    print(value);

    var res = await http.delete(Uri.encodeFull("$_url/bank/$id"), headers: {
      "Authorization": "Bearer $value",
      'Content-Type': 'application/json; charset=UTF-8',
    });

    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;

    return result;
  }

  Future<Map<String, dynamic>> attemptUbahBank(String nama, String id) async {
    String value = await storage.read(key: 'jwt');

    var res = await http.put(Uri.encodeFull("$_url/bank/" + id),
        body: json.encode({
          "nama": nama,
        }),
        headers: {
          "Authorization": "Bearer $value",
          'Content-Type': 'application/json; charset=UTF-8',
        });
    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;

    return result;
  }
}
