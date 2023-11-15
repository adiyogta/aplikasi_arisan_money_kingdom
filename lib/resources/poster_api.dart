import 'dart:async';
import 'dart:io';
import 'package:aplikasi_arisan/page/model/poster_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class PosterApiProvider {
  Future<PosterModel> fetchPaketList() async {
    String value = await storage.read(key: 'jwt');
    final Dio _dio = Dio(
      BaseOptions(
        baseUrl: _url,
        headers: {
          "Authorization": "Bearer $value",
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ),
    );
    try {
      Response response = await _dio.get('/poster');
      return PosterModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PosterModel.withError("Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> attemptBuatPoster(
    String nama,
    String deskripsi,
    File foto,
  ) async {
    String value = await storage.read(key: 'jwt');

    var headers = {'Authorization': 'Bearer $value'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.moneykingdom.org/api/poster'));
    request.fields.addAll({'nama': nama, 'deskripsi': deskripsi});
    request.files.add(await http.MultipartFile.fromPath('foto', foto.path));
    request.headers.addAll(headers);

    http.Response res = await http.Response.fromStream(await request.send());

    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;
    print(res.body);
    return result;
  }

  Future<Map<String, dynamic>> attemptUbahPoster(
      String nama, File foto, String deskripsi, String id) async {
    String value = await storage.read(key: 'jwt');

    var headers = {'Authorization': 'Bearer $value'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.moneykingdom.org/api/poster/$id'));
    request.fields.addAll({
      '_method': 'PUT',
      'nama': nama,
      'deskripsi': deskripsi,
    });
    request.files.add(await http.MultipartFile.fromPath('foto', foto.path));
    request.headers.addAll(headers);

    http.Response res = await http.Response.fromStream(await request.send());

    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;
    print(res.body);
    return result;
  }

  Future<Map<String, dynamic>> attemptHapusPoster(String id) async {
    String value = await storage.read(key: 'jwt');

    var res = await http.delete(Uri.encodeFull("$_url/poster/" + id), headers: {
      "Authorization": "Bearer $value",
      'Content-Type': 'application/json; charset=UTF-8',
    });
    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;
    print(res.body);
    return result;
  }
}
