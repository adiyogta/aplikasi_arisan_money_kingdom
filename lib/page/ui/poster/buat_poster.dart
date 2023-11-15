import 'dart:io';
import 'package:aplikasi_arisan/page/blocs/poster/poster_bloc.dart';
import 'package:aplikasi_arisan/resources/poster_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

final storage = FlutterSecureStorage();

class UploadPoster extends StatefulWidget {
  @override
  _UploadPosterState createState() => _UploadPosterState();
}

class _UploadPosterState extends State<UploadPoster> {
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

  File _fotoPoster;

  Future _getfotoGall() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 35);
    setState(() {
      _fotoPoster = image;
    });
  }

  @override
  void initState() {
    _newsBloc.add(GetPosterList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Buat Poster Baru',
                style: Theme.of(context).textTheme.headline3,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width * 0.15,
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: _fotoPoster == null
                      ? Center(
                          child: Text(
                            'Foto Belum Dipilih.',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        )
                      : Image.file(
                          _fotoPoster,
                          fit: BoxFit.fitWidth,
                          scale: 1,
                        ),
                ),
              ),
              FlatButton.icon(
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
                      fontSize: 13,
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
                      fontSize: 13,
                      color: Color.fromRGBO(154, 0, 87, 1),
                    ),
                  ),
                ),
              ),
              FlatButton(
                color: Colors.blue[900],
                shape: StadiumBorder(),
                onPressed: () async {
                  var nama = _namaPosterController.text;
                  var foto = _fotoPoster;
                  var deskripsi = _deskripsiPosterController.text;
                  Map<String, dynamic> jwt = await posterApiProvider
                      .attemptBuatPoster(nama, deskripsi, foto);
                  if (jwt['status_code'] == 201) {
                    clearTextInput();
                    refreshList();
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.lightGreen[900],
                        title: Center(
                          child: Text(
                            'Poster Baru Berhasil Dibuat',
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
                              'Poster Baru Gagal Dibuat',
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
                  "Buat Poster Baru",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
