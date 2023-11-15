import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:aplikasi_arisan/page/model/arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/model/detail_arisan_berjalan_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class ArisanBerjalanApiProvider {
  Future<ArisanBerjalanModel> fetchArisanBerjalanList() async {
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
      Response response = await _dio.get('/arisan/berjalan');
      print(response.data);
      return ArisanBerjalanModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArisanBerjalanModel.withError("Data not found / Connection issue");
    }
  }

  Future<ArisanBerjalanDetailModel> fetchArisanBerjalanDetailList() async {
    String id = await storage.read(key: 'id_ArisanBerjalan');
    print(id);
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
      Response response = await _dio.get('/arisan/berjalan/' + id);
      print(response.data);
      return ArisanBerjalanDetailModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArisanBerjalanDetailModel.withError(
          "Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> updateValidasi(
    String id,
    String status,
  ) async {
    String value = await storage.read(key: 'jwt');
    var a = json.encode({
      "status": status,
    });
    var response = await http.put(
      Uri.encodeFull("$_url/transaksi/validasi/" + id),
      headers: {
        "Authorization": "Bearer $value",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: a,
    );
    print(response.body);
    print(a);
    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }

  Future<Map<String, dynamic>> selesaiAB(
    String tgl,
    String status,
  ) async {
    String value = await storage.read(key: 'jwt');
    // String id = await storage.read(key: 'id_arisanDitawarkan');
    String id = await storage.read(key: 'id_ArisanBerjalan');
    print(id);
    var a = json.encode({
      "finish_arisan": tgl,
      "status": status,
    });
    var response = await http.put(
      Uri.encodeFull("$_url/arisan/$id"),
      headers: {
        "Authorization": "Bearer $value",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: a,
    );
    print(response.body);
    print(a);
    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }

  // Future<Map<String, dynamic>> uploadBuktiMenang(
  //   String bukti,
  // ) async {
  //   String id = await storage.read(key: 'id_PesertaBuktiMenang');
  //   print(id);
  //   String value = await storage.read(key: 'jwt');
  //   var a = json.encode({
  //     "bukti_transfer_menang": bukti,
  //   });
  //   var response = await client.put(
  //     Uri.encodeFull("$_url/status/menang/" + id),
  //     headers: {
  //       "Authorization": "Bearer $value",
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: a,
  //   );
  //   print(response.body);
  //   print(a);
  //   // parsing JSOn or throwing an exception
  //   Map<String, dynamic> result = json.decode(response.body);
  //   result['status_code'] = response.statusCode;

  //   return result;
  // }

  Future<Map<String, dynamic>> uploadBuktiMenang(String id, File bukti) async {
    String value = await storage.read(key: 'jwt');

    var headers = {'Authorization': 'Bearer $value'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://api.moneykingdom.org/api/status/menang/$id'));
    request.fields.addAll({'_method': 'put'});
    request.files.add(
        await http.MultipartFile.fromPath('bukti_transfer_menang', bukti.path));
    request.headers.addAll(headers);

    http.Response response =
        await http.Response.fromStream(await request.send());
// ---------------------------------------
    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    print(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }

  Future<Map<String, dynamic>> uploadBuktiBayar(
      List<String> id, File bukti) async {
    String value = await storage.read(key: 'jwt');

    var headers = {'Authorization': 'Bearer $value'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.moneykingdom.org/api/transaksi/upload'));

    request.fields.addAll({
      '_method': 'put',
      for (int i = 0; i < id.length; i++) 'transaksi${[i]}[id]': id[i],
    });
    request.files
        .add(await http.MultipartFile.fromPath('bukti_pembayaran', bukti.path));
    request.headers.addAll(headers);
    print(request.fields);
    http.Response response =
        await http.Response.fromStream(await request.send());
// ---------------------------------------
    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    print(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }
}
