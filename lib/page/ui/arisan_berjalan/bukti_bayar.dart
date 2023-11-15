import 'dart:io';
import 'package:aplikasi_arisan/resources/arisan_berjalan_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

final storage = FlutterSecureStorage();

class BuktiBayar extends StatefulWidget {
  final List<String> selectedID;
  BuktiBayar(this.selectedID);

  @override
  _BuktiBayarState createState() => _BuktiBayarState();
}

class _BuktiBayarState extends State<BuktiBayar> {
  File _fotoBuktiMenang;

  Future _getfotoCam() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 20);
    setState(() {
      _fotoBuktiMenang = image;
    });
  }

  Future _getfotoGall() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 20);
    setState(() {
      _fotoBuktiMenang = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.only(left: 35),
          width: MediaQuery.of(context).size.width * 0.2,
          alignment: Alignment.center,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: _fotoBuktiMenang == null
                ? Center(
                    child: Text(
                      'Foto Belum Dipilih.',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                : Image.file(
                    _fotoBuktiMenang,
                    fit: BoxFit.fitWidth,
                    scale: 1,
                  ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: this._getfotoCam,
              label: Text("Buka Kamera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.camera),
              onPressed: this._getfotoGall,
              label: Text("Buka Galeri"),
            ),
            SizedBox(width: 10.0),
            (widget.selectedID != null && _fotoBuktiMenang != null)
                ? FlatButton(
                    color: Colors.lightBlue[900],
                    shape: StadiumBorder(),
                    onPressed: () async {
                      final adApiProvider = ArisanBerjalanApiProvider();

                      var id = widget.selectedID;

                      File bukti = _fotoBuktiMenang;
                      Map<String, dynamic> jwt =
                          await adApiProvider.uploadBuktiBayar(id, bukti);
                      print(jwt);
                      if (jwt['status_code'] == 200) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.lightGreen[800],
                            title: Center(
                              child: Text(
                                'Berhasil Upload Bukti Bayar',
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
                                  'Gagal Upload Data',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              content: Text(
                                jwt.toString() +
                                    'Anda Mungkin Belum Memilih Periode',
                                style: Theme.of(context).textTheme.headline5,
                              )),
                        );
                      }
                    },
                    child: Text(
                      'Kirim Bukti Bayar',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : FlatButton(
                    color: Colors.grey[900],
                    shape: StadiumBorder(),
                    onPressed: null,
                    child: Text(
                      'Kirim Bukti Bayar',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
