import 'package:aplikasi_arisan/resources/paket_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class BuatPaket extends StatefulWidget {
  const BuatPaket({
    Key key,
  }) : super(key: key);

  @override
  _BuatPaketState createState() => _BuatPaketState();
}

class _BuatPaketState extends State<BuatPaket> {
  final TextEditingController _namaPaketController = TextEditingController();
  final TextEditingController _nominalController = TextEditingController();
  final TextEditingController _jangkaController = TextEditingController();
  final TextEditingController _slotController = TextEditingController();
  final TextEditingController _bAdminController = TextEditingController();
  final TextEditingController _bCancelController = TextEditingController();
  final paketApiProvider = PaketApiProvider();
  int jangkaHari_;
  clearTextInput() {
    _namaPaketController.clear();
    _nominalController.clear();
    _jangkaController.clear();
    _slotController.clear();
    _bAdminController.clear();
    _bCancelController.clear();
  }

  List jangkaHari = [
    4,
    5,
    6,
    7,
    9,
    13,
    15,
    19,
    20,
    30,
  ];

  bool _namaPaketControllerValidate = false;
  bool _nominalControllerValidate = false;
  bool _slotControllerValidate = false;
  bool _bAdminControllerValidate = false;
  bool _bCancelControllerValidate = false;

  bool validateNamaPaket(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        _namaPaketControllerValidate = true;
      });
      return false;
    }
    setState(() {
      _namaPaketControllerValidate = false;
    });
    return true;
  }

  bool validateNominalPaket(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        _nominalControllerValidate = true;
      });
      return false;
    }
    setState(() {
      _nominalControllerValidate = false;
    });
    return true;
  }

  bool validateSlotPaket(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        _slotControllerValidate = true;
      });
      return false;
    }
    setState(() {
      _slotControllerValidate = false;
    });
    return true;
  }

  bool validateBAdminPaket(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        _bAdminControllerValidate = true;
      });
      return false;
    }
    setState(() {
      _bAdminControllerValidate = false;
    });
    return true;
  }

  bool validateBCancelPaket(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        _bCancelControllerValidate = true;
      });
      return false;
    }
    setState(() {
      _bCancelControllerValidate = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 0.885,
        color: Color.fromRGBO(255, 243, 250, 1),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Buat Paket Arisan",
                style: Theme.of(context).textTheme.headline3,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.60,
                constraints: BoxConstraints(maxWidth: 615),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(241, 165, 211, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 10, left: 10, top: 18, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              maxLength: 25,
                              style: Theme.of(context).textTheme.headline6,
                              controller: _namaPaketController,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(154, 0, 87, 1),
                                  ),
                                ),
                                labelText: 'Nama Paket',
                                errorText: _namaPaketControllerValidate
                                    ? 'Tolong Isi Nama Paket'
                                    : null,
                                labelStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(154, 0, 87, 1),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              maxLength: 9,
                              style: Theme.of(context).textTheme.headline6,
                              controller: _nominalController,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(154, 0, 87, 1),
                                  ),
                                ),
                                labelText: 'Nominal Paket',
                                errorText: _nominalControllerValidate
                                    ? 'Tolong Isi Nominal Paket'
                                    : null,
                                labelStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(154, 0, 87, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                DropdownButton(
                                  hint: Text("Pilih Jangka Hari",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  value: jangkaHari_,
                                  isExpanded: true,
                                  items: jangkaHari.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                      value: item,
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      jangkaHari_ = value;
                                    });
                                    // ignore: unused_element
                                    void setStateIfMounted(f) {
                                      if (mounted) setState(f);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              style: Theme.of(context).textTheme.headline6,
                              controller: _slotController,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(154, 0, 87, 1),
                                  ),
                                ),
                                labelText: 'Jumlah Slot',
                                errorText: _slotControllerValidate
                                    ? 'Tolong Isi Jumlah Slot Paket'
                                    : null,
                                labelStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(154, 0, 87, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              maxLength: 9,
                              style: Theme.of(context).textTheme.headline6,
                              controller: _bAdminController,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(154, 0, 87, 1),
                                  ),
                                ),
                                labelText: 'Biaya Admin',
                                errorText: _bAdminControllerValidate
                                    ? 'Tolong Isi Biaya Admin'
                                    : null,
                                labelStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(154, 0, 87, 1),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.27,
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                // ignore: deprecated_member_use
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              maxLength: 9,
                              style: Theme.of(context).textTheme.headline6,
                              controller: _bCancelController,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromRGBO(154, 0, 87, 1),
                                  ),
                                ),
                                labelText: 'Biaya Cancel',
                                errorText: _bCancelControllerValidate
                                    ? 'Tolong Isi Biaya Cancel'
                                    : null,
                                labelStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(154, 0, 87, 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FlatButton(
                        height: 25,
                        color: Color.fromRGBO(234, 0, 88, 1),
                        shape: StadiumBorder(),
                        onPressed: () async {
                          validateNamaPaket(_namaPaketController.text);
                          validateNominalPaket(_namaPaketController.text);
                          validateSlotPaket(_slotController.text);
                          validateBAdminPaket(_bAdminController.text);
                          validateBCancelPaket(_bCancelController.text);

                          var nama = _namaPaketController.text;
                          int nominal = int.parse(_nominalController.text);
                          // int jangka = int.parse(_jangkaController.text);
                          int jangka = jangkaHari_;
                          int slot = int.parse(_slotController.text);
                          int bAdmin = int.parse(_bAdminController.text);
                          int bCancel = int.parse(_bCancelController.text);
                          Map<String, dynamic> jwt =
                              await paketApiProvider.attemptBuatPaket(
                                  nama, nominal, jangka, slot, bAdmin, bCancel);
                          if (jwt['status_code'] == 201) {
                            clearTextInput();
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.green[900],
                                title: Center(
                                  child: Text(
                                    'PaKet Berhasil Dibuat',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                content: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Silahkan Edit Slot Pada List Paket',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                            );
                          } else if (jangka == null) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.red[900],
                                title: Center(
                                  child: Text(
                                    'PaKet Gagal Dibuat',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                content: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    'Jangka Hari Harus Diisi',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.red[900],
                                title: Center(
                                  child: Text(
                                    'PaKet Gagal Dibuat',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                content: Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    jwt['errors']['nama'].toString(),
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          "Buat Paket",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
