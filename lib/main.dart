import 'dart:io';

import 'package:aplikasi_arisan/login.dart';
import 'package:aplikasi_arisan/page/admin/tab_page_admin.dart';
import 'package:aplikasi_arisan/page/owner/tab_page_owner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

final storage = FlutterSecureStorage();

void main() {
  runApp(MyApp());
}
 
// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  var jwtA;
  var jwtO;

  Future<String> get chck async {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return "konek";
    print(result);
    return result.toString();
  }

  Future<String> get jwtOrEmpty async {
    // var jwt;
    var jwt = await storage.read(key: "jwt");
    var jwtAdmin = await storage.read(key: "jwtAdmin");
    var jwtOwner = await storage.read(key: "jwtOwner");
    jwtA = jwtAdmin;
    jwtO = jwtOwner;
    // var jwt2 = await storage.read(key: "jwt");

    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.pink[800]));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'montserrat',
        hintColor: Colors.grey,
        inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(154, 0, 87, 1),
              ),
            ),
            labelStyle: Theme.of(context).textTheme.headline6),
        errorColor: Colors.red,
        primaryColor: Color.fromRGBO(142, 0, 151, 1),
        backgroundColor: Color.fromRGBO(255, 229, 244, 1),
        accentColor: Color.fromRGBO(154, 0, 87, 1),
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(),
            buttonColor: Color.fromRGBO(154, 0, 87, 1),
            minWidth: 250),
        textTheme: TextTheme(
          headline1: GoogleFonts.montserrat(
            fontSize: 42.0,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(154, 0, 87, 1),
          ),
          headline2: GoogleFonts.montserrat(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(154, 0, 87, 1),
          ),
          headline3: GoogleFonts.montserrat(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(234, 0, 88, 1),
          ),
          headline4: GoogleFonts.montserrat(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(154, 0, 87, 1),
          ),
          headline5: GoogleFonts.montserrat(
            fontSize: 11.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          headline6: GoogleFonts.montserrat(
            fontSize: 11.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          subtitle1: GoogleFonts.montserrat(
            fontSize: 29.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          subtitle2: GoogleFonts.montserrat(
            fontSize: 11.0,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
            future: chck,
            builder: (context, snapshot) {
              if (snapshot.data == "konek") {
                if (!snapshot.hasData)
                  return Container(
                      height: MediaQuery.of(context).size.height * 1,
                      width: MediaQuery.of(context).size.width * 1,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator());
                return FutureBuilder(
                    future: jwtOrEmpty,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return CircularProgressIndicator();
                      if (snapshot.data != "" && jwtO != null) {
                        return TabPageOwner();
                      } else if (snapshot.data != "" && jwtA != null) {
                        return TabPageAdmin();
                      } else {
                        return TabLogin();
                      }
                    });
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height * 1,
                  width: MediaQuery.of(context).size.width * 1,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mohon Check Koneksi Internet Anda',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      FlatButton(
                        minWidth: 100,
                        height: 30,
                        color: Colors.pink,
                        shape: StadiumBorder(),
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TabLogin()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text(
                          'Refresh',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      )
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
