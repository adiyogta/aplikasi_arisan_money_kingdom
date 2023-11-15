import 'package:aplikasi_arisan/page/blocs/arisan_berjalan_detail/arisan_berjalan_detail_bloc.dart';
import 'package:aplikasi_arisan/page/model/arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/model/detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/bukti_menang.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/foto_bukti_menang.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/peserta_arisan_berjalan.dart';
import 'package:aplikasi_arisan/resources/arisan_berjalan_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class DetailArisanBerjalanListUI extends StatefulWidget {
  final ArisanB model;
  DetailArisanBerjalanListUI({this.model});

  @override
  _DetailArisanBerjalanListUIState createState() =>
      _DetailArisanBerjalanListUIState();
}

class _DetailArisanBerjalanListUIState
    extends State<DetailArisanBerjalanListUI> {
  final ArisanBerjalanDetailBloc _newsBloc = ArisanBerjalanDetailBloc();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetArisanBerjalanDetailList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetArisanBerjalanDetailList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
          key: refreshKey, onRefresh: refreshList, child: _buildListCovid()),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child:
            BlocListener<ArisanBerjalanDetailBloc, ArisanBerjalanDetailState>(
          listener: (context, state) {
            if (state is ArisanBerjalanDetailError) {}
          },
          child:
              BlocBuilder<ArisanBerjalanDetailBloc, ArisanBerjalanDetailState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanBerjalanDetailInitial) {
                return _buildLoading();
              } else if (state is ArisanBerjalanDetailLoading) {
                return _buildLoading();
              } else if (state is ArisanBerjalanDetailLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanBerjalanDetailError) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
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

  Widget _buildCard(BuildContext context, ArisanBerjalanDetailModel model) {
    // String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    String a = 'selesai';
    return Scaffold(
      floatingActionButton: FlatButton(
        minWidth: 130,
        height: 25,
        color: Colors.cyan[800],
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  'Anda Yakin Menyelsaikan Arisan ?',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(
                    height: 30,
                    minWidth: 120,
                    shape: StadiumBorder(),
                    child: Text('Tidak',
                        style: Theme.of(context).textTheme.headline5),
                    color: Colors.red[700],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  FlatButton(
                    height: 30,
                    minWidth: 120,
                    color: Colors.cyan[800],
                    onPressed: () async {
                      final adApiProvider = ArisanBerjalanApiProvider();
                      DateTime selectedDate = DateTime.now();
                      print(selectedDate);
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(selectedDate);

                      var status = a;
                      var tgl = formattedDate;
                      Map<String, dynamic> jwt =
                          await adApiProvider.selesaiAB(tgl, status);
                      if (jwt['status_code'] == 200) {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.lightGreen[800],
                            title: Center(
                              child: Text(
                                'Arisan Sudah Selesai',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ),
                        ).then((value) => refreshList());
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              backgroundColor: Colors.red[800],
                              title: Center(
                                child: Text(
                                  'Gagal Ubah Data',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              content: Text(
                                jwt.toString(),
                                style: Theme.of(context).textTheme.headline5,
                              )),
                        );
                      }
                    },
                    shape: StadiumBorder(),
                    child: Text('Selesaikan',
                        style: Theme.of(context).textTheme.headline5),
                  ),
                ],
              ),
            ),
          );
        },
        shape: StadiumBorder(),
        padding: EdgeInsets.all(10),
        child: Text('Selesaikan Arisan',
            style: Theme.of(context).textTheme.headline5),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
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
                    width: MediaQuery.of(context).size.width * 0.06,
                    alignment: Alignment.center,
                    child: Text('No Slot',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text('Username',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.11,
                    child: Text('Tanggal Dapat',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    alignment: Alignment.center,
                    child: Text('Operation',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.arisan[0].peserta.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: GestureDetector(
                      child: ListTile(
                        title: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.06,
                                child: Text(
                                    '# ' +
                                        model.arisan[0].peserta[index].slotNomor
                                            .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: (model.arisan[0].peserta[index]
                                                .slotNomor ==
                                            1 ||
                                        model.arisan[0].peserta[index]
                                                .username ==
                                            null)
                                    ? Text("Money Kingdom",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6)
                                    : Text(
                                        model.arisan[0].peserta[index].username,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width * 0.11,
                                child: Text(
                                    model.arisan[0].peserta[index].tanggalDapat
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.08,
                                    alignment: Alignment.center,
                                    child: FlatButton(
                                      minWidth: 60,
                                      height: 25,
                                      shape: StadiumBorder(),
                                      color: Colors.lightBlue[800],
                                      child: Text(
                                        'Detail',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      onPressed: () async {
                                        String id = model
                                            .arisan[0].peserta[index].id
                                            .toString();
                                        print(id);

                                        storage.write(
                                            key: "id_ArisanBerjalanDetail",
                                            value: id);

                                        String slotNo = model
                                            .arisan[0].peserta[index].slotNomor
                                            .toString();
                                        String username = model
                                            .arisan[0].peserta[index].username;

                                        showModalBottomSheet<void>(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.92,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    new BorderRadius.only(
                                                  topLeft:
                                                      const Radius.circular(
                                                          10.0),
                                                  topRight:
                                                      const Radius.circular(
                                                          10.0),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 2,
                                                                  left: 10),
                                                          child: Text(
                                                            'List Detail Slot Nomor : ' +
                                                                slotNo +
                                                                " Username : " +
                                                                username,
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                color: Colors
                                                                    .black87),
                                                          ),
                                                        ),
                                                        Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 2,
                                                                    right: 5),
                                                            child: FlatButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          2,
                                                                          0,
                                                                          2,
                                                                          0),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                "Close",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.77,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.95,
                                                      child:
                                                          PesertaArisanBerjalanListUI(
                                                              model.arisan[0]),
                                                      //     ArisanBerjalanDetail(model.arisan[index]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  // (formattedDate ==
                                  //         model.arisan[0].peserta[index]
                                  //             .tanggalDapat)
                                  //     ?
                                  (model.arisan[0].peserta[index]
                                              .buktiTransferMenang ==
                                          null)
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          alignment: Alignment.center,
                                          child: FlatButton(
                                            minWidth: 100,
                                            height: 25,
                                            shape: StadiumBorder(),
                                            color: Colors.lightBlue[800],
                                            child: Text(
                                              'Upld Bkt Menang',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                            onPressed: () async {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Center(
                                                    child: Text(
                                                      'Upload Foto Bukti Menang',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline3,
                                                    ),
                                                  ),
                                                  content: BuktiMenang(model
                                                      .arisan[0]
                                                      .peserta[index]),
                                                ),
                                              ).then((value) => refreshList());
                                            },
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.14,
                                          child: FotoMenang(
                                              model.arisan[0].peserta[index]),
                                        ),
                                  // : Container(
                                  //     width:
                                  //         MediaQuery.of(context).size.width *
                                  //             0.14,
                                  //     alignment: Alignment.center,
                                  //     child: FlatButton(
                                  //       shape: StadiumBorder(),
                                  //       color: Colors.blueGrey[800],
                                  //       child: Text(
                                  //         'Upload Bukti Menang',
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .headline5,
                                  //       ),
                                  //       onPressed: () async {
                                  //         String id = model
                                  //             .arisan[0].peserta[index].id
                                  //             .toString();

                                  //         showDialog(
                                  //           context: context,
                                  //           builder: (context) => AlertDialog(
                                  //             backgroundColor:
                                  //                 Colors.red[900],
                                  //             title: Center(
                                  //               child: Text(
                                  //                 'Belum Tanggal Menang Yang Sudah Ditentukan',
                                  //                 style: Theme.of(context)
                                  //                     .textTheme
                                  //                     .headline5,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
