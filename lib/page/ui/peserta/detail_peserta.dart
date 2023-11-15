import 'package:aplikasi_arisan/page/blocs/peserta_detail/peserta_detail_bloc.dart';
import 'package:aplikasi_arisan/page/model/peserta_detail_model.dart';
import 'package:aplikasi_arisan/page/ui/peserta/editRank.dart';
import 'package:aplikasi_arisan/resources/peserta_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

final storage = FlutterSecureStorage();

class PesertaDetail extends StatefulWidget {
  PesertaDetail();

  @override
  _PesertaDetailState createState() => _PesertaDetailState();
}

class _PesertaDetailState extends State<PesertaDetail> {
  final PesertaDetailBloc _newsBloc = PesertaDetailBloc();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetPesertaDetailList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetPesertaDetailList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<PesertaDetailBloc, PesertaDetailState>(
          listener: (context, state) {
            if (state is PesertaDetailError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<PesertaDetailBloc, PesertaDetailState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is PesertaDetailInitial) {
                return _buildLoading();
              } else if (state is PesertaDetailLoading) {
                return _buildLoading();
              } else if (state is PesertaDetailLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is PesertaDetailError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, DetailPesertaModel model) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 165,
                  child: AspectRatio(
                    aspectRatio: 3 / 4.5,
                    child: new Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: new DecorationImage(
                          fit: BoxFit.fitHeight,
                          alignment: FractionalOffset.center,
                          image: new NetworkImage(
                              'https://api.moneykingdom.org/public/foto-profil/' +
                                  model.peserta.fotoProfil,
                              scale: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Tempat Tanggal Lahir : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "NIK :",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Alamat KTP : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Alamat Domisili : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Email : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "No Whatsapp : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "No HP : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Pekerjaan : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "Alamat Tempat Bekerja : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      "Sosial Media : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Rank : ",
                      style: GoogleFonts.montserrat(
                        fontSize: 11.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.peserta.namaLengkap,
                      style: GoogleFonts.montserrat(
                        fontSize: 20.0,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                        model.peserta.tempatLahir +
                            ', ' +
                            model.peserta.tanggalLahir,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.nomorKtp,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.alamatKtp,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.alamatDomisili,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.email,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.noWhatsapp,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.noHp,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.pekerjaan,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 3),
                    Text(model.peserta.alamatPekerjaan,
                        style: Theme.of(context).textTheme.headline6),
                    SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        for (int i = 0;
                            i < model.peserta.sosialmedia.length;
                            i++)
                          Container(
                            height: 25,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: (model.peserta.sosialmedia[i].nama ==
                                        'Instagram')
                                    ? LinearGradient(colors: [
                                        Colors.redAccent,
                                        Colors.pinkAccent
                                      ])
                                    : LinearGradient(colors: [
                                        Colors.blue[900],
                                        Colors.blue[500]
                                      ]),
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.redAccent),
                            child: FlatButton(
                              height: 25,
                              minWidth: 70,
                              onPressed: () {
                                final _transformationController =
                                    TransformationController();
                                TapDownDetails _doubleTapDetails;
                                LongPressEndDetails _tripleTapDetails;
                                void _handleDoubleTapDown(
                                    TapDownDetails details) {
                                  _doubleTapDetails = details;
                                }

                                void _handleTripleTapDown(
                                    LongPressEndDetails details) {
                                  _tripleTapDetails = details;
                                }

                                void _handleDoubleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _doubleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 2, -position.dy * 2)
                                      ..scale(3.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                void _handleTripleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _tripleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 3, -position.dy * 3)
                                      ..scale(5.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 0.95),
                                    title: Center(
                                      child: Text(
                                          '@' +
                                              model.peserta.sosialmedia[i].pivot
                                                  .nama,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: GestureDetector(
                                        onDoubleTapDown: _handleDoubleTapDown,
                                        onDoubleTap: _handleDoubleTap,
                                        onLongPress: _handleTripleTap,
                                        onLongPressEnd: _handleTripleTapDown,
                                        child: InteractiveViewer(
                                          transformationController:
                                              _transformationController,
                                          child: Image(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                'https://api.moneykingdom.org/public/sosial-media/' +
                                                    model.peserta.sosialmedia[i]
                                                        .pivot.screenshot,
                                                scale: 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                model.peserta.sosialmedia[i].nama,
                                style: GoogleFonts.montserrat(
                                  fontSize: 11.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        (model.peserta.rank != 'gold')
                            ? Container(
                                decoration: BoxDecoration(
                                  gradient: (model.peserta.rank == 'silver')
                                      ? LinearGradient(colors: [
                                          Colors.black45,
                                          Colors.black54
                                        ])
                                      : LinearGradient(colors: [
                                          Colors.black87,
                                          Colors.black54
                                        ]),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 20),
                                child: Text(model.peserta.rank,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Colors.orange[800],
                                    Colors.yellow[700]
                                  ]),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 3, horizontal: 25),
                                child: Text(model.peserta.rank,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              ),
                        IconButton(
                          icon: Icon(
                            Icons.create_sharp,
                            size: 16,
                          ),
                          color: Colors.lightBlue[800],
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.pink[800],
                                title: Center(
                                  child: Text(
                                    'Reset Passowrd',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    EditRank(),
                                    FlatButton(
                                      shape: StadiumBorder(),
                                      color: Colors.lightBlue[800],
                                      onPressed: () async {
                                        final adApiProvider =
                                            PesertaApiProvider();
                                        String value = await storage.read(
                                            key: 'rank_baru');

                                        var id = model.peserta.id.toString();
                                        var password = value;
                                        Map<String, dynamic> jwt =
                                            await adApiProvider.ubahRank(
                                          id,
                                          password,
                                        );
                                        if (jwt['status_code'] == 200) {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  Colors.lightGreen[800],
                                              title: Center(
                                                child: Text(
                                                  'Rank Sudah Diubah',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                            ),
                                          ).then((value) => refreshList());
                                        } else {
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.red[800],
                                              title: Center(
                                                child: Text(
                                                  'Gagal Ubah Rank',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                              content: Text(
                                                jwt.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Text("Ganti Rank",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            DefaultTabController(
              length: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3,
                          color: Colors.pink[100],
                        ),
                      ),
                    ),
                    child: TabBar(
                        indicatorColor: Colors.pink[700],
                        unselectedLabelColor: Colors.black54,
                        indicatorWeight: 4,
                        labelStyle: Theme.of(context).textTheme.headline6,
                        indicatorSize: TabBarIndicatorSize.label,
                        labelColor: Colors.black,
                        tabs: [
                          Tab(text: "Foto Identitas"),
                          Tab(text: "Data Bank"),
                          Tab(text: "Data Penjamin"),
                        ]),
                  ),
                  Container(
                    //Add this to give height
                    height: MediaQuery.of(context).size.height * 0.485,
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    child: TabBarView(children: [
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                final _transformationController =
                                    TransformationController();
                                TapDownDetails _doubleTapDetails;
                                LongPressEndDetails _tripleTapDetails;
                                void _handleDoubleTapDown(
                                    TapDownDetails details) {
                                  _doubleTapDetails = details;
                                }

                                void _handleTripleTapDown(
                                    LongPressEndDetails details) {
                                  _tripleTapDetails = details;
                                }

                                void _handleDoubleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _doubleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 2, -position.dy * 2)
                                      ..scale(3.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                void _handleTripleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _tripleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 3, -position.dy * 3)
                                      ..scale(5.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 0.95),
                                    title: Center(
                                      child: Text(model.peserta.namaLengkap,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: GestureDetector(
                                        onDoubleTapDown: _handleDoubleTapDown,
                                        onDoubleTap: _handleDoubleTap,
                                        onLongPress: _handleTripleTap,
                                        onLongPressEnd: _handleTripleTapDown,
                                        child: InteractiveViewer(
                                          transformationController:
                                              _transformationController,
                                          child: Image(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                'https://api.moneykingdom.org/public/foto-ktp/' +
                                                    model.peserta.fotoKtp,
                                                scale: 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.1055,
                                child: Column(
                                  children: [
                                    Text(
                                      "Foto KTP",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: new Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            image: new NetworkImage(
                                                'https://api.moneykingdom.org/public/foto-ktp/' +
                                                    model.peserta.fotoKtp,
                                                scale: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                final _transformationController =
                                    TransformationController();
                                TapDownDetails _doubleTapDetails;
                                LongPressEndDetails _tripleTapDetails;
                                void _handleDoubleTapDown(
                                    TapDownDetails details) {
                                  _doubleTapDetails = details;
                                }

                                void _handleTripleTapDown(
                                    LongPressEndDetails details) {
                                  _tripleTapDetails = details;
                                }

                                void _handleDoubleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _doubleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 2, -position.dy * 2)
                                      ..scale(3.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                void _handleTripleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _tripleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 3, -position.dy * 3)
                                      ..scale(5.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 0.95),
                                    title: Center(
                                      child: Text(model.peserta.namaLengkap,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: GestureDetector(
                                        onDoubleTapDown: _handleDoubleTapDown,
                                        onDoubleTap: _handleDoubleTap,
                                        onLongPress: _handleTripleTap,
                                        onLongPressEnd: _handleTripleTapDown,
                                        child: InteractiveViewer(
                                          transformationController:
                                              _transformationController,
                                          child: Image(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                'https://api.moneykingdom.org/public/selfie-dengan-ktp/' +
                                                    model.peserta
                                                        .selfieDenganKtp,
                                                scale: 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.1055,
                                child: Column(
                                  children: [
                                    Text(
                                      "Foto Selfie KTP",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: new Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            image: new NetworkImage(
                                                'https://api.moneykingdom.org/public/selfie-dengan-ktp/' +
                                                    model.peserta
                                                        .selfieDenganKtp,
                                                scale: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                final _transformationController =
                                    TransformationController();
                                TapDownDetails _doubleTapDetails;
                                LongPressEndDetails _tripleTapDetails;
                                void _handleDoubleTapDown(
                                    TapDownDetails details) {
                                  _doubleTapDetails = details;
                                }

                                void _handleTripleTapDown(
                                    LongPressEndDetails details) {
                                  _tripleTapDetails = details;
                                }

                                void _handleDoubleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _doubleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 2, -position.dy * 2)
                                      ..scale(3.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                void _handleTripleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _tripleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 3, -position.dy * 3)
                                      ..scale(5.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 0.95),
                                    title: Center(
                                      child: Text(model.peserta.namaLengkap,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: GestureDetector(
                                        onDoubleTapDown: _handleDoubleTapDown,
                                        onDoubleTap: _handleDoubleTap,
                                        onLongPress: _handleTripleTap,
                                        onLongPressEnd: _handleTripleTapDown,
                                        child: InteractiveViewer(
                                          transformationController:
                                              _transformationController,
                                          child: Image(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                'https://api.moneykingdom.org/public/foto-kk/' +
                                                    model.peserta.fotoKk,
                                                scale: 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.1055,
                                child: Column(
                                  children: [
                                    Text(
                                      "Foto Kartu Keluarga",
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: new Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            image: new NetworkImage(
                                                'https://api.moneykingdom.org/public/foto-kk/' +
                                                    model.peserta.fotoKk,
                                                scale: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            GestureDetector(
                              onTap: () {
                                final _transformationController =
                                    TransformationController();
                                TapDownDetails _doubleTapDetails;
                                LongPressEndDetails _tripleTapDetails;
                                void _handleDoubleTapDown(
                                    TapDownDetails details) {
                                  _doubleTapDetails = details;
                                }

                                void _handleTripleTapDown(
                                    LongPressEndDetails details) {
                                  _tripleTapDetails = details;
                                }

                                void _handleDoubleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _doubleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 2, -position.dy * 2)
                                      ..scale(3.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                void _handleTripleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _tripleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 3, -position.dy * 3)
                                      ..scale(5.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 0.95),
                                    title: Center(
                                      child: Text(model.peserta.namaLengkap,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: GestureDetector(
                                        onDoubleTapDown: _handleDoubleTapDown,
                                        onDoubleTap: _handleDoubleTap,
                                        onLongPress: _handleTripleTap,
                                        onLongPressEnd: _handleTripleTapDown,
                                        child: InteractiveViewer(
                                          transformationController:
                                              _transformationController,
                                          child: Image(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                'https://api.moneykingdom.org/public/foto-pengenal-lainnya/' +
                                                    model.peserta
                                                        .fotoPengenalLainnya,
                                                scale: 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.1055,
                                child: Column(
                                  children: [
                                    Text(
                                      "Pengenal Lainnya",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                    AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: new Container(
                                        padding: const EdgeInsets.all(30),
                                        decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          image: new DecorationImage(
                                            fit: BoxFit.cover,
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            image: new NetworkImage(
                                                'https://api.moneykingdom.org/public/foto-pengenal-lainnya/' +
                                                    model.peserta
                                                        .fotoPengenalLainnya,
                                                scale: 1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                final _transformationController =
                                    TransformationController();
                                TapDownDetails _doubleTapDetails;
                                LongPressEndDetails _tripleTapDetails;
                                void _handleDoubleTapDown(
                                    TapDownDetails details) {
                                  _doubleTapDetails = details;
                                }

                                void _handleTripleTapDown(
                                    LongPressEndDetails details) {
                                  _tripleTapDetails = details;
                                }

                                void _handleDoubleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _doubleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 2, -position.dy * 2)
                                      ..scale(3.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                void _handleTripleTap() {
                                  if (_transformationController.value !=
                                      Matrix4.identity()) {
                                    _transformationController.value =
                                        Matrix4.identity();
                                  } else {
                                    final position =
                                        _tripleTapDetails.localPosition;
                                    // For a 3x zoom
                                    _transformationController
                                        .value = Matrix4.identity()
                                      ..translate(
                                          -position.dx * 3, -position.dy * 3)
                                      ..scale(5.0);
                                    // Fox a 2x zoom
                                    // ..translate(-position.dx, -position.dy)
                                    // ..scale(2.0);

                                  }
                                }

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 0.95),
                                    title: Center(
                                      child: Text(model.peserta.namaLengkap,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    content: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: GestureDetector(
                                        onDoubleTapDown: _handleDoubleTapDown,
                                        onDoubleTap: _handleDoubleTap,
                                        onLongPress: _handleTripleTap,
                                        onLongPressEnd: _handleTripleTapDown,
                                        child: InteractiveViewer(
                                          transformationController:
                                              _transformationController,
                                          child: Image(
                                            fit: BoxFit.contain,
                                            image: NetworkImage(
                                                'https://api.moneykingdom.org/public/foto-buku-rekening/' +
                                                    model.peserta
                                                        .fotoBukuRekening,
                                                scale: 1.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.1055,
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: new Container(
                                    padding: const EdgeInsets.all(30),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        alignment: FractionalOffset.centerLeft,
                                        image: new NetworkImage(
                                            'https://api.moneykingdom.org/public/foto-buku-rekening/' +
                                                model.peserta.fotoBukuRekening,
                                            scale: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Nama Bank :',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                SizedBox(height: 8),
                                Text("Nama Pemilik : ",
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                SizedBox(height: 8),
                                Text('No Rekening : ',
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(model.peserta.bank.nama,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                SizedBox(height: 8),
                                Text(model.peserta.namaPemilikRekening,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                SizedBox(height: 8),
                                Text(model.peserta.nomorRekening,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                left: 50,
                              ),
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    child: Text("Sebagai",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.11,
                                    child: Text("Nama Penjamin",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    child: Text("No HP ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    child: Text("No KTP",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                    child: Text("Alamat KTP",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                    child: Text("Alamat Domisili",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 50,
                              ),
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.11,
                                    child: Text(model.peserta.penjamin.nama,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    child: Text(model.peserta.penjamin.noHp,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    child: Text(model.peserta.penjamin.nomorKtp,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                    child: Text(
                                        model.peserta.penjamin.alamatKtp,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.17,
                                    child: Text(
                                        model.peserta.penjamin.alamatDomisili,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            for (int i = 0;
                                i < model.peserta.sosialmedia.length;
                                i++)
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.only(
                                  left: 50,
                                ),
                                height: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.07,
                                      child: Text(
                                          model.peserta.stakeholder[i].nama,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.11,
                                      child: Text(
                                          model.peserta.stakeholder[i].pivot2
                                              .nama,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      child: Text(
                                          model.peserta.stakeholder[i].pivot2
                                              .noHp,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
