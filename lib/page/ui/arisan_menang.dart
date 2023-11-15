import 'package:aplikasi_arisan/page/blocs/arisan_menang/arisan_menang_bloc.dart';
import 'package:aplikasi_arisan/page/model/arisan_menang.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class ArisanMenangList extends StatefulWidget {
  @override
  _ArisanMenangListState createState() => _ArisanMenangListState();
}

class _ArisanMenangListState extends State<ArisanMenangList> {
  final ArisanMenangBloc _newsBloc = ArisanMenangBloc();

  @override
  void initState() {
    _newsBloc.add(GetArisanMenangList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: _buildListCovid()),
    );
  }

  Widget _buildListCovid() {
    return Container(
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<ArisanMenangBloc, ArisanMenangState>(
          listener: (context, state) {
            if (state is ArisanMenangError) {}
          },
          child: BlocBuilder<ArisanMenangBloc, ArisanMenangState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanMenangInitial) {
                return _buildLoading();
              } else if (state is ArisanMenangLoading) {
                return _buildLoading();
              } else if (state is ArisanMenangLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanMenangError) {
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

  Widget _buildCard(BuildContext context, ArisanMenangModel model) {
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
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  child: Text("Nama Pemenang",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text('Nama Arisan',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  alignment: Alignment.center,
                  child: Text('nominal',
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.arisanMenang.length,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    child: ListTile(
                      selectedTileColor: Color.fromRGBO(255, 243, 250, 1),
                      focusColor: Color.fromRGBO(255, 243, 250, 1),
                      contentPadding: EdgeInsets.only(top: 0),
                      title: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                child: Text(model.arisanMenang[index].username,
                                    style:
                                        Theme.of(context).textTheme.headline6)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: Text(
                                model.arisanMenang[index].nama,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: Text(
                                model.arisanMenang[index].nominal.toString(),
                                style: Theme.of(context).textTheme.headline6,
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
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
