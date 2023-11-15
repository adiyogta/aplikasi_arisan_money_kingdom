import 'package:aplikasi_arisan/page/model/bank_model.dart';
import 'package:aplikasi_arisan/resources/bank_api.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' show Client;

final storage = FlutterSecureStorage();

class ActionBank extends StatefulWidget {
  final Bank model;
  ActionBank(this.model);

  @override
  _ActionBankState createState() => _ActionBankState();
}

class _ActionBankState extends State<ActionBank> {
  final TextEditingController _namaBankController = TextEditingController();

  final bankApiProvider = BankApiProvider();

  Client client = Client();

  clearTextInput() {
    _namaBankController.clear();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              'Ubah Nama Bank',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(154, 0, 87, 1),
              ),
              controller: _namaBankController,
              maxLength: 20,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromRGBO(154, 0, 87, 1),
                  ),
                ),
                labelText: 'Nama Bank',
                labelStyle: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          FlatButton(
            shape: StadiumBorder(),
            color: Colors.blue[900],
            onPressed: () async {
              var nama = _namaBankController.text;
              var id = widget.model.id.toString();
              Map<String, dynamic> jwt =
                  await bankApiProvider.attemptUbahBank(nama, id);
              if (jwt['status_code'] == 201) {
                clearTextInput();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Nama Bank Berhasil Diubah',
                      style: TextStyle(color: Colors.green[800]),
                    ),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Data Bank Gagal Diubah',
                      style: TextStyle(color: Colors.red[800]),
                    ),
                    content: Text(jwt.toString()),
                  ),
                );
                setState(() {});
              }
            },
            child: Text(
              "Ubah Nama Bank",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
