import 'dart:async';
import 'package:aplikasi_arisan/page/model/peserta_detail_arisan_berjalan_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class PesertaArisanBerjalanApiProvider {
  Client client = Client();

  Future<PesertaArisanBerjalanDetailModel>
      fetchPesertaArisanBerjalanList() async {
    String id = await storage.read(key: 'id_ArisanBerjalanDetail');
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
      Response response = await _dio.get('/arisan/berjalan/peserta/' + id);
      print(response.data);
      return PesertaArisanBerjalanDetailModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PesertaArisanBerjalanDetailModel.withError(
          "Data not found / Connection issue");
    }
  }
}
