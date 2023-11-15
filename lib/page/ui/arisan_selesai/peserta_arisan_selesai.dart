import 'package:aplikasi_arisan/page/model/arisan_selesai_detail.dart';
import 'package:aplikasi_arisan/page/ui/arisan_selesai/foto_bukti_bayar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

final storage = FlutterSecureStorage();

class PesertaArisanSelesaiListUI extends StatefulWidget {
  final Statusarisan statusarisan;
  PesertaArisanSelesaiListUI(this.statusarisan);

  @override
  _PesertaArisanSelesaiListUIState createState() =>
      _PesertaArisanSelesaiListUIState();
}

class _PesertaArisanSelesaiListUIState
    extends State<PesertaArisanSelesaiListUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(margin: EdgeInsets.all(8.0), child: _buildCard(context));
  }

  Widget _buildCard(
    BuildContext context,
  ) {
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
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
                  alignment: Alignment.center,
                  child: Text('Periode',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.09,
                  child: Text('Pasok',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.09,
                  alignment: Alignment.center,
                  child: Text('Status',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  alignment: Alignment.center,
                  child: Text('Operation',
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
              itemCount: widget.statusarisan.transaksi.length,
              itemBuilder: (context, index) {
                return Container(
                  child: GestureDetector(
                    child: ListTile(
                      title: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.06,
                              child: Text(
                                  '# ' +
                                      widget
                                          .statusarisan.transaksi[index].periode
                                          .toString(),
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.09,
                              child: Text(
                                  formatCurrency.format(
                                      widget.statusarisan.paketslot.pasok),
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.03,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.09,
                              child: Text(
                                  widget.statusarisan.transaksi[index].status
                                      .toString(),
                                  style: Theme.of(context).textTheme.headline6),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.13,
                              alignment: Alignment.center,
                              child: FotoBayar(
                                  widget.statusarisan.transaksi[index]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
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
                  alignment: Alignment.center,
                  child: Text('Total : ',
                      style: Theme.of(context).textTheme.headline6),
                ),
                SizedBox(
                  width: 7,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    child: Text(
                        formatCurrency.format(widget.statusarisan.total),
                        style: Theme.of(context).textTheme.headline6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
