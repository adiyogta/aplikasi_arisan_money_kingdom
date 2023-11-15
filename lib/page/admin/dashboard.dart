import 'package:aplikasi_arisan/login.dart';
import 'package:aplikasi_arisan/page/blocs/arisan_berjalan/arisan_berjalan_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/arisan_ditawarkan/arisan_ditawarkan_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/arisan_menang/arisan_menang_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/arisan_selesai/arisan_selesai_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/bank/bank_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/lelang/lelang_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/o_admin/admin_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/paket/paket_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/peserta/peserta_bloc.dart';
import 'package:aplikasi_arisan/page/blocs/poster/poster_bloc.dart';
import 'package:aplikasi_arisan/page/model/admin_me_model.dart';
import 'package:aplikasi_arisan/page/model/arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/model/arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/page/model/arisan_menang.dart';
import 'package:aplikasi_arisan/page/model/arisan_selesai.dart';
import 'package:aplikasi_arisan/page/model/bank_model.dart';
import 'package:aplikasi_arisan/page/model/paket_model.dart';
import 'package:aplikasi_arisan/page/model/peserta_model.dart';
import 'package:aplikasi_arisan/page/model/poster_model.dart';
import 'package:aplikasi_arisan/page/ui/arisan_menang.dart';
import 'package:aplikasi_arisan/page/ui/component/header.dart';
import 'package:aplikasi_arisan/resources/admin_me_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

const SERVER_IP = 'https://api.moneykingdom.org/api';
final storage = FlutterSecureStorage();
Client client = Client();

class DashboardAdmin extends StatefulWidget {
  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  final ArisanDitawarkanBloc _arisanDitawarkanBloc = ArisanDitawarkanBloc();
  final ArisanBerjalanBloc _arisanBerjalanBloc = ArisanBerjalanBloc();
  final PesertaBloc _pesertaBloc = PesertaBloc();
  final AdminBloc _adminBloc = AdminBloc();
  final PaketBloc _paketBloc = PaketBloc();
  final PosterBloc _posterBloc = PosterBloc();
  final LelangBloc _lelangBloc = LelangBloc();
  final BankBloc _bankBloc = BankBloc();
  final ArisanSelesaiBloc _arisanSelesaiBloc = ArisanSelesaiBloc();
  final ArisanMenangBloc _newsBloc = ArisanMenangBloc();
  // final PosterBloc _posterBloc = PosterBloc();

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _arisanDitawarkanBloc.add(GetArisanDitawarkanList());
      _arisanBerjalanBloc.add(GetArisanBerjalanList());
      _pesertaBloc.add(GetPesertaList());
      _paketBloc.add(GetPaketList());
      _posterBloc.add(GetPosterList());
      _lelangBloc.add(GetLelangList());
      _bankBloc.add(GetBankList());
      _arisanSelesaiBloc.add(GetArisanSelesaiList());

      _newsBloc.add(GetArisanMenangList());
    });

    return null;
  }

  @override
  void initState() {
    _arisanDitawarkanBloc.add(GetArisanDitawarkanList());
    _arisanBerjalanBloc.add(GetArisanBerjalanList());
    _pesertaBloc.add(GetPesertaList());
    _adminBloc.add(GetAdminList());
    _paketBloc.add(GetPaketList());
    _posterBloc.add(GetPosterList());
    _lelangBloc.add(GetLelangList());
    _bankBloc.add(GetBankList());
    _arisanSelesaiBloc.add(GetArisanSelesaiList());
    _newsBloc.add(GetArisanMenangList());
    super.initState();
  }

  final adminApiProvider = AdminApiProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 1,
          color: Color.fromRGBO(255, 243, 250, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(flex: 6, child: HeaderOwnerDashboard()),
                  Flexible(
                    flex: 1,
                    child: FlatButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shape: StadiumBorder(),
                      color: Colors.red[800],
                      child: Text(
                        "Logout",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      onPressed: () async {
                        Map<String, dynamic> jwt =
                            await adminApiProvider.attemptLogOut();
                        if (jwt['status_code'] == 200) {
                          print(jwt);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TabLogin()),
                              (Route<dynamic> route) => false);
                          storage.delete(key: "jwt");
                          storage.delete(key: "jwtAdmin");
                        } else {}
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              BlocProvider(
                create: (context) => _adminBloc,
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
                        return _buildAkun(context, state.paketModel);
                      } else if (state is AdminError) {
                        return _buildNull2();
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "    Overview",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          FlatButton(
                            minWidth: 100,
                            height: 30,
                            shape: StadiumBorder(),
                            color: Colors.blue[600],
                            onPressed: refreshList,
                            child: Text(
                              "Refresh Page",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.all(30),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(197, 61, 61, 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jumlah Arisan Ditawarkan : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  BlocProvider(
                                    create: (context) => _arisanDitawarkanBloc,
                                    child: BlocListener<ArisanDitawarkanBloc,
                                        ArisanDitawarkanState>(
                                      listener: (context, state) {
                                        if (state is ArisanDitawarkanError) {}
                                      },
                                      child: BlocBuilder<ArisanDitawarkanBloc,
                                          ArisanDitawarkanState>(
                                        // ignore: missing_return
                                        builder: (context, state) {
                                          if (state
                                              is ArisanDitawarkanInitial) {
                                            return _buildLoading();
                                          } else if (state
                                              is ArisanDitawarkanLoading) {
                                            return _buildLoading();
                                          } else if (state
                                              is ArisanDitawarkanLoaded) {
                                            return _buildDd(
                                                context, state.paketModel);
                                          } else if (state
                                              is ArisanDitawarkanError) {
                                            return _buildNull();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(142, 0, 191, 1),
                              ),
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(30),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jumlah Arisan Berjalan : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  BlocProvider(
                                    create: (context) => _arisanBerjalanBloc,
                                    child: BlocListener<ArisanBerjalanBloc,
                                        ArisanBerjalanState>(
                                      listener: (context, state) {
                                        if (state is ArisanBerjalanError) {}
                                      },
                                      child: BlocBuilder<ArisanBerjalanBloc,
                                          ArisanBerjalanState>(
                                        // ignore: missing_return
                                        builder: (context, state) {
                                          if (state is ArisanBerjalanInitial) {
                                            return _buildLoading();
                                          } else if (state
                                              is ArisanBerjalanLoading) {
                                            return _buildLoading();
                                          } else if (state
                                              is ArisanBerjalanLoaded) {
                                            return _buildBb(
                                                context, state.paketModel);
                                          } else if (state
                                              is ArisanBerjalanError) {
                                            return _buildNull();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.9,
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
                                                    'List Pemenang Hari Ini',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                ),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        top: 5, right: 5),
                                                    child: FlatButton(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
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
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.82,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: ArisanMenangList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(13, 126, 190, 1),
                                ),
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.all(30),
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Jumlah Pemenang Hari ini : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    BlocProvider(
                                      create: (_) => _newsBloc,
                                      child: BlocListener<ArisanMenangBloc,
                                          ArisanMenangState>(
                                        listener: (context, state) {
                                          if (state is ArisanMenangError) {}
                                        },
                                        child: BlocBuilder<ArisanMenangBloc,
                                            ArisanMenangState>(
                                          // ignore: missing_return
                                          builder: (context, state) {
                                            if (state is ArisanMenangInitial) {
                                              return _buildLoading();
                                            } else if (state
                                                is ArisanMenangLoading) {
                                              return _buildLoading();
                                            } else if (state
                                                is ArisanMenangLoaded) {
                                              return _buildAM(
                                                  context, state.paketModel);
                                            } else if (state
                                                is ArisanMenangError) {
                                              return _buildNull();
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(154, 0, 87, 1),
                              ),
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(30),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Arisan Selesai : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  BlocProvider(
                                    create: (context) => _arisanSelesaiBloc,
                                    child: BlocListener<ArisanSelesaiBloc,
                                        ArisanSelesaiState>(
                                      listener: (context, state) {
                                        if (state is ArisanSelesaiError) {}
                                      },
                                      child: BlocBuilder<ArisanSelesaiBloc,
                                          ArisanSelesaiState>(
                                        builder: (context, state) {
                                          if (state is ArisanSelesaiInitial) {
                                            return _buildLoading();
                                          } else if (state
                                              is ArisanSelesaiLoading) {
                                            return _buildLoading();
                                          } else if (state
                                              is ArisanSelesaiLoaded) {
                                            return _buildAs(
                                                context, state.paketModel);
                                          } else if (state
                                              is ArisanSelesaiError) {
                                            return _buildNull();
                                          } else {
                                            return _buildNull();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(205, 61, 99, 1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jumlah Paket : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  BlocProvider(
                                    create: (context) => _paketBloc,
                                    child: BlocListener<PaketBloc, PaketState>(
                                      listener: (context, state) {
                                        if (state is PaketError) {}
                                      },
                                      child: BlocBuilder<PaketBloc, PaketState>(
                                        // ignore: missing_return
                                        builder: (context, state) {
                                          if (state is PaketInitial) {
                                            return _buildLoading();
                                          } else if (state is PaketLoading) {
                                            return _buildLoading();
                                          } else if (state is PaketLoaded) {
                                            return _buildPaket(
                                                context, state.paketModel);
                                          } else if (state is PaketError) {
                                            return _buildNull();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(142, 113, 191, 1),
                              ),
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jumlah Poster : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  BlocProvider(
                                    create: (context) => _posterBloc,
                                    child:
                                        BlocListener<PosterBloc, PosterState>(
                                      listener: (context, state) {
                                        if (state is PosterError) {}
                                      },
                                      child:
                                          BlocBuilder<PosterBloc, PosterState>(
                                        // ignore: missing_return
                                        builder: (context, state) {
                                          if (state is PosterInitial) {
                                            return _buildLoading();
                                          } else if (state is PosterLoading) {
                                            return _buildLoading();
                                          } else if (state is PosterLoaded) {
                                            return _buildPoster(
                                                context, state.paketModel);
                                          } else if (state is PosterError) {
                                            return _buildNull();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(13, 166, 155, 1),
                              ),
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jumlah Bank : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  BlocProvider(
                                    create: (context) => _bankBloc,
                                    child: BlocListener<BankBloc, BankState>(
                                      listener: (context, state) {
                                        if (state is BankError) {}
                                      },
                                      child: BlocBuilder<BankBloc, BankState>(
                                        // ignore: missing_return
                                        builder: (context, state) {
                                          if (state is BankInitial) {
                                            return _buildLoading();
                                          } else if (state is BankLoading) {
                                            return _buildLoading();
                                          } else if (state is BankLoaded) {
                                            return _buildBank(
                                                context, state.paketModel);
                                          } else if (state is BankError) {
                                            return _buildNull();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color.fromRGBO(154, 72, 99, 1),
                              ),
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Jumlah User : ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  BlocProvider(
                                    create: (context) => _pesertaBloc,
                                    child:
                                        BlocListener<PesertaBloc, PesertaState>(
                                      listener: (context, state) {
                                        if (state is PesertaError) {}
                                      },
                                      child: BlocBuilder<PesertaBloc,
                                          PesertaState>(
                                        // ignore: missing_return
                                        builder: (context, state) {
                                          if (state is PesertaInitial) {
                                            return _buildLoading();
                                          } else if (state is PesertaLoading) {
                                            return _buildLoading();
                                          } else if (state is PesertaLoaded) {
                                            return _buildP(
                                                context, state.paketModel);
                                          } else if (state is PesertaError) {
                                            return _buildNull();
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ));

  Widget _buildDd(BuildContext context, ArisanDitawarkanList model) {
    return Text(
      model.arisan.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildBb(BuildContext context, ArisanBerjalanModel model) {
    return Text(
      model.arisan.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildAM(BuildContext context, ArisanMenangModel model) {
    return Text(
      model.arisanMenang.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildBank(BuildContext context, BankModel model) {
    return Text(
      model.bank.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildPoster(BuildContext context, PosterModel model) {
    return Text(
      model.poster.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildPaket(BuildContext context, ListPaketModel model) {
    return Text(
      model.paket.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildNull() {
    return Text(
      "0",
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildNull2() {
    return Text(
      "Eror",
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildAkun(BuildContext context, AdminModel model) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(255, 215, 239, 1),
      ),
      width: double.infinity,
      padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        'Hi, ' + model.admin.nama,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget _buildP(BuildContext context, PesertaModel pesertaModel) {
    return Text(
      pesertaModel.peserta.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }

  Widget _buildAs(BuildContext context, ArisanSelesaiModel pesertaModel) {
    return Text(
      pesertaModel.arisan.length.toString(),
      style: Theme.of(context).textTheme.subtitle1,
    );
  }
}
