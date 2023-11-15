import 'package:aplikasi_arisan/page/blocs/paket/paket_bloc.dart';
import 'package:aplikasi_arisan/page/model/paket_model.dart';
import 'package:aplikasi_arisan/resources/arisan_ditawarkan_api.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class BuatArisan extends StatefulWidget {
  const BuatArisan({
    Key key,
  }) : super(key: key);

  @override
  _BuatArisanState createState() => _BuatArisanState();
}

class _BuatArisanState extends State<BuatArisan> {
  final TextEditingController _namaArisanController = TextEditingController();
  final TextEditingController _paketArisanController = TextEditingController();

  final arisanApiProvider = ArisanDitawarkanApiProvider();

  bool _namaArisanControllerValidate = false;

  bool validateNamaPaket(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        _namaArisanControllerValidate = true;
      });
      return false;
    }
    setState(() {
      _namaArisanControllerValidate = false;
    });
    return true;
  }

  clearTextInput() {
    _namaArisanController.clear();
    _paketArisanController.clear();
  }

  int _idPaket;

  final PaketBloc _newsBloc = PaketBloc();

  @override
  void initState() {
    _newsBloc.add(GetPaketList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.885,
      height: MediaQuery.of(context).size.height * 1,
      color: Color.fromRGBO(255, 243, 250, 1),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Buat Arisan",
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.40,
              constraints: BoxConstraints(maxWidth: 615),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(241, 165, 211, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                margin: const EdgeInsets.all(35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        maxLength: 35,
                        style: Theme.of(context).textTheme.headline6,
                        controller: _namaArisanController,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(154, 0, 87, 1),
                            ),
                          ),
                          labelText: 'Nama Arisan',
                          errorText: _namaArisanControllerValidate
                              ? 'Tolong Isi Nama Arisan'
                              : null,
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: Color.fromRGBO(154, 0, 87, 1),
                          ),
                        ),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => _newsBloc,
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
                              return _buildDd(context, state.paketModel);
                            } else if (state is PaketError) {
                              return _buildNull();
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    FlatButton(
                      color: Color.fromRGBO(234, 0, 88, 1),
                      shape: StadiumBorder(),
                      onPressed: () async {
                        validateNamaPaket(_namaArisanController.text);

                        var nama = _namaArisanController.text;
                        int paketArisan = int.parse(_idPaket.toString());
                        Map<String, dynamic> jwt =
                            await arisanApiProvider.attemptBuatArisanDitawarkan(
                          nama,
                          paketArisan,
                        );
                        if (jwt['status_code'] == 201) {
                          clearTextInput();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.green[900],
                              title: Center(
                                child: Text(
                                  'Arisan Berhasil Dibuat',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ),
                          );
                        } else if (paketArisan == null) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.red[900],
                              title: Center(
                                child: Text(
                                  'Arisan Gagal Dibuat',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              content: Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Paket Harus Diisi',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.red[900],
                              title: Center(
                                child: Text(
                                  'PaKet Gagal Dibuat',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              content: Container(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  jwt['errors']['nama'].toString(),
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Buat Arisan",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNull() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Text(
        "Tidak Ada Paket",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildDd(BuildContext context, ListPaketModel model) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton(
        hint: Text("Pilih Paket Arisan",
            style: Theme.of(context).textTheme.headline6),
        value: _idPaket,
        isExpanded: true,
        items: model.paket.map((item) {
          return DropdownMenuItem(
            child: Text(
              item.nama,
              style: Theme.of(context).textTheme.headline6,
            ),
            value: item.id,
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _idPaket = value;
          });
          // ignore: unused_element
          void setStateIfMounted(f) {
            if (mounted) setState(f);
          }
        },
      ),
    );
  }
}
