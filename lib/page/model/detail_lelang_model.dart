class DetailLelangModel {
  List<Lelang> lelang;
  String error;

  DetailLelangModel({this.lelang});

  DetailLelangModel.fromJson(Map<String, dynamic> json) {
    if (json['lelang'] != null) {
      lelang = new List<Lelang>();
      json['lelang'].forEach((v) {
        lelang.add(new Lelang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lelang != null) {
      data['lelang'] = this.lelang.map((v) => v.toJson()).toList();
    }
    return data;
  }

  DetailLelangModel.withError(String errorMessage) {
    if (this.lelang == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Lelang {
  int id;
  String username;
  String nama;
  int slotNomor;
  int pasok;
  String tanggalDapat;
  String alasan;

  Lelang(
      {this.id,
      this.username,
      this.nama,
      this.slotNomor,
      this.pasok,
      this.tanggalDapat,
      this.alasan});

  Lelang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nama = json['nama'];
    slotNomor = json['slot_nomor'];
    pasok = json['pasok'];
    tanggalDapat = json['tanggal_dapat'];
    alasan = json['alasan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nama'] = this.nama;
    data['slot_nomor'] = this.slotNomor;
    data['pasok'] = this.pasok;
    data['tanggal_dapat'] = this.tanggalDapat;
    data['alasan'] = this.alasan;
    return data;
  }
}
