import 'package:aplikasi_arisan/page/model/arisan_menang.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class ArisanMenangApiProvider {
  Future<ArisanMenangModel> fetchArisanMenangList() async {
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
      Response response = await _dio.get('/arisan/menang');
      print(response.data);
      return ArisanMenangModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArisanMenangModel.withError("Data not found / Connection issue");
    }
  }
}
