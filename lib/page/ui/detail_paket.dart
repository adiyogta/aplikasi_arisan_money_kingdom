import 'dart:convert';
import 'package:aplikasi_arisan/page/model/paket_model.dart';
import 'package:aplikasi_arisan/resources/paket_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
  final Paket model;
  NewsDetails(this.model);
  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class PersonEntry {
  final String index;
  final String slotid;
  final String pasok;

  PersonEntry(this.index, this.slotid, this.pasok);

  PersonEntry.fromJson(Map<String, dynamic> json)
      : index = json['slot'],
        // ignore: unnecessary_brace_in_string_interps
        slotid = json['slot[slot_id]'],
        pasok = json['slot[pasok]'];

  Map<String, dynamic> toJson() => {
        'slot': index,
        'slot$index[slot_id]': slotid,
        'slot$index[pasok]': pasok,
      };

  // @override
  // String toString() {
  //   return 'slot[$index][slot_id]$slotid' + ' ' + 'slot[$index][pasok]$pasok';
  // }
}

class _NewsDetailsState extends State<NewsDetails> {
  var pasokTECs = <TextEditingController>[];
  var cards = <TextField>[];

  @override
  void initState() {
    super.initState();
    cards.add(createCard());
  }

  // ignore: missing_return
  TextField createCard() {
    var nameController = TextEditingController();
    pasokTECs.add(nameController);
    for (int i = 0; i < widget.model.paketslot.length; i++)
      return TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          // ignore: deprecated_member_use
          WhitelistingTextInputFormatter.digitsOnly
        ],
        maxLength: 9,
        style: GoogleFonts.montserrat(
          fontSize: 12.0,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        controller: nameController,
        decoration: InputDecoration(
          helperStyle: GoogleFonts.montserrat(
            fontSize: 8.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          labelText: 'Isi Pasok Baru',
          labelStyle: GoogleFonts.montserrat(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      );
  }

  final paketApiProvider = PaketApiProvider();
  _onDone() async {
    // ignore: unused_local_variable
    var json;
    List<PersonEntry> entries = [];
    for (int i = 0; i < widget.model.paketslot.length; i++) {
      var pasok = pasokTECs[i].text;
      var index = i.toString();
      var slotid = widget.model.paketslot[i].id.toString();

      entries.add(PersonEntry(index, slotid, pasok));
      PersonEntry personEntry = new PersonEntry(index, slotid, pasok);
      json = jsonEncode(personEntry.toJson());
      // print(json);
    }

    Map<String, dynamic> jwt = await paketApiProvider.updatePasok(entries);
    if (jwt['status_code'] == 200) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.green[900],
          title: Center(
            child: Text(
              'Pasok Berhasil Diubah',
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
          // ignore: unnecessary_brace_in_string_interps
          title: Center(
            child: Text(
              'Semua Slot Pasok Harus Diisi',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
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
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.06,
                    child: Text('Slot Nomor',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.13,
                    child: Text('Pasok Sebelumnya',
                        style: Theme.of(context).textTheme.headline6),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text('Update Pasok',
                        style: Theme.of(context).textTheme.headline6),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.model.paketslot.length,
                itemBuilder: (BuildContext context, int index) {
                  final formatCurrency =
                      new NumberFormat.simpleCurrency(locale: 'id_ID');
                  cards.add(createCard());
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 1),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width * 0.06,
                          child: Text(
                              widget.model.paketslot[index].slotNomor
                                  .toString(),
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.13,
                          child: Text(
                              formatCurrency
                                  .format(widget.model.paketslot[index].pasok),
                              style: Theme.of(context).textTheme.headline6),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: cards[index]),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: (widget.model.paketslot[1].pasok.toString() == '0')
          ? FlatButton(
              height: 30,
              minWidth: 120,
              shape: StadiumBorder(),
              color: Colors.blue[900],
              child: Text(
                "Ubah Pasok Paket",
                style: Theme.of(context).textTheme.headline5,
              ),
              onPressed: _onDone)
          : FlatButton(
              shape: StadiumBorder(),
              color: Colors.red[900],
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.pink[900],
                    title: Center(
                      child: Text(
                        'Pasok Sudah Diubah Sebelumnya',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Anda Yakin Ingin Mengubahnya Lagi ?',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Karena Akan Mengubah Data Lain Jika Paket Sudah Digunakan.',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FlatButton(
                              shape: StadiumBorder(),
                              color: Colors.red[900],
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Tidak",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            FlatButton(
                              shape: StadiumBorder(),
                              color: Colors.white,
                              onPressed: _onDone,
                              child: Text(
                                "Ya",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              child: Text(
                "Ubah Pasok Paket",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
    );
  }
}
