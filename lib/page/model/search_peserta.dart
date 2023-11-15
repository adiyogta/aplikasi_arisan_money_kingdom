class SearchPesertaModel {
  List<Peserta> peserta;
  String error;
  String message;

  SearchPesertaModel({this.peserta});

  SearchPesertaModel.fromJson(Map<String, dynamic> json) {
    if (json['peserta'] != null) {
      peserta = new List<Peserta>();
      json['peserta'].forEach((v) {
        peserta.add(new Peserta.fromJson(v));
      });
    } else if (json['peserta'] == null && json['message'] != null) {
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.peserta != null) {
      data['peserta'] = this.peserta.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SearchPesertaModel.withError(String errorMessage) {
    if (this.peserta == null) {
      error = 'Data Belum Ada';
    } else if (this.peserta == null && this.message != null) {
      error = 'Data Tidak Ditemukan';
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
  String password;
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
  int bankId;
  String namaPemilikRekening;
  String nomorRekening;
  String fotoBukuRekening;
  String fotoProfil;
  int status;
  int aggrement;
  String rank;
  String createdAt;
  String updatedAt;

  Peserta(
      {this.id,
      this.namaLengkap,
      this.tempatLahir,
      this.tanggalLahir,
      this.email,
      this.password,
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
      this.bankId,
      this.namaPemilikRekening,
      this.nomorRekening,
      this.fotoBukuRekening,
      this.fotoProfil,
      this.status,
      this.aggrement,
      this.rank,
      this.createdAt,
      this.updatedAt});

  Peserta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    namaLengkap = json['nama_lengkap'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    email = json['email'];
    password = json['password'];
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
    bankId = json['bank_id'];
    namaPemilikRekening = json['nama_pemilik_rekening'];
    nomorRekening = json['nomor_rekening'];
    fotoBukuRekening = json['foto_buku_rekening'];
    fotoProfil = json['foto_profil'];
    status = json['status'];
    aggrement = json['aggrement'];
    rank = json['rank'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama_lengkap'] = this.namaLengkap;
    data['tempat_lahir'] = this.tempatLahir;
    data['tanggal_lahir'] = this.tanggalLahir;
    data['email'] = this.email;
    data['password'] = this.password;
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
    data['bank_id'] = this.bankId;
    data['nama_pemilik_rekening'] = this.namaPemilikRekening;
    data['nomor_rekening'] = this.nomorRekening;
    data['foto_buku_rekening'] = this.fotoBukuRekening;
    data['foto_profil'] = this.fotoProfil;
    data['status'] = this.status;
    data['aggrement'] = this.aggrement;
    data['rank'] = this.rank;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
