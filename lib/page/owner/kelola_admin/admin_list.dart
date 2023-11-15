import 'package:aplikasi_arisan/page/blocs/admin/admin_bloc.dart';
import 'package:aplikasi_arisan/page/model/admin_model.dart';
import 'package:aplikasi_arisan/page/owner/kelola_admin/edit_pass.dart';
import 'package:aplikasi_arisan/page/owner/kelola_admin/register_admin.dart';
import 'package:aplikasi_arisan/resources/admin_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class AdminList extends StatefulWidget {
  @override
  _AdminListState createState() => _AdminListState();
}

class _AdminListState extends State<AdminList> {
  final AdminBloc _newsBloc = AdminBloc();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _newsBloc.add(GetAdminList());
    });

    return null;
  }

  @override
  void initState() {
    _newsBloc.add(GetAdminList());
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
      floatingActionButton: FlatButton(
          minWidth: 155,
          shape: StadiumBorder(),
          color: Colors.pink[800],
          onPressed: () {
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
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 2, left: 10),
                              child: Text(
                                'Buat Akun Admin',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black87),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 2, right: 5),
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Close",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff999999),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.72,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: CreateAdmin(),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).then((value) => refreshList());
          },
          child: Text(
            'Buat Akun Admin Baru',
            style: Theme.of(context).textTheme.headline5,
          )),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is AdminError) {}
          },
          child: BlocBuilder<AdminBloc, AdminState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is AdminInitial) {
                return _buildLoading();
              } else if (state is AdminLoading) {
                return _buildLoading();
              } else if (state is AdminLoaded) {
                return RefreshIndicator(
                    onRefresh: refreshList,
                    key: refreshKey,
                    child: _buildCard(context, state.adminModel));
              } else if (state is AdminError) {
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

  Widget _buildCard(BuildContext context, ListAdminModel model) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.07,
                  child: Text('ID Admin',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text('Nama Admin',
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text("Username Admin",
                      style: Theme.of(context).textTheme.headline6),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  alignment: Alignment.center,
                  child: Text("Operation",
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.admin.length,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    child: ListTile(
                      selectedTileColor: Color.fromRGBO(255, 243, 250, 1),
                      focusColor: Color.fromRGBO(255, 243, 250, 1),
                      contentPadding: EdgeInsets.only(top: 0),
                      title: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.07,
                                child: Text(model.admin[index].id.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline6)),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Text(model.admin[index].nama,
                                    style:
                                        Theme.of(context).textTheme.headline6)),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Text(model.admin[index].username,
                                    style:
                                        Theme.of(context).textTheme.headline6)),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.12,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.create_sharp,
                                      size: 15,
                                    ),
                                    color: Colors.lightBlue[800],
                                    onPressed: () {
                                      showDialog(
                                        useSafeArea: true,
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Colors.pink[800],
                                          content: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Text(
                                                  'Reset Passowrd',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                ),
                                                EditPass(),
                                                FlatButton(
                                                  height: 30,
                                                  shape: StadiumBorder(),
                                                  color: Colors.lightBlue[800],
                                                  onPressed: () async {
                                                    final adApiProvider =
                                                        AdminApiProvider();
                                                    String value =
                                                        await storage.read(
                                                            key:
                                                                'password_baru');

                                                    var id = model
                                                        .admin[index].id
                                                        .toString();
                                                    var password = value;
                                                    Map<String, dynamic> jwt =
                                                        await adApiProvider
                                                            .updateAdmin(
                                                      id,
                                                      password,
                                                    );
                                                    if (jwt['status_code'] ==
                                                        200) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          backgroundColor:
                                                              Colors.lightGreen[
                                                                  800],
                                                          title: Center(
                                                            child: Text(
                                                              'Password Sudah Diubah',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          backgroundColor:
                                                              Colors.red[800],
                                                          title: Center(
                                                            child: Text(
                                                              'Gagal Ubah Password',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5,
                                                            ),
                                                          ),
                                                          content: Text(
                                                            jwt.toString(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Text("Ganti Password",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ).then((value) => refreshList());
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 15,
                                      color: Colors.red[900],
                                    ),
                                    color: Colors.lightBlue[800],
                                    onPressed: () async {
                                      final adApiProvider = AdminApiProvider();

                                      var id = model.admin[index].id.toString();

                                      Map<String, dynamic> jwt =
                                          await adApiProvider.hapusAdmin(
                                        id,
                                      );
                                      if (jwt['status_code'] == 200) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor:
                                                Colors.lightGreen[800],
                                            title: Center(
                                              child: Text(
                                                'Akun Sudah Dihapus',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ),
                                          ),
                                        ).then((value) => refreshList());
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            backgroundColor: Colors.red[800],
                                            title: Center(
                                              child: Text(
                                                'Gagal Hapus Password',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5,
                                              ),
                                            ),
                                            content: Text(
                                              jwt.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5,
                                            ),
                                          ),
                                        );
                                      }
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
