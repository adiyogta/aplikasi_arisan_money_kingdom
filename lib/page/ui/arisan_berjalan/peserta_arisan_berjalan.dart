import 'package:aplikasi_arisan/page/blocs/peserta_arisan_berjalan/peserta_arisan_berjalan_bloc.dart';
import 'package:aplikasi_arisan/page/model/detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/model/peserta_detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/pilihPeriode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class PesertaArisanBerjalanListUI extends StatefulWidget {
  final Arisan model;
  PesertaArisanBerjalanListUI(this.model);

  @override
  _PesertaArisanBerjalanListUIState createState() =>
      _PesertaArisanBerjalanListUIState();
}

class _PesertaArisanBerjalanListUIState
    extends State<PesertaArisanBerjalanListUI> {
  final PesertaArisanBerjalanBloc _newsBloc = PesertaArisanBerjalanBloc();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetPesertaArisanBerjalanList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetPesertaArisanBerjalanList());
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
            BlocListener<PesertaArisanBerjalanBloc, PesertaArisanBerjalanState>(
          listener: (context, state) {},
          child: BlocBuilder<PesertaArisanBerjalanBloc,
              PesertaArisanBerjalanState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is PesertaArisanBerjalanInitial) {
                return _buildLoading();
              } else if (state is PesertaArisanBerjalanLoading) {
                return _buildLoading();
              } else if (state is PesertaArisanBerjalanLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is PesertaArisanBerjalanError) {
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

  Widget _buildCard(
      BuildContext context, PesertaArisanBerjalanDetailModel model) {
    return PilihPeriode(model.peserta);
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
