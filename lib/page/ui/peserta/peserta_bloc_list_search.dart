import 'package:aplikasi_arisan/page/model/search_peserta.dart';
import 'package:aplikasi_arisan/page/owner/tab_page_owner.dart';
import 'package:aplikasi_arisan/page/ui/peserta/detail_peserta.dart';
import 'package:aplikasi_arisan/resources/peserta_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class PesertaFinalListSearch extends StatefulWidget {
  final List<Peserta> peserta;
  PesertaFinalListSearch(this.peserta);

  @override
  _PesertaFinalListSearchState createState() => _PesertaFinalListSearchState();
}

class _PesertaFinalListSearchState extends State<PesertaFinalListSearch> {
  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width * 0.017;
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
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
                  width: MediaQuery.of(context).size.width * 0.06,
                  child:
                      Text('ID', style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: a),
                  width: MediaQuery.of(context).size.width * 0.03,
                  alignment: Alignment.center,
                  child: Text('Foto',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.11,
                  child: Text('Username',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.18,
                  child: Text("Nama Lengkap",
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text('No HP',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.08,
                  child: Text('Status',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  alignment: Alignment.center,
                  child: Text("Operation",
                      style: Theme.of(context).textTheme.headline6),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.peserta.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: Text(
                              '# ' + widget.peserta[index].id.toString(),
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: a),
                          width: MediaQuery.of(context).size.width * 0.03,
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: 1 / 1,
                            child: new Container(
                              decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  alignment: FractionalOffset.center,
                                  image: new NetworkImage(
                                      'https://api.moneykingdom.org/public/foto-profil/' +
                                          widget.peserta[index].fotoProfil,
                                      scale: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.11,
                          child: Text(widget.peserta[index].username,
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: Text(widget.peserta[index].namaLengkap,
                                style: Theme.of(context).textTheme.headline6)),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            child: Text(widget.peserta[index].noHp,
                                style: Theme.of(context).textTheme.headline6)),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.08,
                          child: (widget.peserta[index].status == 1)
                              ? Text("Aktif",
                                  style: Theme.of(context).textTheme.headline6)
                              : Text("Tidak Aktif",
                                  style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          alignment: Alignment.center,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
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
                                              'Hapus Peserta',
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
                                                      PesertaApiProvider();
                                                  var id = widget
                                                      .peserta[index].id
                                                      .toString();
                                                  Map<String, dynamic> jwt =
                                                      await adApiProvider
                                                          .hapusPeserta(
                                                    id,
                                                  );
                                                  if (jwt['status_code'] ==
                                                      200) {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            TabPageOwner(),
                                                      ),
                                                    );
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        backgroundColor: Colors
                                                            .lightGreen[800],
                                                        title: Center(
                                                          child: Text(
                                                            'Akun Sudah Dihapus',
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
                                                            'Gagal Hapus Password',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5,
                                                          ),
                                                        ),
                                                        content: Text(
                                                          jwt.toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline5,
                                                        ),
                                                      ),
                                                    );
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
                                    }),
                                IconButton(
                                  icon: Icon(
                                    Icons.cancel,
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
                                            'Ban Akun Peserta',
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
                                                    PesertaApiProvider();
                                                var id = widget
                                                    .peserta[index].id
                                                    .toString();
                                                Map<String, dynamic> jwt =
                                                    await adApiProvider
                                                        .banPeserta(
                                                  id,
                                                );
                                                if (jwt['status_code'] == 200) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TabPageOwner(),
                                                    ),
                                                  );
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      backgroundColor: Colors
                                                          .lightGreen[800],
                                                      title: Center(
                                                        child: Text(
                                                          'Akun Sudah Diban',
                                                          style:
                                                              Theme.of(context)
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
                                                          'Gagal Ban Akun',
                                                          style:
                                                              Theme.of(context)
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
                              ]),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    String id = widget.peserta[index].id.toString();
                    storage.write(key: "id_peserta", value: id);
                    // String namapaket = model.peserta[index].nama;
                    // String slotpaket = model.peserta[index].slot;
                    // String jangkapaket =
                    //     model.peserta[index].jumlahPeriodeBayar;
                    // String nominalpaket = formatCurrency
                    //     .format(int.parse(model.peserta[index].nominal));
                    // String biayaad = formatCurrency.format(
                    //     int.parse(model.peserta[index].biayaAdmin));
                    // String biayaca = formatCurrency.format(
                    //     int.parse(model.peserta[index].biayaCancel));
                    showModalBottomSheet<void>(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.90,
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
                                      margin: EdgeInsets.only(top: 5, left: 10),
                                      child: Text(
                                        'Detail Peserta',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.only(top: 5, right: 5),
                                        child: FlatButton(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 5, 0),
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
                                SizedBox(height: 5),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.85,
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: PesertaDetail(),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
