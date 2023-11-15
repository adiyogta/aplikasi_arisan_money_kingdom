import 'dart:io';

import 'package:aplikasi_arisan/page/blocs/poster/poster_bloc.dart';
import 'package:aplikasi_arisan/page/model/poster_model.dart';
import 'package:aplikasi_arisan/resources/poster_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

final storage = FlutterSecureStorage();

class UbahPoster extends StatefulWidget {
  final Poster poster;
  UbahPoster(this.poster);

  @override
  _UbahPosterState createState() => _UbahPosterState();
}

class _UbahPosterState extends State<UbahPoster> {
  final PosterBloc _newsBloc = PosterBloc();
  final posterApiProvider = PosterApiProvider();

  final TextEditingController _namaPosterController = TextEditingController();
  final TextEditingController _deskripsiPosterController =
      TextEditingController();

  clearTextInput() {
    _namaPosterController.clear();
    _deskripsiPosterController.clear();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetPosterList());
    });

    return null;
  }

  File _fotoBuktiMenang;

  Future _getfotoGall() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 35);
    setState(() {
      _fotoBuktiMenang = image;
    });
  }

  @override
  void initState() {
    _newsBloc.add(GetPosterList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Ubah Poster",
              style: Theme.of(context).textTheme.headline3,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              width: MediaQuery.of(context).size.width * 0.2,
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: _fotoBuktiMenang == null
                    ? Image(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            'https://api.moneykingdom.org/public/foto/' +
                                widget.poster.foto,
                            scale: 1.0),
                      )
                    : Image.file(
                        _fotoBuktiMenang,
                        fit: BoxFit.fitWidth,
                        scale: 1,
                      ),
              ),
            ),
            _fotoBuktiMenang == null
                ? Text(
                    'Foto Masih Yang Sebelumnya.',
                    style: Theme.of(context).textTheme.headline6,
                  )
                : Text(
                    'Foto Sudah Yang Baru.',
                    style: Theme.of(context).textTheme.headline6,
                  ),
            FlatButton.icon(
              height: 28,
              icon: Icon(
                Icons.camera,
                size: 16,
              ),
              onPressed: this._getfotoGall,
              label: Text(
                "Buka Galeri",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                style: Theme.of(context).textTheme.headline6,
                controller: _namaPosterController,
                maxLength: 20,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(154, 0, 87, 1),
                    ),
                  ),
                  labelText: 'Nama Foto',
                  labelStyle: TextStyle(
                    fontSize: 11,
                    color: Color.fromRGBO(154, 0, 87, 1),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                style: Theme.of(context).textTheme.headline6,
                controller: _deskripsiPosterController,
                maxLength: 150,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(154, 0, 87, 1),
                    ),
                  ),
                  labelText: 'Deskripsi Foto',
                  labelStyle: TextStyle(
                    fontSize: 11,
                    color: Color.fromRGBO(154, 0, 87, 1),
                  ),
                ),
              ),
            ),
            FlatButton(
              height: 25,
              color: Colors.blue[900],
              shape: StadiumBorder(),
              onPressed: () async {
                var nama = _namaPosterController.text;
                var foto = _fotoBuktiMenang;
                var deskripsi = _deskripsiPosterController.text;
                var id = widget.poster.id.toString();
                Map<String, dynamic> jwt = await posterApiProvider
                    .attemptUbahPoster(nama, foto, deskripsi, id);
                if (jwt['status_code'] == 200) {
                  clearTextInput();
                  refreshList();
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.lightGreen[900],
                      title: Center(
                        child: Text(
                          'Poster Berhasil Diubah',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                  );
                } else {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.red[900],
                        title: Center(
                          child: Text(
                            'Poster Baru Gagal Diubah',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                        content: Text(
                          jwt.toString(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    );
                  });
                }
              },
              child: Text(
                "Ubah Poster",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
