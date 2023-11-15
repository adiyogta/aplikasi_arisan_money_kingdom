import 'package:aplikasi_arisan/page/model/lelang_disetujui.dart';
import 'package:aplikasi_arisan/resources/lelang_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class SetUsername extends StatefulWidget {
  final Lelang model;
  SetUsername(this.model);

  @override
  _SetUsernameState createState() => _SetUsernameState();
}

class _SetUsernameState extends State<SetUsername> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _statusController = TextEditingController();
    clearTextInput() {
      _statusController.clear();
    }

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Masukan Username Pembeli Slot',
            style: Theme.of(context).textTheme.headline5,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              maxLength: 30,
              style: Theme.of(context).textTheme.headline6,
              controller: _statusController,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(154, 0, 87, 1),
                  ),
                ),
                labelText: 'Username Pembeli Slot',
                labelStyle: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          FlatButton(
            height: 25,
            minWidth: 60,
            shape: StadiumBorder(),
            color: Colors.pink[800],
            child: Text(
              "Ubah",
              style: Theme.of(context).textTheme.headline5,
            ),
            onPressed: () async {
              final adApiProvider = LelangApiProvider();

              var a = _statusController.text;
              String username = a;

              var id = widget.model.id.toString();
              Map<String, dynamic> jwt =
                  await adApiProvider.setUsernameLelangTerjual(id, username);
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
      ),
    );
  }
}
