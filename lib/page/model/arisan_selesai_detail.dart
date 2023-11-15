class ArisanSelesaiDetailModel {
  Arisan arisan;
  String error;

  ArisanSelesaiDetailModel({this.arisan});

  ArisanSelesaiDetailModel.fromJson(Map<String, dynamic> json) {
    arisan =
        json['arisan'] != null ? new Arisan.fromJson(json['arisan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arisan != null) {
      data['arisan'] = this.arisan.toJson();
    }
    return data;
  }

  ArisanSelesaiDetailModel.withError(String errorMessage) {
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
  List<Statusarisan> statusarisan;

  Arisan({this.id, this.nama, this.statusarisan});

  Arisan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    if (json['statusarisan'] != null) {
      statusarisan = new List<Statusarisan>();
      json['statusarisan'].forEach((v) {
        statusarisan.add(new Statusarisan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    if (this.statusarisan != null) {
      data['statusarisan'] = this.statusarisan.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statusarisan {
  int id;
  int arisanId;
  int paketSlotId;
  int statusArisanId;
  String statusArisanType;
  String tanggalDapat;
  String buktiTransferMenang;
  String status;
  String createdAt;
  String updatedAt;
  int total;
  Statuskepemilikan statuskepemilikan;
  Paketslot paketslot;
  List<Transaksi> transaksi;

  Statusarisan(
      {this.id,
      this.arisanId,
      this.paketSlotId,
      this.statusArisanId,
      this.statusArisanType,
      this.tanggalDapat,
      this.buktiTransferMenang,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.total,
      this.statuskepemilikan,
      this.paketslot,
      this.transaksi});

  Statusarisan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arisanId = json['arisan_id'];
    paketSlotId = json['paket_slot_id'];
    statusArisanId = json['status_arisan_id'];
    statusArisanType = json['status_arisan_type'];
    tanggalDapat = json['tanggal_dapat'];
    buktiTransferMenang = json['bukti_transfer_menang'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    total = json['total'];
    statuskepemilikan = json['statuskepemilikan'] != null
        ? new Statuskepemilikan.fromJson(json['statuskepemilikan'])
        : null;
    paketslot = json['paketslot'] != null
        ? new Paketslot.fromJson(json['paketslot'])
        : null;
    if (json['transaksi'] != null) {
      transaksi = new List<Transaksi>();
      json['transaksi'].forEach((v) {
        transaksi.add(new Transaksi.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arisan_id'] = this.arisanId;
    data['paket_slot_id'] = this.paketSlotId;
    data['status_arisan_id'] = this.statusArisanId;
    data['status_arisan_type'] = this.statusArisanType;
    data['tanggal_dapat'] = this.tanggalDapat;
    data['bukti_transfer_menang'] = this.buktiTransferMenang;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total'] = this.total;
    if (this.statuskepemilikan != null) {
      data['statuskepemilikan'] = this.statuskepemilikan.toJson();
    }
    if (this.paketslot != null) {
      data['paketslot'] = this.paketslot.toJson();
    }
    if (this.transaksi != null) {
      data['transaksi'] = this.transaksi.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statuskepemilikan {
  int id;
  String username;
  String nama;
  String createdAt;
  String updatedAt;
  String namaLengkap;
  String tempatLahir;
  String tanggalLahir;
  String email;
  String nomorKtp;
  String alamatKtp;
  String alamatDomisili;
  String fotoKtp;
  String selfieDenganKtp;
  String fotoKk;
  String fotoPengenalLainnya;
  String pekerjaan;
  String alamatPekerjaan;
  String noWhatsapp;
  String noHp;
  int bankId;
  String namaPemilikRekening;
  String nomorRekening;
  String fotoBukuRekening;
  String fotoProfil;
  int status;
  int aggrement;
  String rank;

  Statuskepemilikan(
      {this.id,
      this.username,
      this.nama,
      this.createdAt,
      this.updatedAt,
      this.namaLengkap,
      this.tempatLahir,
      this.tanggalLahir,
      this.email,
      this.nomorKtp,
      this.alamatKtp,
      this.alamatDomisili,
      this.fotoKtp,
      this.selfieDenganKtp,
      this.fotoKk,
      this.fotoPengenalLainnya,
      this.pekerjaan,
      this.alamatPekerjaan,
      this.noWhatsapp,
      this.noHp,
      this.bankId,
      this.namaPemilikRekening,
      this.nomorRekening,
      this.fotoBukuRekening,
      this.fotoProfil,
      this.status,
      this.aggrement,
      this.rank});

  Statuskepemilikan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nama = json['nama'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    namaLengkap = json['nama_lengkap'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    email = json['email'];
    nomorKtp = json['nomor_ktp'];
    alamatKtp = json['alamat_ktp'];
    alamatDomisili = json['alamat_domisili'];
    fotoKtp = json['foto_ktp'];
    selfieDenganKtp = json['selfie_dengan_ktp'];
    fotoKk = json['foto_kk'];
    fotoPengenalLainnya = json['foto_pengenal_lainnya'];
    pekerjaan = json['pekerjaan'];
    alamatPekerjaan = json['alamat_pekerjaan'];
    noWhatsapp = json['no_whatsapp'];
    noHp = json['no_hp'];
    bankId = json['bank_id'];
    namaPemilikRekening = json['nama_pemilik_rekening'];
    nomorRekening = json['nomor_rekening'];
    fotoBukuRekening = json['foto_buku_rekening'];
    fotoProfil = json['foto_profil'];
    status = json['status'];
    aggrement = json['aggrement'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nama'] = this.nama;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['nama_lengkap'] = this.namaLengkap;
    data['tempat_lahir'] = this.tempatLahir;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['email'] = this.email;
    data['nomor_ktp'] = this.nomorKtp;
    data['alamat_ktp'] = this.alamatKtp;
    data['alamat_domisili'] = this.alamatDomisili;
    data['foto_ktp'] = this.fotoKtp;
    data['selfie_dengan_ktp'] = this.selfieDenganKtp;
    data['foto_kk'] = this.fotoKk;
    data['foto_pengenal_lainnya'] = this.fotoPengenalLainnya;
    data['pekerjaan'] = this.pekerjaan;
    data['alamat_pekerjaan'] = this.alamatPekerjaan;
    data['no_whatsapp'] = this.noWhatsapp;
    data['no_hp'] = this.noHp;
    data['bank_id'] = this.bankId;
    data['nama_pemilik_rekening'] = this.namaPemilikRekening;
    data['nomor_rekening'] = this.nomorRekening;
    data['foto_buku_rekening'] = this.fotoBukuRekening;
    data['foto_profil'] = this.fotoProfil;
    data['status'] = this.status;
    data['aggrement'] = this.aggrement;
    data['rank'] = this.rank;
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

class Transaksi {
  int id;
  int statusArisanId;
  int periode;
  String buktiPembayaran;
  String status;
  String createdAt;
  String updatedAt;

  Transaksi(
      {this.id,
      this.statusArisanId,
      this.periode,
      this.buktiPembayaran,
      this.status,
      this.createdAt,
      this.updatedAt});

  Transaksi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusArisanId = json['status_arisan_id'];
    periode = json['periode'];
    buktiPembayaran = json['bukti_pembayaran'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status_arisan_id'] = this.statusArisanId;
    data['periode'] = this.periode;
    data['bukti_pembayaran'] = this.buktiPembayaran;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
