class ListPaketModel {
  List<Paket> paket;
  String error;

  ListPaketModel({this.paket});

  ListPaketModel.fromJson(Map<String, dynamic> json) {
    if (json['paket'] != null) {
      paket = new List<Paket>();
      json['paket'].forEach((v) {
        paket.add(new Paket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.paket != null) {
      data['paket'] = this.paket.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ListPaketModel.withError(String errorMessage) {
    if (this.paket == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Paket {
  int id;
  String nama;
  int nominal;
  int jumlahPeriodeBayar;
  int slot;
  int biayaAdmin;
  int biayaCancel;
  String createdAt;
  String updatedAt;
  List<Paketslot> paketslot;

  Paket(
      {this.id,
      this.nama,
      this.nominal,
      this.jumlahPeriodeBayar,
      this.slot,
      this.biayaAdmin,
      this.biayaCancel,
      this.createdAt,
      this.updatedAt,
      this.paketslot});

  Paket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    nominal = json['nominal'];
    jumlahPeriodeBayar = json['jumlah_periode_bayar'];
    slot = json['slot'];
    biayaAdmin = json['biaya_admin'];
    biayaCancel = json['biaya_cancel'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['paketslot'] != null) {
      paketslot = new List<Paketslot>();
      json['paketslot'].forEach((v) {
        paketslot.add(new Paketslot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['nominal'] = this.nominal;
    data['jumlah_periode_bayar'] = this.jumlahPeriodeBayar;
    data['slot'] = this.slot;
    data['biaya_admin'] = this.biayaAdmin;
    data['biaya_cancel'] = this.biayaCancel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.paketslot != null) {
      data['paketslot'] = this.paketslot.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Paketslot {
  int id;
  int paketId;
  int slotNomor;
  int pasok;
  String createdAt;
  String updatedAt;

  Paketslot(
      {this.id,
      this.paketId,
      this.slotNomor,
      this.pasok,
      this.createdAt,
      this.updatedAt});

  Paketslot.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paketId = json['paket_id'];
    slotNomor = json['slot_nomor'];
    pasok = json['pasok'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['paket_id'] = this.paketId;
    data['slot_nomor'] = this.slotNomor;
    data['pasok'] = this.pasok;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
