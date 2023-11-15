import 'package:aplikasi_arisan/page/blocs/arisan_ditawarkan_detail/arisan_ditawarkan_detail_bloc.dart';
import 'package:aplikasi_arisan/page/model/arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/page/model/detail_arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/page/ui/arisan_ditawarkan/pickTanggal.dart';
import 'package:aplikasi_arisan/page/ui/arisan_ditawarkan/status.dart';
import 'package:aplikasi_arisan/resources/arisan_ditawarkan_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class ArisanDitawarkanDetail extends StatefulWidget {
  final Arisan arisan;
  ArisanDitawarkanDetail(this.arisan);

  @override
  _ArisanDitawarkanDetailState createState() => _ArisanDitawarkanDetailState();
}

class _ArisanDitawarkanDetailState extends State<ArisanDitawarkanDetail> {
  final ArisanDitawarkanDetailBloc _newsBloc = ArisanDitawarkanDetailBloc();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetArisanDitawarkanDetailList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetArisanDitawarkanDetailList());
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
        child: BlocListener<ArisanDitawarkanDetailBloc,
            ArisanDitawarkanDetailState>(
          listener: (context, state) {
            if (state is ArisanDitawarkanDetailError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ArisanDitawarkanDetailBloc,
              ArisanDitawarkanDetailState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanDitawarkanDetailInitial) {
                return _buildLoading();
              } else if (state is ArisanDitawarkanDetailLoading) {
                return _buildLoading();
              } else if (state is ArisanDitawarkanDetailLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanDitawarkanDetailError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, DetailArisanDitawarkan model) {
    String a = 'berjalan';
    var count;
    model.arisan[0].peserta.map((value) {
      if (value.status.contains("menunggu")) {
        print(value.status.length);
        count = value.status.length;
      }
    }).toList();
    return Scaffold(
      floatingActionButton: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            GetTanggal(),
            (count == null)
                ? FlatButton(
                    height: 25,
                    minWidth: 120,
                    color: Colors.cyan[800],
                    onPressed: () async {
                      String value2 = await storage.read(key: 'tgl_mulai');
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.white,
                          title: Center(
                            child: Text(
                              'Anda Yakin Memulai Arisan Dengan Tanggal $value2 ?',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FlatButton(
                                height: 30,
                                minWidth: 120,
                                shape: StadiumBorder(),
                                child: Text('Tidak',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                color: Colors.red[700],
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              FlatButton(
                                height: 25,
                                minWidth: 120,
                                color: Colors.cyan[800],
                                onPressed: () async {
                                  final adApiProvider =
                                      ArisanDitawarkanApiProvider();
                                  String value =
                                      await storage.read(key: 'tgl_mulai');
                                  var now = DateTime.now();
                                  String formattedDate =
                                      DateFormat('dd-MM-yyyy – kk:mm')
                                          .format(now);
                                  var status = a;
                                  var id = widget.arisan.id.toString();
                                  print(id);
                                  var tgl;
                                  if (value == null) {
                                    tgl = formattedDate;
                                  } else {
                                    tgl = value;
                                  }
                                  Map<String, dynamic> jwt = await adApiProvider
                                      .mulaiAD(id, tgl, status);
                                  if (jwt['status_code'] == 200) {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.lightGreen[800],
                                        title: Center(
                                          child: Text(
                                            'Arisan Sudah Berjalan',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
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
                                          )),
                                    );
                                  }
                                },
                                shape: StadiumBorder(),
                                child: Text('Mulai',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    shape: StadiumBorder(),
                    child: Text('Mulai Arisan',
                        style: Theme.of(context).textTheme.headline5),
                  )
                : FlatButton(
                    height: 25,
                    minWidth: 120,
                    shape: StadiumBorder(),
                    child: Text('Mulai Arisan',
                        style: Theme.of(context).textTheme.headline5),
                    color: Colors.grey[700],
                    onPressed: () {},
                  ),
          ],
        ),
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
                    width: MediaQuery.of(context).size.width * 0.11,
                    child: Text('Pasok',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.14,
                    child: Text("Status Arisan",
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.09,
                    child: Text('Status',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
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
                                            .username ==
                                        null)
                                    ? Text("Belum Ada",
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
                                width: MediaQuery.of(context).size.width * 0.11,
                                child: Text(
                                    model.arisan[0].peserta[index].pasok
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.14,
                                child: (model.arisan[0].peserta[index]
                                            .statusArisanType ==
                                        null)
                                    ? Text("Belum Ada",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6)
                                    : Text(
                                        model.arisan[0].peserta[index]
                                            .statusArisanType,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6),
                              ),
                              model.arisan[0].peserta[index].status ==
                                      'disetujui'
                                  ? Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green[100]),
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      child: Text(
                                          model.arisan[0].peserta[index].status,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(4),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: model.arisan[0].peserta[index]
                                                      .status ==
                                                  'menunggu'
                                              ? Colors.grey[200]
                                              : Colors.red[200]),
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      child: Text(
                                          model.arisan[0].peserta[index].status,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                              (model.arisan[0].peserta[index]
                                              .statusArisanType ==
                                          model.arisan[0].peserta[0]
                                              .statusArisanType ||
                                      model.arisan[0].peserta[index].username ==
                                          null)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        iconSize: 16,
                                        color: Colors.black87,
                                        icon: Icon(Icons.create_sharp),
                                        onPressed: () {
                                          if (model.arisan[0].peserta[index]
                                                  .statusArisanType ==
                                              model.arisan[0].peserta[0]
                                                  .statusArisanType) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor:
                                                    Colors.red[800],
                                                title: Center(
                                                  child: Text(
                                                    'Slot Milik Money Kingdom',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else if (model.arisan[0]
                                                  .peserta[index].username ==
                                              null) {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                backgroundColor:
                                                    Colors.red[800],
                                                title: Center(
                                                  child: Text(
                                                    'Slot Belum Terambil',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        iconSize: 16,
                                        color: Colors.lightBlue[800],
                                        icon: Icon(Icons.create_sharp),
                                        onPressed: () {
                                          final TextEditingController
                                              _statusController =
                                              TextEditingController();
                                          clearTextInput() {
                                            _statusController.clear();
                                          }

                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        'Status Ambil Arisan',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                      ),
                                                      Text(
                                                        'Apakah ' +
                                                            model
                                                                .arisan[0]
                                                                .peserta[index]
                                                                .username +
                                                            ' dapat mengambil slot nomor : ' +
                                                            model
                                                                .arisan[0]
                                                                .peserta[index]
                                                                .slotNomor
                                                                .toString() +
                                                            ', dengan pasok ' +
                                                            model
                                                                .arisan[0]
                                                                .peserta[index]
                                                                .pasok
                                                                .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                      ),
                                                      StatusSlot(),
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          maxLines: 3,
                                                          maxLength: 250,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6,
                                                          controller:
                                                              _statusController,
                                                          decoration:
                                                              InputDecoration(
                                                            focusedBorder:
                                                                UnderlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        154,
                                                                        0,
                                                                        87,
                                                                        1),
                                                              ),
                                                            ),
                                                            labelText:
                                                                'Catatan Tambahan',
                                                            labelStyle:
                                                                Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6,
                                                          ),
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        height: 25,
                                                        minWidth: 120,
                                                        shape: StadiumBorder(),
                                                        color: Colors.pink[800],
                                                        child: Text(
                                                          "Ubah",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                        onPressed: () async {
                                                          final adApiProvider =
                                                              ArisanDitawarkanApiProvider();
                                                          var pesan =
                                                              _statusController
                                                                  .text;

                                                          String value =
                                                              await storage.read(
                                                                  key:
                                                                      'status_slot');
                                                          String status = value;
                                                          print(status);
                                                          var id = model
                                                              .arisan[0]
                                                              .peserta[index]
                                                              .id
                                                              .toString();
                                                          Map<String, dynamic>
                                                              jwt =
                                                              await adApiProvider
                                                                  .updateADD(
                                                                      id,
                                                                      status,
                                                                      pesan);
                                                          if (jwt['status_code'] ==
                                                              200) {
                                                            clearTextInput();
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
                                                                    'Berhasil Ubah Data',
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
                                                              builder: (context) =>
                                                                  AlertDialog(
                                                                      backgroundColor:
                                                                          Colors.red[
                                                                              800],
                                                                      title:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'Gagal Ubah Data',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .headline5,
                                                                        ),
                                                                      ),
                                                                      content:
                                                                          Text(
                                                                        jwt.toString(),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .headline5,
                                                                      )),
                                                            );
                                                          }
                                                        },
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
