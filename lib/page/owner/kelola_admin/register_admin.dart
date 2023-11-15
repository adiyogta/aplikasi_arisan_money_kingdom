import 'package:aplikasi_arisan/resources/admin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class CreateAdmin extends StatefulWidget {
  CreateAdmin({
    Key key,
  }) : super(key: key);

  @override
  _CreateAdminState createState() => _CreateAdminState();
}

class _CreateAdminState extends State<CreateAdmin> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final admintApiProvider = AdminApiProvider();
  // final paketApiProvider = ();
  clearTextInput() {
    _username.clear();
    _password.clear();
    _nama.clear();
  }

  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: FlatButton(
        minWidth: 125,
        height: 30,
        shape: StadiumBorder(),
        color: Colors.blue[900],
        onPressed: () async {
          var nama = _nama.text;

          var username = _username.text;
          var password = _password.text;

          Map<String, dynamic> jwt = await admintApiProvider.attemptTambahAdmin(
              nama, username, password);
          if (jwt['status_code'] == 201) {
            clearTextInput();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.green[700],
                title: Center(
                  child: Text(
                    'Akun Berhasil Dibuat',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ).then((value) => Navigator.pop(context));
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.red[800],
                title: Center(
                  child: Text(
                    'Akun Gagal Dibuat',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ).then((value) => Navigator.pop(context));
          }
        },
        child: Text(
          "Buat Akun Admin",
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Wrap(
            direction: Axis.vertical,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.40,
                constraints: BoxConstraints(maxHeight: 680, maxWidth: 615),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(241, 165, 211, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        maxLength: 25,
                        style: Theme.of(context).textTheme.headline6,
                        controller: _nama,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(154, 0, 87, 1),
                            ),
                          ),
                          labelText: 'Nama',
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(154, 0, 87, 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        maxLength: 25,
                        style: Theme.of(context).textTheme.headline6,
                        controller: _username,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(154, 0, 87, 1),
                            ),
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(154, 0, 87, 1),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        maxLength: 25,
                        obscureText: hidePass,
                        style: Theme.of(context).textTheme.headline6,
                        controller: _password,
                        obscuringCharacter: "*",
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(154, 0, 87, 1),
                            ),
                          ),
                          suffixIcon: IconButton(
                            iconSize: 18,
                            onPressed: () {
                              setState(() {
                                hidePass = !hidePass;
                              });
                            },
                            color:
                                Color.fromRGBO(154, 0, 87, 1).withOpacity(0.4),
                            icon: Icon(hidePass
                                ? Icons.visibility_off
                                : Icons.visibility),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(154, 0, 87, 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
