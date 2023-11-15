import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class GetTanggal extends StatefulWidget {
  @override
  _GetTanggalState createState() => _GetTanggalState();
}

class _GetTanggalState extends State<GetTanggal> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        storage.write(key: "tgl_mulai", value: formattedDate);
      });
      return selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd-MM-yyyy – kk:mm').format(selectedDate);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        (selectedDate != DateTime.now())
            ? Text(
                "$formattedDate".split(' ')[0],
                style: Theme.of(context).textTheme.headline6,
              )
            : Text(
                "Pilih Tanggal Dahulu",
                style: Theme.of(context).textTheme.headline6,
              ),
        FlatButton(
          height: 25,
          minWidth: 120,
          shape: StadiumBorder(),
          onPressed: () => _selectDate(context), // Refer step 3
          child: Text(
            'Pilih Tanggal Mulai',
            style: Theme.of(context).textTheme.headline5,
          ),
          color: Colors.pink[800],
        ),
      ],
    );
  }
}
