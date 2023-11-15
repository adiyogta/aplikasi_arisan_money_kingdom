class ArisanDitawarkanList {
  List<Arisan> arisan;
  String error;

  ArisanDitawarkanList({this.arisan});

  ArisanDitawarkanList.fromJson(Map<String, dynamic> json) {
    if (json['arisan'] != null) {
      arisan = new List<Arisan>();
      json['arisan'].forEach((v) {
        arisan.add(new Arisan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arisan != null) {
      data['arisan'] = this.arisan.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ArisanDitawarkanList.withError(String errorMessage) {
    if (this.arisan == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Arisan {
  int id;
  String nama;
  int slot;
  int jumlahPeriodeBayar;
  int nominal;

  Arisan(
      {this.id, this.nama, this.slot, this.jumlahPeriodeBayar, this.nominal});

  Arisan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    slot = json['slot'];
    jumlahPeriodeBayar = json['jumlah_periode_bayar'];
    nominal = json['nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['slot'] = this.slot;
    data['jumlah_periode_bayar'] = this.jumlahPeriodeBayar;
    data['nominal'] = this.nominal;
    return data;
  }
}
