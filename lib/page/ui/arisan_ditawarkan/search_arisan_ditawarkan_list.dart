import 'package:aplikasi_arisan/page/blocs/arisan_ditawarkan_search/arisan_ditawarkan_search_bloc.dart';
import 'package:aplikasi_arisan/page/model/search_arisan_ditawarkan.dart';
import 'package:aplikasi_arisan/resources/arisan_ditawarkan_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class SearchArisanDitawarkanListUI extends StatefulWidget {
  @override
  _SearchArisanDitawarkanListUIState createState() =>
      _SearchArisanDitawarkanListUIState();
}

class _SearchArisanDitawarkanListUIState
    extends State<SearchArisanDitawarkanListUI> {
  final ArisanDitawarkanSearchBloc _newsBloc = ArisanDitawarkanSearchBloc();
  final arisanDitawarkanApiProvider = ArisanDitawarkanApiProvider();

  @override
  void initState() {
    _newsBloc.add(GetArisanDitawarkanSearchList());
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
        child: BlocListener<ArisanDitawarkanSearchBloc,
            ArisanDitawarkanSearchState>(
          listener: (context, state) {
            if (state is ArisanDitawarkanSearchError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ArisanDitawarkanSearchBloc,
              ArisanDitawarkanSearchState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is ArisanDitawarkanSearchInitial) {
                return _buildLoading();
              } else if (state is ArisanDitawarkanSearchLoading) {
                return _buildLoading();
              } else if (state is ArisanDitawarkanSearchLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is ArisanDitawarkanSearchError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, SearchArisanDitawarkanModel model) {
    // ignore: unused_local_variable
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Container(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(7.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 0.5),
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              itemCount: model.arisanDitawarkan.length,
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(model.arisanDitawarkan[index].nama,
                                style: Theme.of(context).textTheme.headline5),
                          ],
                        ),
                      ),
                      onTap: () async {
                        String id = model.arisanDitawarkan[index].id.toString();
                        storage.write(key: "id_arisanDitawarkan", value: id);
                        String namaArisan = model.arisanDitawarkan[index].nama;
                        // String slotArisan = model.arisan[index].slot.toString();
                        // String jangkaArisan =
                        //     model.arisan[index].jumlahPeriodeBayar.toString();
                        // String nominalArisan =
                        //     formatCurrency.format(model.arisan[index].nominal);

                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.9,
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
                                              EdgeInsets.only(top: 5, left: 10),
                                          child: Text(
                                            'List Detail ' + namaArisan,
                                            // ' | ' +
                                            // slotArisan +
                                            // ' Slot | ' +
                                            // jangkaArisan +
                                            // ' Hari | ' +
                                            // nominalArisan,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.black87),
                                          ),
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 5, right: 5),
                                            child: FlatButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 0, 5, 0),
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
                                          MediaQuery.of(context).size.height *
                                              0.82,
                                      width: MediaQuery.of(context).size.width *
                                          0.85,
                                      // child: ArisanDitawarkanDetail(),
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
