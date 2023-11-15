import 'package:aplikasi_arisan/page/blocs/arisan_selesai/arisan_selesai_bloc.dart';
import 'package:aplikasi_arisan/page/model/arisan_selesai.dart';
import 'package:aplikasi_arisan/page/ui/arisan_selesai/arisan_selesai_detail.dart';
import 'package:aplikasi_arisan/resources/arisan_selesai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class ArisanSelesaiListUI extends StatefulWidget {
  @override
  _ArisanSelesaiListUIState createState() => _ArisanSelesaiListUIState();
}

class _ArisanSelesaiListUIState extends State<ArisanSelesaiListUI> {
  final ArisanSelesaiBloc _newsBloc = ArisanSelesaiBloc();
  final arisanSelesaiApiProvider = ArisanSelesaiApiProvider();

  @override
  void initState() {
    _newsBloc.add(GetArisanSelesaiList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 243, 250, 1),
          ),
          child: _buildListCovid()),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<ArisanSelesaiBloc, ArisanSelesaiState>(
          listener: (context, state) {
            if (state is ArisanSelesaiError) {}
          },
          child: BlocBuilder<ArisanSelesaiBloc, ArisanSelesaiState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanSelesaiInitial) {
                return _buildLoading();
              } else if (state is ArisanSelesaiLoading) {
                return _buildLoading();
              } else if (state is ArisanSelesaiLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanSelesaiError) {
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

  Widget _buildCard(BuildContext context, ArisanSelesaiModel model) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 0.2,
              childAspectRatio: 4 / 1.5,
              mainAxisSpacing: 10,
              crossAxisCount: 4,
            ),
            itemCount: model.arisan.length,
            itemBuilder: (context, index) {
              return Container(
                child: GestureDetector(
                  child: ListTile(
                    subtitle: Container(
                      height: MediaQuery.of(context).size.height * 0.208,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.pink[700],
                        gradient: LinearGradient(
                          colors: [
                            Colors.pink[700],
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
                      storage.write(key: "id_ArisanSelesai", value: id);
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
                                          margin:
                                              EdgeInsets.only(top: 2, right: 5),
                                          child: FlatButton(
                                            padding:
                                                EdgeInsets.fromLTRB(2, 0, 2, 0),
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
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      child: DetailArisanSelesaiListUI(
                                          model.arisan[index])),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
