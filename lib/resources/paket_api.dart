import 'dart:async';
import 'package:aplikasi_arisan/page/model/paket_model.dart';
import 'package:aplikasi_arisan/page/ui/detail_paket.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

final String _url = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class PaketApiProvider {
  Client client = Client();

  Future<ListPaketModel> fetchPaketList() async {
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
      Response response = await _dio.get('/paket');
      return ListPaketModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ListPaketModel.withError("Data not found / Connection issue");
    }
  }

  Future<Map<String, dynamic>> attemptBuatPaket(String nama, int nominal,
      int jangka, int slot, int bAdmin, int bCancel) async {
    String value = await storage.read(key: 'jwt');

    var res = await client.post(Uri.encodeFull("$_url/paket"),
        body: json.encode({
          "nama": nama,
          "nominal": nominal,
          "jumlah_periode_bayar": jangka,
          "slot": slot,
          "biaya_admin": bAdmin,
          "biaya_cancel": bCancel
        }),
        headers: {
          "Authorization": "Bearer $value",
          'Content-Type': 'application/json; charset=UTF-8',
        });
    Map<String, dynamic> result = json.decode(res.body);
    result['status_code'] = res.statusCode;
    print(res.body);
    return result;
  }

  List<PersonEntry> entries = [];

  // ignore: non_constant_identifier_names
  Future<Map<String, dynamic>> updatePasok(List<PersonEntry> entries) async {
    String value = await storage.read(key: 'jwt');

    Map<String, List<Map<String, dynamic>>> myData =
        new Map<String, List<Map<String, dynamic>>>();
    myData['slot'] = [];
    for (int i = 0; i < entries.length; i++) {
      myData['slot']
          .add({"slot_id": entries[i].slotid, "pasok": entries[i].pasok});
    }

    var response = await client.put(
      Uri.encodeFull("$_url/paket/slot"),
      headers: {
        "Authorization": "Bearer $value",
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(myData),
    );
    print(response.body);
    // parsing JSOn or throwing an exception
    Map<String, dynamic> result = json.decode(response.body);
    result['status_code'] = response.statusCode;

    return result;
  }
}
