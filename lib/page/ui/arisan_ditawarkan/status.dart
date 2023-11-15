import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class StatusSlot extends StatefulWidget {
  @override
  _StatusSlotState createState() => _StatusSlotState();
}

class _StatusSlotState extends State<StatusSlot> {
  // ignore: non_constant_identifier_names
  String jangkaHari_;
  List jangkaHari = [
    'menunggu',
    'ditolak',
    'disetujui',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton(
            focusColor: Color.fromRGBO(154, 0, 87, 1),
            hint: Text("Ganti Status",
                style: Theme.of(context).textTheme.headline6),
            value: jangkaHari_,
            isExpanded: true,
            items: jangkaHari.map((item) {
              return DropdownMenuItem(
                child: Text(item.toString(),
                    style: Theme.of(context).textTheme.headline6),
                value: item,
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                jangkaHari_ = value;
                String a = jangkaHari_;
                storage.write(key: "status_slot", value: a);
              });
            },
          ),
        ],
      ),
    );
  }
}
