import 'package:aplikasi_arisan/login.dart';
import 'package:aplikasi_arisan/page/blocs/bank/bank_bloc.dart';
import 'package:aplikasi_arisan/page/model/bank_model.dart';
import 'package:aplikasi_arisan/page/ui/bank/action_bank.dart';
import 'package:aplikasi_arisan/resources/bank_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class BankList extends StatefulWidget {
  @override
  _BankListState createState() => _BankListState();
}

class _BankListState extends State<BankList> {
  final BankBloc _newsBloc = BankBloc();

  final TextEditingController _namaBankController = TextEditingController();

  final bankApiProvider = BankApiProvider();

  clearTextInput() {
    _namaBankController.clear();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetBankList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetBankList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FlatButton(
          height: 30,
          minWidth: 125,
          shape: StadiumBorder(),
          color: Colors.pink[800],
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: Colors.white,
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Buat Bank Baru',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          style: Theme.of(context).textTheme.headline6,
                          controller: _namaBankController,
                          maxLength: 25,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromRGBO(154, 0, 87, 1),
                              ),
                            ),
                            labelText: 'Nama Bank',
                            labelStyle: TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(154, 0, 87, 1),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        color: Colors.blue[900],
                        shape: StadiumBorder(),
                        height: 30,
                        onPressed: () async {
                          var nama = _namaBankController.text;
                          Map<String, dynamic> jwt =
                              await bankApiProvider.attemptBuatBank(nama);
                          if (jwt['status_code'] == 201) {
                            clearTextInput();
                            refreshList();
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.lightGreen[900],
                                title: Center(
                                  child: Text(
                                    'Bank Baru Berhasil Dibuat',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Colors.red[900],
                                  title: Center(
                                    child: Text(
                                      'Bank Baru Gagal Dibuat',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                  content: Text(
                                    jwt.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              );
                            });
                          }
                        },
                        child: Text(
                          "Buat Bank Baru",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          child: Text('Buat Bank Baru',
              style: Theme.of(context).textTheme.headline5)),
      body: RefreshIndicator(
        onRefresh: refreshList,
        key: refreshKey,
        child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(255, 243, 250, 1),
            ),
            child: _buildListCovid()),
      ),
    );
  }

  Widget _buildListCovid() {
    return Container(
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<BankBloc, BankState>(
          listener: (context, state) {
            if (state is BankError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Expanded(
                    child: Row(
                      children: [
                        Text(state.message),
                        Text(' / '),
                        TextButton(
                            child: Text('Login Again'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TabLogin(),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                ),
              );
            }
          },
          child: BlocBuilder<BankBloc, BankState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is BankInitial) {
                return _buildLoading();
              } else if (state is BankLoading) {
                return _buildLoading();
              } else if (state is BankLoaded) {
                return _buildCard(context, state.paketModel);
              } else if (state is BankError) {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, BankModel model) {
    // ignore: unused_local_variable
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
                  child: Text("Id Bank",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text('Nama Bank',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  alignment: Alignment.center,
                  child: Text('Operation',
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.bank.length,
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
                                    "# " + model.bank[index].id.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: Text(
                                model.bank[index].nama,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.create_sharp,
                                        size: 16,
                                        color: Colors.blue[900],
                                      ),
                                      color: Colors.lightBlue[800],
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: Colors.pink[800],
                                            content:
                                                ActionBank(model.bank[index]),
                                          ),
                                        );
                                      }),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 16,
                                      color: Colors.red[900],
                                    ),
                                    color: Colors.lightBlue[800],
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.pink[800],
                                          title: Center(
                                            child: Text(
                                              'Hapus Bank',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                          content: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FlatButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Batal',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                              FlatButton(
                                                onPressed: () async {
                                                  final adApiProvider =
                                                      BankApiProvider();
                                                  var id = model.bank[index].id
                                                      .toString();

                                                  Map<String, dynamic> jwt =
                                                      await adApiProvider
                                                          .attemptHapusBank(id);
                                                  if (jwt['status_code'] ==
                                                      200) {
                                                    Navigator.pop(context);
                                                    refreshList();
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                          'Data Bank Berhasil Dihapus',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .green[800]),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    print(jwt);
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                          'Data Bank Gagal Dihapus',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red[800]),
                                                        ),
                                                        content: Text(
                                                            jwt.toString()),
                                                      ),
                                                    );
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text(
                                                  'Ya',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
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
