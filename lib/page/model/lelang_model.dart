class LelangModel {
  List<Lelang1> lelang;
  String error;
  LelangModel({this.lelang});

  LelangModel.fromJson(Map<String, dynamic> json) {
    if (json['lelang'] != null) {
      lelang = new List<Lelang1>();
      json['lelang'].forEach((v) {
        lelang.add(new Lelang1.fromJson(v));
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

  LelangModel.withError(String errorMessage) {
    if (this.lelang == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Lelang1 {
  int id;
  String username;
  String nama;
  int slotNomor;
  String statusPengajuan;

  Lelang1(
      {this.id,
      this.username,
      this.nama,
      this.slotNomor,
      this.statusPengajuan});

  Lelang1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nama = json['nama'];
    slotNomor = json['slot_nomor'];
    statusPengajuan = json['status_pengajuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nama'] = this.nama;
    data['slot_nomor'] = this.slotNomor;
    data['status_pengajuan'] = this.statusPengajuan;
    return data;
  }
}
