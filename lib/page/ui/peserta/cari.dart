import 'package:aplikasi_arisan/page/ui/peserta/peserta_search_list.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class Cari extends StatefulWidget {
  @override
  _CariState createState() => _CariState();
}

class _CariState extends State<Cari> {
  final TextEditingController _cari = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: Theme.of(context).textTheme.headline5,
              controller: _cari,
              decoration: InputDecoration(
                labelText: 'Cari Peserta',
                labelStyle: Theme.of(context).textTheme.headline5,
                hintStyle: Theme.of(context).textTheme.headline5,
                hintText: "Cari Berdasarkan Nama dan Username",
              ),
            ),
            FlatButton(
              shape: StadiumBorder(),
              color: Colors.black54,
              child: Text(
                'Cari',
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: () async {
                String a = _cari.text;
                if (a != '' && a != null) {
                  storage.write(key: "peserta", value: a);

                  showModalBottomSheet<void>(
                    enableDrag: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.95,
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
                              SizedBox(height: 5),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 1,
                                child: PesertaSearchListUI(),
                                //     model.arisan[index])
                                //     ArisanBerjalanDetail(model.arisan[index]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
