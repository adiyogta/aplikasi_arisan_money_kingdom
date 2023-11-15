import 'package:aplikasi_arisan/page/model/detail_lelang_model.dart';
import 'package:aplikasi_arisan/resources/lelang_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class PengajuanLelang extends StatefulWidget {
  final Lelang model;
  PengajuanLelang(this.model);

  @override
  _PengajuanLelangState createState() => _PengajuanLelangState();
}

class _PengajuanLelangState extends State<PengajuanLelang> {
  String jangkaHari_;
  List jangkaHari = [
    'ditolak',
    'disetujui',
  ];

  @override
  Widget build(BuildContext context) {
    final TextEditingController _statusController = TextEditingController();
    clearTextInput() {
      _statusController.clear();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButton(
                focusColor: Color.fromRGBO(154, 0, 87, 1),
                hint: Text("Ganti Status",
                    style: Theme.of(context).textTheme.headline6),
                value: jangkaHari_,
                isExpanded: true,
                items: jangkaHari.map((item) {
                  return DropdownMenuItem(
                    child: Text(item.toString(),
                        style: Theme.of(context).textTheme.headline6),
                    value: item,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    jangkaHari_ = value;
                    String a = jangkaHari_;
                    storage.write(key: "status_lelang", value: a);
                  });
                },
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            maxLength: 250,
            style: Theme.of(context).textTheme.headline6,
            controller: _statusController,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(154, 0, 87, 1),
                ),
              ),
              labelText: 'Catatan Tambahan',
              labelStyle: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        FlatButton(
          padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          shape: StadiumBorder(),
          color: Colors.pink[800],
          child: Text(
            "Ubah",
            style: Theme.of(context).textTheme.headline5,
          ),
          onPressed: () async {
            final adApiProvider = LelangApiProvider();

            String value = await storage.read(key: 'status_lelang');
            String status = value;
            var a = _statusController.text;
            String pesan = a;
            print(pesan);
            var id = widget.model.id.toString();
            Map<String, dynamic> jwt =
                await adApiProvider.verivikasiLelang(id, status, pesan);
            if (jwt['status_code'] == 200) {
              Navigator.pop(context);
              clearTextInput();
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.lightGreen[800],
                  title: Center(
                    child: Text(
                      'Berhasil Memberikan Respon Pengajuan Lelang',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              );
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    backgroundColor: Colors.red[800],
                    title: Center(
                      child: Text(
                        'Gagal Memberikan Respon Pengajuan',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    content: Text(
                      jwt.toString(),
                      style: Theme.of(context).textTheme.headline5,
                    )),
              );
            }
          },
        ),
      ],
    );
  }
}
