import 'package:aplikasi_arisan/page/blocs/arisan_selesai_detail/arisan_selesai_detail_bloc.dart';
import 'package:aplikasi_arisan/page/model/arisan_selesai.dart';
import 'package:aplikasi_arisan/page/model/arisan_selesai_detail.dart';
import 'package:aplikasi_arisan/page/ui/arisan_selesai/foto_bukti_menang.dart';
import 'package:aplikasi_arisan/page/ui/arisan_selesai/peserta_arisan_selesai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class DetailArisanSelesaiListUI extends StatefulWidget {
  final ArisanS model;
  DetailArisanSelesaiListUI(this.model);

  @override
  _DetailArisanSelesaiListUIState createState() =>
      _DetailArisanSelesaiListUIState();
}

class _DetailArisanSelesaiListUIState extends State<DetailArisanSelesaiListUI> {
  final ArisanSelesaiDetailBloc _newsBloc = ArisanSelesaiDetailBloc();

  @override
  void initState() {
    _newsBloc.add(GetArisanSelesaiDetailList());
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
        child: BlocListener<ArisanSelesaiDetailBloc, ArisanSelesaiDetailState>(
          listener: (context, state) {
            if (state is ArisanSelesaiDetailError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ArisanSelesaiDetailBloc, ArisanSelesaiDetailState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanSelesaiDetailInitial) {
                return _buildLoading();
              } else if (state is ArisanSelesaiDetailLoading) {
                return _buildLoading();
              } else if (state is ArisanSelesaiDetailLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanSelesaiDetailError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, ArisanSelesaiDetailModel model) {
    final TextEditingController _statusController = TextEditingController();
    clearTextInput() {
      _statusController.clear();
    }

    List<int> a = List<int>();
    for (int i = 0; i < model.arisan.statusarisan.length; i++)
      a.add(model.arisan.statusarisan[i].total);
    int counter = 0;
    for (int i = 0; i < model.arisan.statusarisan.length; i++) counter += a[i];
    print(a);
    print("The total is $counter");

    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Container(
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
            padding: EdgeInsets.all(5),
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
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: Text('Username',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: Text('Tanggal Dapat',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  alignment: Alignment.center,
                  child: Text('Operation',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.arisan.statusarisan.length,
              itemBuilder: (context, index) {
                print(model.arisan.statusarisan[1].statuskepemilikan.username);
                print(model.arisan.statusarisan.length);
                return Container(
                  child: GestureDetector(
                    child: ListTile(
                      title: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(5),
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
                                      model.arisan.statusarisan[index].paketslot
                                          .slotNomor
                                          .toString(),
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.11,
                              child: (model.arisan.statusarisan[index].paketslot
                                              .slotNomor ==
                                          1 ||
                                      model.arisan.statusarisan[index]
                                              .statuskepemilikan.username ==
                                          null)
                                  ? Text("Money Kingdom",
                                      style:
                                          Theme.of(context).textTheme.headline6)
                                  : Text(
                                      model.arisan.statusarisan[index]
                                          .statuskepemilikan.username,
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
                                  model.arisan.statusarisan[index].tanggalDapat
                                      .toString(),
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.08,
                              alignment: Alignment.center,
                              child: FlatButton(
                                minWidth: 60,
                                height: 25,
                                shape: StadiumBorder(),
                                color: Colors.lightBlue[800],
                                child: Text(
                                  'Detail',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                onPressed: () async {
                                  String id = model
                                      .arisan.statusarisan[index].id
                                      .toString();
                                  print(id);

                                  String slotNo = model.arisan
                                      .statusarisan[index].paketslot.slotNomor
                                      .toString();
                                  String username = model
                                      .arisan
                                      .statusarisan[index]
                                      .statuskepemilikan
                                      .username;

                                  showModalBottomSheet<void>(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.92,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: new BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(10.0),
                                            topRight:
                                                const Radius.circular(10.0),
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
                                                    margin: EdgeInsets.only(
                                                        top: 5, left: 10),
                                                    child: Text(
                                                      'List Detail Slot Nomor : ' +
                                                          slotNo +
                                                          " Username : " +
                                                          username,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              Colors.black87),
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
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Close",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.79,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.95,
                                                child:
                                                    PesertaArisanSelesaiListUI(
                                                        model.arisan
                                                                .statusarisan[
                                                            index]),
                                                //     ArisanSelesaiDetail(model.arisan[index]),
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              alignment: Alignment.center,
                              child:
                                  FotoMenang(model.arisan.statusarisan[index]),
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
          SizedBox(
            height: 2,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
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
                  child: Text('Total : ',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    child: Text(formatCurrency.format(counter),
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
