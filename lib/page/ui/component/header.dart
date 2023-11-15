import 'package:flutter/material.dart';
import 'package:format_indonesia/format_indonesia.dart';

class HeaderOwnerDashboard extends StatefulWidget {
  @override
  _HeaderOwnerDashboardState createState() => _HeaderOwnerDashboardState();
}

class _HeaderOwnerDashboardState extends State<HeaderOwnerDashboard> {
  var waktu = Waktu();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(Waktu().yMMMMEEEEd(),
                  style: Theme.of(context).textTheme.headline4),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderPaket extends StatefulWidget {
  @override
  _HeaderPaketState createState() => _HeaderPaketState();
}

class _HeaderPaketState extends State<HeaderPaket> {
  var waktu = Waktu();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'List Paket',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(Waktu().yMMMMEEEEd(),
                  style: Theme.of(context).textTheme.headline4),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderArisanDitawarkan extends StatefulWidget {
  @override
  _HeaderArisanDitawarkanState createState() => _HeaderArisanDitawarkanState();
}

class _HeaderArisanDitawarkanState extends State<HeaderArisanDitawarkan> {
  var waktu = Waktu();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Arisan Ditawarkan',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(Waktu().yMMMMEEEEd(),
                  style: Theme.of(context).textTheme.headline4),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderArisanBerjalan extends StatefulWidget {
  @override
  _HeaderArisanBerjalanState createState() => _HeaderArisanBerjalanState();
}

class _HeaderArisanBerjalanState extends State<HeaderArisanBerjalan> {
  var waktu = Waktu();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Arisan Berjalan',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(Waktu().yMMMMEEEEd(),
                  style: Theme.of(context).textTheme.headline4),
            ],
          ),
        ],
      ),
    );
  }
}
