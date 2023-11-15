import 'package:aplikasi_arisan/page/admin/tab_page_admin.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json;

const SERVER_IP = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class LoginAdmin extends StatefulWidget {
  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool hidePass = true;

  Future<Map<String, dynamic>> attemptLogIn(
      String username, String password, String dvcName) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');
    var res = await http.post(
      "$SERVER_IP/admin/login",
      body: {
        "username": username,
        "password": password,
        "device_name": androidInfo.model,
      },
    );
    if (res.statusCode == 200) return json.decode(res.body);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logoFix.png',
            width: size.width * 0.25,
          ),
          Text(
            "Selamat Datang Kembali",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.35,
            height: size.height * 0.06,
            constraints: BoxConstraints(maxHeight: 50, minHeight: 33),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(100, 0, 87, 0.5),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              style: Theme.of(context).textTheme.headline4,
              controller: _username,
              decoration: InputDecoration(
                  hintText: 'Username',
                  hintStyle: Theme.of(context).textTheme.headline6,
                  prefixIcon: Icon(
                    Icons.person,
                    size: 16,
                    color: Color.fromRGBO(154, 0, 87, 1),
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: size.width * 0.35,
            height: size.height * 0.06,
            alignment: Alignment.center,
            constraints: BoxConstraints(maxHeight: 50, minHeight: 33),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(100, 0, 87, 0.5),
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: TextField(
              style: Theme.of(context).textTheme.headline4,
              controller: _password,
              obscureText: hidePass,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: Theme.of(context).textTheme.headline6,
                prefixIcon: Icon(
                  Icons.lock,
                  size: 16,
                  color: Color.fromRGBO(154, 0, 87, 1),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePass = !hidePass;
                    });
                  },
                  padding: EdgeInsets.only(bottom: 1),
                  color: Color.fromRGBO(154, 0, 87, 1).withOpacity(0.4),
                  icon: Icon(
                    hidePass ? Icons.visibility_off : Icons.visibility,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
            height: 30,
            minWidth: 150,
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 80,
            ),
            onPressed: () async {
              var username = _username.text;
              var password = _password.text;
              var dvcName = 'android';
              Map<String, dynamic> jwt =
                  await attemptLogIn(username, password, dvcName);
              if (jwt != null) {
                storage.write(key: "jwt", value: jwt['access_token']);
                storage.write(key: "jwtAdmin", value: jwt['access_token']);
                String value = await storage.read(key: 'jwtAdmin');
                String value2 = await storage.read(key: 'jwt');
                print(value);
                print(value2);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TabPageAdmin(),
                  ),
                );
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(
                      'Username atau Password salah',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                );
              }
            },
            child: Text(
              "Log In",
              style: Theme.of(context).textTheme.headline5,
            ),
            color: Color.fromRGBO(154, 0, 87, 1),
            shape: StadiumBorder(),
          ),
        ],
      ),
    );
  }
}
