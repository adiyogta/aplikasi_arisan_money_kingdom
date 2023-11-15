import 'package:aplikasi_arisan/page/model/peserta_detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/bukti_bayar.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/foto_bukti_bayar.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/validasi_bukti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class PilihPeriode extends StatefulWidget {
  final Peserta peserta;
  PilihPeriode(this.peserta);

  @override
  _PilihPeriodeState createState() => _PilihPeriodeState();
}

class _PilihPeriodeState extends State<PilihPeriode> {
  List<int> _selectedItems = List<int>();
  List<String> _selectedID = List<String>();
  List<String> _selectedPeriode = List<String>();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      // ignore: unnecessary_statements
      widget.peserta;
    });

    return null;
  }

  var jwtA;
  var jwtO;
  var jwtM;

  // ignore: missing_return
  Future<String> get jwtOrEmpty async {
    // var jwt;
    var jwt = await storage.read(key: "jwt");
    var jwtAdmin = await storage.read(key: "jwtAdmin");
    var jwtOwner = await storage.read(key: "jwtOwner");
    jwtA = jwtAdmin;
    jwtO = jwtOwner;
    jwtM = jwt;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (jwtO == null)
          ? FlatButton(
              height: 25,
              minWidth: 80,
              shape: StadiumBorder(),
              color: Colors.pink[800],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.white,
                    title: Center(
                      child: Text(
                        'Upload Foto Bukti Pembayaran',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    content: BuktiBayar(_selectedID),
                  ),
                );
              },
              child: Text(
                'Bayar',
                style: Theme.of(context).textTheme.headline5,
              ),
            )
          : FlatButton(
              height: 25,
              minWidth: 80,
              shape: StadiumBorder(),
              color: Colors.pink[800],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.red[900],
                    title: Center(
                      child: Text(
                        'Hanya Owner Yang Memiliki Akses Ini',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                );
              },
              child: Text(
                'Bayar',
                style: Theme.of(context).textTheme.headline5,
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
              padding: EdgeInsets.all(15),
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
                    child: Text('Periode',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    child: Text('Pasok',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    alignment: Alignment.center,
                    child: Text('Status',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.11,
                    alignment: Alignment.center,
                    child: Text('Bukti Bayar',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.11,
                    alignment: Alignment.center,
                    child: Text('Operation',
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
                itemCount: widget.peserta.transaksi.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: (_selectedItems.contains(index))
                        ? Colors.blue.withOpacity(0.5)
                        : Colors.transparent,
                    child: (widget.peserta.transaksi[index].buktiPembayaran ==
                            null)
                        ? GestureDetector(
                            onDoubleTap: () {
                              if (_selectedItems.contains(index)) {
                                setState(() {
                                  _selectedID.removeWhere((val) =>
                                      val ==
                                      widget.peserta.transaksi[index].id
                                          .toString());
                                  _selectedPeriode.removeWhere((val) =>
                                      val ==
                                      widget.peserta.transaksi[index].periode
                                          .toString());
                                  _selectedItems
                                      .removeWhere((val) => val == index);
                                });
                              }
                            },
                            onTap: () {
                              if (!_selectedItems.contains(index)) {
                                setState(() {
                                  _selectedID.add(widget
                                      .peserta.transaksi[index].id
                                      .toString());
                                  _selectedPeriode.add(widget
                                      .peserta.transaksi[index].periode
                                      .toString());
                                  _selectedItems.add(index);
                                  print(_selectedID);
                                });
                              }
                            },
                            child: ListTile(
                              title: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.06,
                                      child: Text(
                                          '# ' +
                                              widget.peserta.transaksi[index]
                                                  .periode
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      child: Text(
                                          widget.peserta.pasok.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    (widget.peserta.transaksi[index].status ==
                                                'belum ada pembayaran' &&
                                            widget.peserta.transaksi[index]
                                                    .buktiPembayaran !=
                                                null)
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            child: Text("menunggu",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            child: Text(
                                                widget.peserta.transaksi[index]
                                                    .status,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                          ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.11,
                                      child: FotoBayar(
                                          widget.peserta.transaksi[index]),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.11,
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                        height: 25,
                                        shape: StadiumBorder(),
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          print(widget.peserta.transaksi[index]
                                              .buktiPembayaran);

                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.pink[800],
                                              title: Center(
                                                child: Text(
                                                  'Validasi Bukti Pembayaran',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                              content: ValidasiBukti(widget
                                                  .peserta.transaksi[index]),
                                            ),
                                          ).then((value) => refreshList());
                                        },
                                        child: Text('Validasi Bukti',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.lightGreen[800],
                                  title: Center(
                                    child: Text(
                                      'Bukti Pembayaran Sudah Disetujui Atau Menunggu Divalidasi',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black12),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width *
                                          0.06,
                                      child: Text(
                                          '# ' +
                                              widget.peserta.transaksi[index]
                                                  .periode
                                                  .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      child: Text(
                                          widget.peserta.pasok.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.03,
                                    ),
                                    (widget.peserta.transaksi[index].status ==
                                                'belum ada pembayaran' &&
                                            widget.peserta.transaksi[index]
                                                    .buktiPembayaran !=
                                                null)
                                        ? Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            child: Text("menunggu",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                          )
                                        : Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            child: Text(
                                                widget.peserta.transaksi[index]
                                                    .status,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6),
                                          ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.11,
                                      child: FotoBayar(
                                          widget.peserta.transaksi[index]),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.11,
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                        shape: StadiumBorder(),
                                        color: Colors.blueGrey[900],
                                        onPressed: () {
                                          print(widget.peserta.transaksi[index]
                                              .buktiPembayaran);

                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              backgroundColor: Colors.pink[800],
                                              title: Center(
                                                child: Text(
                                                  'Validasi Bukti Pembayaran',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                              content: ValidasiBukti(widget
                                                  .peserta.transaksi[index]),
                                            ),
                                          ).then((value) => refreshList());
                                        },
                                        child: Text('Validasi Bukti',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5),
                                      ),
                                    )
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
}
