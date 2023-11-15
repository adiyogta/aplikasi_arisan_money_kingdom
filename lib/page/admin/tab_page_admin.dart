import 'package:aplikasi_arisan/page/admin/dashboard.dart';
import 'package:aplikasi_arisan/page/ui/arisan_berjalan/arisan_berjalan_list.dart';
import 'package:aplikasi_arisan/page/ui/arisan_ditawarkan/arisan_ditawarkan_list.dart';
import 'package:aplikasi_arisan/page/ui/arisan_ditawarkan/buat_arisan_ditawarkan.dart';
import 'package:aplikasi_arisan/page/ui/arisan_selesai/arisan_selesai_list.dart';
import 'package:aplikasi_arisan/page/ui/bank/bank_list.dart';
import 'package:aplikasi_arisan/page/ui/buat_paket.dart';
import 'package:aplikasi_arisan/page/ui/lelang/lelang_list.dart';
import 'package:aplikasi_arisan/page/ui/paket_list.dart';
import 'package:aplikasi_arisan/page/ui/peserta/peserta_list.dart';
import 'package:aplikasi_arisan/page/ui/poster/poster_list.dart';
import 'package:aplikasi_arisan/tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();

class TabPageAdmin extends StatefulWidget {
  @override
  _TabPageAdminState createState() => _TabPageAdminState();
}

class _TabPageAdminState extends State<TabPageAdmin> {
  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            actionsOverflowDirection: VerticalDirection.down,
            title: Center(
              child: new Text(
                'Apakah Anda Yakin Untuk Keluar Dari Aplikasi ?',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                new FlatButton(
                  shape: StadiumBorder(),
                  color: Colors.red[700],
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('No',
                      style: Theme.of(context).textTheme.headline5),
                ),
                new FlatButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: new Text('Yes',
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            ),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.white,
                    child: VerticalTabs(
                      tabs: <Tab>[
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.book,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Dashboard',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add_to_photos,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Tambah Paket',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.post_add_outlined,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Tambah Arisan',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.list_alt_rounded,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'List Paket',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.list_outlined,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Arisan Ditawarkan',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.view_list_sharp,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Arisan Berjalan',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.format_align_justify_sharp,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Arisan Selesai',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.credit_card_outlined,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Lelang',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.supervised_user_circle_sharp,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Kelola Peserta',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.event_note,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Kelola Poster',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.book_online_rounded,
                                  size: 19,
                                ),
                                SizedBox(width: 15),
                                Text(
                                  'Kelola Bank',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      contents: <Widget>[
                        DashboardAdmin(),
                        BuatPaket(),
                        BuatArisan(),
                        PaketList(),
                        ArisanDitawarkanListUI(),
                        ArisanBerjalanListUI(),
                        ArisanSelesaiListUI(),
                        LelangListUI(),
                        PesertaListUI(),
                        PosterListUI(),
                        BankList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
