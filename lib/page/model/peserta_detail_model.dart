class DetailPesertaModel {
  Peserta peserta;
  String error;

  DetailPesertaModel({this.peserta});

  DetailPesertaModel.fromJson(Map<String, dynamic> json) {
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

  DetailPesertaModel.withError(String errorMessage) {
    if (this.peserta == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Peserta {
  int id;
  String namaLengkap;
  String tempatLahir;
  String tanggalLahir;
  String email;
  String username;
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
  String namaPemilikRekening;
  String nomorRekening;
  String fotoBukuRekening;
  String fotoProfil;
  int status;
  int aggrement;
  String rank;
  String createdAt;
  String updatedAt;
  Bank bank;
  List<Sosialmedia> sosialmedia;
  Penjamin penjamin;
  List<Stakeholder> stakeholder;

  Peserta(
      {this.id,
      this.namaLengkap,
      this.tempatLahir,
      this.tanggalLahir,
      this.email,
      this.username,
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
      this.namaPemilikRekening,
      this.nomorRekening,
      this.fotoBukuRekening,
      this.fotoProfil,
      this.status,
      this.aggrement,
      this.rank,
      this.createdAt,
      this.updatedAt,
      this.bank,
      this.sosialmedia,
      this.penjamin,
      this.stakeholder});

  Peserta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaLengkap = json['nama_lengkap'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    email = json['email'];
    username = json['username'];
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
    namaPemilikRekening = json['nama_pemilik_rekening'];
    nomorRekening = json['nomor_rekening'];
    fotoBukuRekening = json['foto_buku_rekening'];
    fotoProfil = json['foto_profil'];
    status = json['status'];
    aggrement = json['aggrement'];
    rank = json['rank'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    bank = json['bank'] != null ? new Bank.fromJson(json['bank']) : null;
    if (json['sosialmedia'] != null) {
      sosialmedia = new List<Sosialmedia>();
      json['sosialmedia'].forEach((v) {
        sosialmedia.add(new Sosialmedia.fromJson(v));
      });
    }
    penjamin = json['penjamin'] != null
        ? new Penjamin.fromJson(json['penjamin'])
        : null;
    if (json['stakeholder'] != null) {
      stakeholder = new List<Stakeholder>();
      json['stakeholder'].forEach((v) {
        stakeholder.add(new Stakeholder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_lengkap'] = this.namaLengkap;
    data['tempat_lahir'] = this.tempatLahir;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['email'] = this.email;
    data['username'] = this.username;
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
    data['nama_pemilik_rekening'] = this.namaPemilikRekening;
    data['nomor_rekening'] = this.nomorRekening;
    data['foto_buku_rekening'] = this.fotoBukuRekening;
    data['foto_profil'] = this.fotoProfil;
    data['status'] = this.status;
    data['aggrement'] = this.aggrement;
    data['rank'] = this.rank;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.bank != null) {
      data['bank'] = this.bank.toJson();
    }
    if (this.sosialmedia != null) {
      data['sosialmedia'] = this.sosialmedia.map((v) => v.toJson()).toList();
    }
    if (this.penjamin != null) {
      data['penjamin'] = this.penjamin.toJson();
    }
    if (this.stakeholder != null) {
      data['stakeholder'] = this.stakeholder.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bank {
  int id;
  String nama;
  String createdAt;
  String updatedAt;

  Bank({this.id, this.nama, this.createdAt, this.updatedAt});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Sosialmedia {
  int id;
  String nama;
  String createdAt;
  String updatedAt;
  Pivot pivot;

  Sosialmedia({this.id, this.nama, this.createdAt, this.updatedAt, this.pivot});

  Sosialmedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int pesertaId;
  int sosialMediaId;
  String nama;
  String screenshot;
  String createdAt;
  String updatedAt;

  Pivot(
      {this.pesertaId,
      this.sosialMediaId,
      this.nama,
      this.screenshot,
      this.createdAt,
      this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    pesertaId = json['peserta_id'];
    sosialMediaId = json['sosial_media_id'];
    nama = json['nama'];
    screenshot = json['screenshot'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['peserta_id'] = this.pesertaId;
    data['sosial_media_id'] = this.sosialMediaId;
    data['nama'] = this.nama;
    data['screenshot'] = this.screenshot;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Penjamin {
  int id;
  int pesertaId;
  int stakeholderId;
  String nama;
  String nomorKtp;
  String alamatKtp;
  String alamatDomisili;
  String noHp;
  String createdAt;
  String updatedAt;

  Penjamin(
      {this.id,
      this.pesertaId,
      this.stakeholderId,
      this.nama,
      this.nomorKtp,
      this.alamatKtp,
      this.alamatDomisili,
      this.noHp,
      this.createdAt,
      this.updatedAt});

  Penjamin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pesertaId = json['peserta_id'];
    stakeholderId = json['stakeholder_id'];
    nama = json['nama'];
    nomorKtp = json['nomor_ktp'];
    alamatKtp = json['alamat_ktp'];
    alamatDomisili = json['alamat_domisili'];
    noHp = json['no_hp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['peserta_id'] = this.pesertaId;
    data['stakeholder_id'] = this.stakeholderId;
    data['nama'] = this.nama;
    data['nomor_ktp'] = this.nomorKtp;
    data['alamat_ktp'] = this.alamatKtp;
    data['alamat_domisili'] = this.alamatDomisili;
    data['no_hp'] = this.noHp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Stakeholder {
  int id;
  String nama;
  String createdAt;
  String updatedAt;
  Pivot2 pivot2;

  Stakeholder(
      {this.id, this.nama, this.createdAt, this.updatedAt, this.pivot2});

  Stakeholder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot2 = json['pivot'] != null ? new Pivot2.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot2 != null) {
      data['pivot'] = this.pivot2.toJson();
    }
    return data;
  }
}

class Pivot2 {
  int pesertaId;
  int stakeholderId;
  String nama;
  String noHp;
  String createdAt;
  String updatedAt;

  Pivot2(
      {this.pesertaId,
      this.stakeholderId,
      this.nama,
      this.noHp,
      this.createdAt,
      this.updatedAt});

  Pivot2.fromJson(Map<String, dynamic> json) {
    pesertaId = json['peserta_id'];
    stakeholderId = json['stakeholder_id'];
    nama = json['nama'];
    noHp = json['no_hp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['peserta_id'] = this.pesertaId;
    data['stakeholder_id'] = this.stakeholderId;
    data['nama'] = this.nama;
    data['no_hp'] = this.noHp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
