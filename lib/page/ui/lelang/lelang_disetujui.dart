import 'package:aplikasi_arisan/page/blocs/lelang_disetujui/lelang_disetujui_bloc.dart';
import 'package:aplikasi_arisan/page/model/lelang_disetujui.dart';
import 'package:aplikasi_arisan/page/ui/lelang/set_username_baru.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class LelangDisetujui extends StatefulWidget {
  @override
  _LelangDisetujuiState createState() => _LelangDisetujuiState();
}

class _LelangDisetujuiState extends State<LelangDisetujui> {
  final LelangDisetujuiBloc _newsBloc = LelangDisetujuiBloc();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetLelangDisetujuiList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetLelangDisetujuiList());
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
        child: BlocListener<LelangDisetujuiBloc, LelangDisetujuiState>(
          listener: (context, state) {
            if (state is LelangDisetujuiError) {}
          },
          child: BlocBuilder<LelangDisetujuiBloc, LelangDisetujuiState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is LelangDisetujuiInitial) {
                return _buildLoading();
              } else if (state is LelangDisetujuiLoading) {
                return _buildLoading();
              } else if (state is LelangDisetujuiLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is LelangDisetujuiError) {
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
                        size: 35,
                      ),
                      SizedBox(
                        height: 2,
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

  Widget _buildCard(BuildContext context, LelangDisetujuiModel model) {
    return Scaffold(
      body: Container(
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
              padding: EdgeInsets.all(10),
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
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text('Username',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: 7,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    child: Text('Nama Arisan',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.11,
                    child: Text('Status Pengajuan',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.13,
                    alignment: Alignment.center,
                    child: Text('Operation',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.lelang.length,
                itemBuilder: (context, index) {
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
                                width: MediaQuery.of(context).size.width * 0.06,
                                alignment: Alignment.center,
                                child: Text(
                                    model.lelang[index].slotNomor.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(model.lelang[index].username,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.08,
                                child: Text(model.lelang[index].nama,
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.11,
                                child: Text(
                                    model.lelang[index].statusPengajuan
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.13,
                                alignment: Alignment.center,
                                child: FlatButton(
                                  height: 25,
                                  shape: StadiumBorder(),
                                  color: Colors.blue[900],
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        backgroundColor: Colors.lightBlue[800],
                                        content:
                                            SetUsername(model.lelang[index]),
                                      ),
                                    ).then((value) => refreshList());
                                  },
                                  child: Text('Ubah Username',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
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
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
