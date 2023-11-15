import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class EditRank extends StatefulWidget {
  @override
  _EditRankState createState() => _EditRankState();
}

class _EditRankState extends State<EditRank> {
  String jangkaHari_;
  List jangkaHari = [
    'silver',
    'gold',
    'platinum',
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
            hint: Text("Ganti Rank",
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
                storage.write(key: "rank_baru", value: a);
              });
            },
          ),
        ],
      ),
    );
  }
}
