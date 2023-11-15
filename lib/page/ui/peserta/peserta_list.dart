import 'package:aplikasi_arisan/page/blocs/peserta/peserta_bloc.dart';
import 'package:aplikasi_arisan/page/model/peserta_model.dart';
import 'package:aplikasi_arisan/page/ui/peserta/detail_peserta.dart';
import 'package:aplikasi_arisan/resources/peserta_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class PesertaListUI extends StatefulWidget {
  @override
  _PesertaListUIState createState() => _PesertaListUIState();
}

class _PesertaListUIState extends State<PesertaListUI> {
  final PesertaBloc _newsBloc = PesertaBloc();
  final pesertaApiProvider = PesertaApiProvider();

  String query;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetPesertaList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetPesertaList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 250, 1),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: _buildListCovid(),
      ),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<PesertaBloc, PesertaState>(
          listener: (context, state) {
            if (state is PesertaError) {}
          },
          child: BlocBuilder<PesertaBloc, PesertaState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is PesertaInitial) {
                return _buildLoading();
              } else if (state is PesertaLoading) {
                return _buildLoading();
              } else if (state is PesertaLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is PesertaError) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.signal_cellular_no_sim_outlined,
                        size: 45,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.message,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, PesertaModel model) {
    var a = MediaQuery.of(context).size.width * 0.015;
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Cari(),
          // SizedBox(
          //   height: 10,
          // ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.06,
                  child:
                      Text('ID', style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: a),
                  width: MediaQuery.of(context).size.width * 0.03,
                  alignment: Alignment.center,
                  child: Text('Foto',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: Text('Username',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Text("Nama Lengkap",
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text('No HP',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text('Status',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  alignment: Alignment.center,
                  child: Text("Operation",
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.peserta.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: Text('# ' + model.peserta[index].id.toString(),
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: a),
                          width: MediaQuery.of(context).size.width * 0.035,
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: new Container(
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: FractionalOffset.center,
                                  image: new NetworkImage(
                                      'https://api.moneykingdom.org/public/foto-profil/' +
                                          model.peserta[index].fotoProfil,
                                      scale: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.11,
                          child: Text(model.peserta[index].username,
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.13,
                            child: Text(model.peserta[index].namaLengkap,
                                style: Theme.of(context).textTheme.headline6)),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(model.peserta[index].noHp,
                                style: Theme.of(context).textTheme.headline6)),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.08,
                            child: Text(model.peserta[index].status,
                                style: Theme.of(context).textTheme.headline6)),
                        SizedBox(
                          width: 2,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.1,
                            alignment: Alignment.center,
                            child: FlatButton(
                              height: 25,
                              minWidth: 50,
                              color: Colors.red[800],
                              shape: StadiumBorder(),
                              child: Text(
                                "Action",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Center(
                                      child: Text(
                                        'Hapus Atau Ban Peserta',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              hoverColor: Colors.red[100],
                                              icon: Icon(
                                                Icons.delete,
                                                size: 18,
                                                color: Colors.red[900],
                                              ),
                                              color: Colors.lightBlue[800],
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    backgroundColor:
                                                        Colors.pink[800],
                                                    title: Center(
                                                      child: Text(
                                                        'Hapus Peserta',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline5,
                                                      ),
                                                    ),
                                                    content: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        FlatButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            'Batal',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5,
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          onPressed: () async {
                                                            final adApiProvider =
                                                                PesertaApiProvider();
                                                            var id = model
                                                                .peserta[index]
                                                                .id
                                                                .toString();
                                                            Map<String, dynamic>
                                                                jwt =
                                                                await adApiProvider
                                                                    .hapusPeserta(
                                                              id,
                                                            );
                                                            if (jwt['status_code'] ==
                                                                200) {
                                                              Navigator.pop(
                                                                  context);
                                                              refreshList();
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  backgroundColor:
                                                                      Colors.lightGreen[
                                                                          800],
                                                                  title: Center(
                                                                    child: Text(
                                                                      'Akun Sudah Dihapus',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline5,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                  backgroundColor:
                                                                      Colors.red[
                                                                          800],
                                                                  title: Center(
                                                                    child: Text(
                                                                      'Gagal Hapus Password',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headline5,
                                                                    ),
                                                                  ),
                                                                  content: Text(
                                                                    jwt.toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline5,
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                          child: Text(
                                                            'Ya',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                          IconButton(
                                            hoverColor: Colors.red[100],
                                            icon: Icon(
                                              Icons.cancel,
                                              size: 19,
                                              color: Colors.red[900],
                                            ),
                                            color: Colors.lightBlue[800],
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  backgroundColor:
                                                      Colors.pink[800],
                                                  title: Center(
                                                    child: Text(
                                                      'Ban Akun Peserta',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5,
                                                    ),
                                                  ),
                                                  content: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Batal',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () async {
                                                          final adApiProvider =
                                                              PesertaApiProvider();
                                                          var id = model
                                                              .peserta[index].id
                                                              .toString();
                                                          Map<String, dynamic>
                                                              jwt =
                                                              await adApiProvider
                                                                  .banPeserta(
                                                            id,
                                                          );
                                                          if (jwt['status_code'] ==
                                                              200) {
                                                            Navigator.pop(
                                                                context);
                                                            refreshList();
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                backgroundColor:
                                                                    Colors.lightGreen[
                                                                        800],
                                                                title: Center(
                                                                  child: Text(
                                                                    'Akun Sudah Diban',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline5,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      AlertDialog(
                                                                backgroundColor:
                                                                    Colors.red[
                                                                        800],
                                                                title: Center(
                                                                  child: Text(
                                                                    'Gagal Ban Akun',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .headline5,
                                                                  ),
                                                                ),
                                                                content: Text(
                                                                  jwt.toString(),
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .headline5,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                        child: Text(
                                                          'Ya',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ]),
                                  ),
                                );
                              },
                            )),
                      ],
                    ),
                  ),
                  onTap: () {
                    String id = model.peserta[index].id.toString();
                    storage.write(key: "id_peserta", value: id);
                    String namapaket = model.peserta[index].namaLengkap;
                    // String slotpaket = model.peserta[index].slot;
                    // String jangkapaket =
                    //     model.peserta[index].jumlahPeriodeBayar;
                    // String nominalpaket = formatCurrency
                    //     .format(int.parse(model.peserta[index].nominal));
                    // String biayaad = formatCurrency.format(
                    //     int.parse(model.peserta[index].biayaAdmin));
                    // String biayaca = formatCurrency.format(
                    //     int.parse(model.peserta[index].biayaCancel));
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.94,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(10.0),
                              topRight: const Radius.circular(10.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius:
                                    10.0, // has the effect of softening the shadow
                                spreadRadius:
                                    0.0, // has the effect of extending the shadow
                              )
                            ],
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 2, left: 8),
                                      child: Text(
                                        'Detail Peserta $namapaket',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.only(top: 2, right: 3),
                                        child: FlatButton(
                                          height: 25,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Close",
                                            style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff999999),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.83,
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: PesertaDetail(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
