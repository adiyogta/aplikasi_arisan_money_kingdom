import 'package:aplikasi_arisan/page/blocs/peserta_search/peserta_search_bloc.dart';
import 'package:aplikasi_arisan/page/model/search_peserta.dart';
import 'package:aplikasi_arisan/page/ui/peserta/peserta_bloc_list_search.dart';
import 'package:aplikasi_arisan/resources/peserta_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class PesertaSearchListUI extends StatefulWidget {
  @override
  _PesertaSearchListUIState createState() => _PesertaSearchListUIState();
}

class _PesertaSearchListUIState extends State<PesertaSearchListUI> {
  final PesertaSearchBloc _newsBloc = PesertaSearchBloc();
  final pesertaApiProvider = PesertaApiProvider();

  @override
  void initState() {
    _newsBloc.add(GetPesertaSearchList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<PesertaSearchBloc, PesertaSearchState>(
          listener: (context, state) {
            if (state is PesertaSearchError) {}
          },
          child: BlocBuilder<PesertaSearchBloc, PesertaSearchState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is PesertaSearchInitial) {
                return _buildLoading();
              } else if (state is PesertaSearchLoading) {
                return _buildLoading();
              } else if (state is PesertaSearchLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is PesertaSearchError) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
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

  Widget _buildCard(BuildContext context, SearchPesertaModel model) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: MediaQuery.of(context).size.width * 1,
        child: PesertaFinalListSearch(model.peserta));
  }

  Widget _buildLoading() => Container(
      height: MediaQuery.of(context).size.height * 0.93,
      child: Center(child: CircularProgressIndicator()));
}
