class PesertaModel {
  List<Peserta> peserta;
  String error;

  PesertaModel({this.peserta});

  PesertaModel.fromJson(Map<String, dynamic> json) {
    if (json['peserta'] != null) {
      peserta = new List<Peserta>();
      json['peserta'].forEach((v) {
        peserta.add(new Peserta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.peserta != null) {
      data['peserta'] = this.peserta.map((v) => v.toJson()).toList();
    }
    return data;
  }

  PesertaModel.withError(String errorMessage) {
    if (this.peserta == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Peserta {
  int id;
  String fotoProfil;
  String username;
  String namaLengkap;
  String noHp;
  String status;

  Peserta(
      {this.id,
      this.fotoProfil,
      this.username,
      this.namaLengkap,
      this.noHp,
      this.status});

  Peserta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fotoProfil = json['foto_profil'];
    username = json['username'];
    namaLengkap = json['nama_lengkap'];
    noHp = json['no_hp'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foto_profil'] = this.fotoProfil;
    data['username'] = this.username;
    data['nama_lengkap'] = this.namaLengkap;
    data['no_hp'] = this.noHp;
    data['status'] = this.status;
    return data;
  }
}
