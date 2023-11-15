import 'package:aplikasi_arisan/page/model/peserta_detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/resources/arisan_berjalan_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class ValidasiBukti extends StatefulWidget {
  final Transaksi model;
  ValidasiBukti(this.model);

  @override
  _ValidasiBuktiState createState() => _ValidasiBuktiState();
}

class _ValidasiBuktiState extends State<ValidasiBukti> {
  // ignore: non_constant_identifier_names
  String jangkaHari_;
  List jangkaHari = [
    'ditolak',
    'disetujui',
  ];

  @override
  Widget build(BuildContext context) {
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
                    storage.write(key: "status_validasi", value: a);
                  });
                },
              ),
            ],
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
            final adApiProvider = ArisanBerjalanApiProvider();

            String value = await storage.read(key: 'status_validasi');
            String status = value;
            print(status);
            var id = widget.model.id.toString();
            Map<String, dynamic> jwt =
                await adApiProvider.updateValidasi(id, status);
            if (jwt['status_code'] == 200) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.lightGreen[800],
                  title: Center(
                    child: Text(
                      'Berhasil Ubah Data',
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
                        'Gagal Ubah Data',
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
