class LelangDisetujuiModel {
  List<Lelang> lelang;
  String error;

  LelangDisetujuiModel({this.lelang});

  LelangDisetujuiModel.fromJson(Map<String, dynamic> json) {
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

  LelangDisetujuiModel.withError(String errorMessage) {
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
  int statusArisanId;
  String statusPengajuan;

  Lelang(
      {this.id,
      this.username,
      this.nama,
      this.slotNomor,
      this.statusArisanId,
      this.statusPengajuan});

  Lelang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nama = json['nama'];
    slotNomor = json['slot_nomor'];
    statusArisanId = json['status_arisan_id'];
    statusPengajuan = json['status_pengajuan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nama'] = this.nama;
    data['slot_nomor'] = this.slotNomor;
    data['status_arisan_id'] = this.statusArisanId;
    data['status_pengajuan'] = this.statusPengajuan;
    return data;
  }
}
