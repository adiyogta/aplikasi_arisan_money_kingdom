import 'package:aplikasi_arisan/page/blocs/arisan_berjalan_search/arisan_berjalan_bloc.dart';
import 'package:aplikasi_arisan/page/model/search_arisan_berjalan.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/arisan_berjalan_detail.dart';
import 'package:aplikasi_arisan/resources/arisan_berjalan_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class SearchArisanBerjalanListUI extends StatefulWidget {
  @override
  _SearchArisanBerjalanListUIState createState() =>
      _SearchArisanBerjalanListUIState();
}

class _SearchArisanBerjalanListUIState
    extends State<SearchArisanBerjalanListUI> {
  final ArisanBerjalanSearchBloc _newsBloc = ArisanBerjalanSearchBloc();
  final arisanBerjalanApiProvider = ArisanBerjalanApiProvider();

  @override
  void initState() {
    _newsBloc.add(GetArisanBerjalanSearchList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 243, 250, 1),
        ),
        child: _buildListCovid());
  }

  Widget _buildListCovid() {
    return Container(
      child: BlocProvider(
        create: (_) => _newsBloc,
        child:
            BlocListener<ArisanBerjalanSearchBloc, ArisanBerjalanSearchState>(
          listener: (context, state) {
            if (state is ArisanBerjalanSearchError) {}
          },
          child:
              BlocBuilder<ArisanBerjalanSearchBloc, ArisanBerjalanSearchState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanBerjalanSearchInitial) {
                return _buildLoading();
              } else if (state is ArisanBerjalanSearchLoading) {
                return _buildLoading();
              } else if (state is ArisanBerjalanSearchLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanBerjalanSearchError) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.signal_cellular_no_sim_outlined,
                      size: 45,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, SearchArisanBerjalanModel model) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                  child: Text("Id Bank",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text('Nama Bank',
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.arisanBerjalan.length,
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
                                child: Text(
                                    "# " +
                                        model.arisanBerjalan[index].id
                                            .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: Text(
                                model.arisanBerjalan[index].nama,
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
