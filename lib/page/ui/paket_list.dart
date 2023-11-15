import 'package:aplikasi_arisan/page/blocs/paket/paket_bloc.dart';
import 'package:aplikasi_arisan/page/model/paket_model.dart';
import 'package:aplikasi_arisan/page/ui/detail_paket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class PaketList extends StatefulWidget {
  @override
  _PaketListState createState() => _PaketListState();
}

class _PaketListState extends State<PaketList> {
  final PaketBloc _newsBloc = PaketBloc();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetPaketList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetPaketList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 243, 250, 1),
            ),
            child: _buildListCovid()),
      ),
    );
  }

  Widget _buildListCovid() {
    return Container(
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<PaketBloc, PaketState>(
          listener: (context, state) {
            if (state is PaketError) {}
          },
          child: BlocBuilder<PaketBloc, PaketState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is PaketInitial) {
                return _buildLoading();
              } else if (state is PaketLoading) {
                return _buildLoading();
              } else if (state is PaketLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is PaketError) {
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

  Widget _buildCard(BuildContext context, ListPaketModel model) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(100, 0, 87, 0.5),
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 2.0,
          ),
        ],
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Text('Nama Paket',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Text('Nominal Paket',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text("Slot",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.09,
                  child: Text('Periode',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text('Biaya Admin',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      child: Text("Biaya Cancel",
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.paket.length,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    child: ListTile(
                        selectedTileColor: Color.fromRGBO(255, 243, 250, 1),
                        focusColor: Color.fromRGBO(255, 243, 250, 1),
                        contentPadding: EdgeInsets.only(top: 0),
                        title: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.13,
                                  child: Text(
                                    model.paket[index].nama,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.13,
                                child: Text(
                                    formatCurrency
                                        .format(model.paket[index].nominal),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.08,
                                  child: Text(
                                      model.paket[index].slot.toString() +
                                          ' Slot',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.09,
                                  child: Text(
                                      '/ ' +
                                          model.paket[index].jumlahPeriodeBayar
                                              .toString() +
                                          ' Hari',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6)),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  child: Text(
                                      formatCurrency.format(
                                          model.paket[index].biayaAdmin),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6)),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                      child: Text(
                                          formatCurrency.format(
                                              model.paket[index].biayaCancel),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          String namapaket = model.paket[index].nama;
                          String slotpaket = model.paket[index].slot.toString();
                          String jangkapaket =
                              model.paket[index].jumlahPeriodeBayar.toString();
                          String nominalpaket =
                              formatCurrency.format(model.paket[index].nominal);
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return FutureBuilder(
                                builder: (BuildContext context, setState) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.94,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 2, left: 10),
                                                child: Text(
                                                  'List Slot ' +
                                                      namapaket +
                                                      ' | ' +
                                                      slotpaket +
                                                      ' Slot / ' +
                                                      jangkapaket +
                                                      ' Hari | ' +
                                                      ' | Nominal : ' +
                                                      nominalpaket,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.black87),
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 2, right: 5),
                                                  child: FlatButton(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 2, 0),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "Close",
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff999999),
                                                      ),
                                                    ),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.8,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.85,
                                            child:
                                                NewsDetails(model.paket[index]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ).then((value) => refreshList());
                        }),
                  ),
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
