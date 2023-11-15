class PesertaArisanBerjalanDetailModel {
  Peserta peserta;
  String error;

  PesertaArisanBerjalanDetailModel({this.peserta});

  PesertaArisanBerjalanDetailModel.fromJson(Map<String, dynamic> json) {
    peserta =
        json['peserta'] != null ? new Peserta.fromJson(json['peserta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.peserta != null) {
      data['peserta'] = this.peserta.toJson();
    }
    return data;
  }

  PesertaArisanBerjalanDetailModel.withError(String errorMessage) {
    if (this.peserta == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Peserta {
  String username;
  int pasok;
  List<Transaksi> transaksi;

  Peserta({this.username, this.pasok, this.transaksi});

  Peserta.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    pasok = json['pasok'];
    if (json['transaksi'] != null) {
      transaksi = new List<Transaksi>();
      json['transaksi'].forEach((v) {
        transaksi.add(new Transaksi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['pasok'] = this.pasok;
    if (this.transaksi != null) {
      data['transaksi'] = this.transaksi.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaksi {
  int id;
  int periode;
  String buktiPembayaran;
  String status;
  String updatedAt;

  Transaksi(
      {this.id,
      this.periode,
      this.buktiPembayaran,
      this.status,
      this.updatedAt});

  Transaksi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    periode = json['periode'];
    buktiPembayaran = json['bukti_pembayaran'];
    status = json['status'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['periode'] = this.periode;
    data['bukti_pembayaran'] = this.buktiPembayaran;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
