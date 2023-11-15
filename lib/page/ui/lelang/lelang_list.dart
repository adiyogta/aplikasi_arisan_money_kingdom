import 'package:aplikasi_arisan/page/blocs/lelang/lelang_bloc.dart';
import 'package:aplikasi_arisan/page/model/lelang_model.dart';
import 'package:aplikasi_arisan/page/ui/lelang/lelang_detail.dart';
import 'package:aplikasi_arisan/page/ui/lelang/lelang_disetujui.dart';
import 'package:aplikasi_arisan/resources/lelang_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class LelangListUI extends StatefulWidget {
  @override
  _LelangListUIState createState() => _LelangListUIState();
}

class _LelangListUIState extends State<LelangListUI> {
  final LelangBloc _newsBloc = LelangBloc();
  final lelangApiProvider = LelangApiProvider();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetLelangList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetLelangList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FlatButton(
        height: 30,
        minWidth: 145,
        shape: StadiumBorder(),
        color: Colors.deepPurple[800],
        child: Text(
          'Lelang Yang Disetujui',
          style: Theme.of(context).textTheme.headline5,
        ),
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.93,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 2, left: 10),
                            child: Text(
                              'List List Disetujui ',

                              // nominalArisan,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black87),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 2, right: 5),
                              child: FlatButton(
                                padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Close",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: LelangDisetujui(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 243, 250, 1),
          ),
          child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshList,
              child: _buildListCovid())),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<LelangBloc, LelangState>(
          listener: (context, state) {
            if (state is LelangError) {}
          },
          child: BlocBuilder<LelangBloc, LelangState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is LelangInitial) {
                return _buildLoading();
              } else if (state is LelangLoading) {
                return _buildLoading();
              } else if (state is LelangLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is LelangError) {
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

  Widget _buildCard(BuildContext context, LelangModel model) {
    // ignore: unused_local_variable
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Expanded(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(7.0),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
        ),
        itemCount: model.lelang.length,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            child: GestureDetector(
              child: ListTile(
                subtitle: Container(
                  height: MediaQuery.of(context).size.height * 0.208,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromRGBO(175, 45, 45, 1),
                    gradient: LinearGradient(
                      colors: [
                        Color.fromRGBO(175, 45, 45, 1),
                        Color.fromRGBO(240, 40, 70, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(model.lelang[index].nama,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(
                        height: 14,
                      ),
                      // Text(formatCurrency.format(model.lelang[index].nominal),
                      //     style: Theme.of(context).textTheme.headline5),
                      Text(
                          'Nomor Slot ' +
                              model.lelang[index].slotNomor.toString(),
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
                onTap: () async {
                  String id = model.lelang[index].id.toString();
                  storage.write(key: "id_lelang", value: id);
                  String namaArisan = model.lelang[index].nama;
                  String slotArisan = model.lelang[index].slotNomor.toString();

                  // String nominalArisan =
                  //     formatCurrency.format(model.lelang[index].nominal);

                  showModalBottomSheet<void>(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.85,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(top: 5, left: 10),
                                    child: Text(
                                      'List Detail ' +
                                          namaArisan +
                                          ' | Nomor Slot :' +
                                          slotArisan,

                                      // nominalArisan,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.black87),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 5, right: 5),
                                      child: FlatButton(
                                        padding:
                                            EdgeInsets.fromLTRB(5, 0, 5, 0),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Close",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      )),
                                ],
                              ),
                              SizedBox(height: 5),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.71,
                                width: MediaQuery.of(context).size.width * 0.85,
                                child: LelangDetail(model.lelang[index]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ).then((value) => refreshList());
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
