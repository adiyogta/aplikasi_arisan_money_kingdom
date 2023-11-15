import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class EditPass extends StatefulWidget {
  @override
  _EditPassState createState() => _EditPassState();
}

class _EditPassState extends State<EditPass> {
  final TextEditingController _password = TextEditingController();

  bool hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
      width: double.infinity * 0.5,
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
        // ignore: non_constant_identifier_names
        onChanged: (Null) {
          var pass = _password.text;
          storage.write(key: "password_baru", value: pass);
        },
        obscureText: hidePass,
        maxLength: 20,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(154, 0, 87, 1),
          ),
          prefixIcon: Icon(
            Icons.lock,
            size: 15,
            color: Color.fromRGBO(154, 0, 87, 1),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePass = !hidePass;
              });
            },
            color: Color.fromRGBO(154, 0, 87, 1).withOpacity(0.4),
            icon: Icon(hidePass ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }
}
