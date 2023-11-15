import 'package:aplikasi_arisan/page/blocs/arisan_ditawarkan/arisan_ditawarkan_bloc.dart';
import 'package:aplikasi_arisan/page/model/arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/page/ui/arisan_ditawarkan/arisan_detail.dart';
import 'package:aplikasi_arisan/resources/arisan_ditawarkan_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class ArisanDitawarkanListUI extends StatefulWidget {
  @override
  _ArisanDitawarkanListUIState createState() => _ArisanDitawarkanListUIState();
}

class _ArisanDitawarkanListUIState extends State<ArisanDitawarkanListUI> {
  final ArisanDitawarkanBloc _newsBloc = ArisanDitawarkanBloc();
  final arisanDitawarkanApiProvider = ArisanDitawarkanApiProvider();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetArisanDitawarkanList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetArisanDitawarkanList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: BlocListener<ArisanDitawarkanBloc, ArisanDitawarkanState>(
          listener: (context, state) {
            if (state is ArisanDitawarkanError) {}
          },
          child: BlocBuilder<ArisanDitawarkanBloc, ArisanDitawarkanState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanDitawarkanInitial) {
                return _buildLoading();
              } else if (state is ArisanDitawarkanLoading) {
                return _buildLoading();
              } else if (state is ArisanDitawarkanLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanDitawarkanError) {
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

  Widget _buildCard(BuildContext context, ArisanDitawarkanList model) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cari(),
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(7.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 0.2,
                childAspectRatio: 4 / 1.5,
                mainAxisSpacing: 10,
                crossAxisCount: 4,
              ),
              itemCount: model.arisan.length,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    child: ListTile(
                      title: Container(
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(model.arisan[index].nama,
                                style: Theme.of(context).textTheme.headline5),
                            // SizedBox(
                            //   height: 14,
                            // ),
                            // Text(
                            //     formatCurrency
                            //         .format(model.arisan[index].nominal),
                            //     style: Theme.of(context).textTheme.headline5),
                            // Text(model.arisan[index].slot.toString() + ' Slot',
                            //     style: Theme.of(context).textTheme.headline5),
                            // Text(
                            //   '/ ' +
                            //       model.arisan[index].jumlahPeriodeBayar
                            //           .toString() +
                            //       ' Hari',
                            //   style: Theme.of(context).textTheme.headline5,
                            // ),
                          ],
                        ),
                      ),
                      onTap: () async {
                        String id = model.arisan[index].id.toString();
                        storage.write(key: "id_arisanDitawarkan", value: id);
                        String namaArisan = model.arisan[index].nama;
                        String slotArisan = model.arisan[index].slot.toString();
                        String jangkaArisan =
                            model.arisan[index].jumlahPeriodeBayar.toString();
                        String nominalArisan =
                            formatCurrency.format(model.arisan[index].nominal);

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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.only(top: 2, left: 10),
                                          child: Text(
                                            'List Detail ' +
                                                namaArisan +
                                                ' | ' +
                                                slotArisan +
                                                ' Slot | ' +
                                                jangkaArisan +
                                                ' Hari | ' +
                                                nominalArisan,
                                            style: TextStyle(
                                                fontSize: 11,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black87),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 2, right: 5),
                                            child: FlatButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  2, 0, 2, 0),
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
                                    SizedBox(height: 2),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: ArisanDitawarkanDetail(
                                          model.arisan[index]),
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
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
