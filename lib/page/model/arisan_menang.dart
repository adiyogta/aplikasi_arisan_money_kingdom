class ArisanMenangModel {
  String error;
  List<ArisanMenang> arisanMenang;

  ArisanMenangModel({this.arisanMenang});

  ArisanMenangModel.fromJson(Map<String, dynamic> json) {
    if (json['arisan_menang'] != null) {
      arisanMenang = new List<ArisanMenang>();
      json['arisan_menang'].forEach((v) {
        arisanMenang.add(new ArisanMenang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arisanMenang != null) {
      data['arisan_menang'] = this.arisanMenang.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ArisanMenangModel.withError(String errorMessage) {
    if (this.arisanMenang == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class ArisanMenang {
  int id;
  String nama;
  String username;
  String namaLengkap;
  int nominal;

  ArisanMenang(
      {this.id, this.nama, this.username, this.namaLengkap, this.nominal});

  ArisanMenang.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    username = json['username'];
    namaLengkap = json['nama_lengkap'];
    nominal = json['nominal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['username'] = this.username;
    data['nama_lengkap'] = this.namaLengkap;
    data['nominal'] = this.nominal;
    return data;
  }
}
