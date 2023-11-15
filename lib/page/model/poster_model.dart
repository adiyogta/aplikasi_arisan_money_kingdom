class PosterModel {
  List<Poster> poster;
  String error;

  PosterModel({this.poster});

  PosterModel.fromJson(Map<String, dynamic> json) {
    if (json['poster'] != null) {
      poster = new List<Poster>();
      json['poster'].forEach((v) {
        poster.add(new Poster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.poster != null) {
      data['poster'] = this.poster.map((v) => v.toJson()).toList();
    }
    return data;
  }

  PosterModel.withError(String errorMessage) {
    if (this.poster == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Poster {
  int id;
  String nama;
  String foto;
  String deskripsi;
  String createdAt;
  String updatedAt;

  Poster(
      {this.id,
      this.nama,
      this.foto,
      this.deskripsi,
      this.createdAt,
      this.updatedAt});

  Poster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    foto = json['foto'];
    deskripsi = json['deskripsi'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['foto'] = this.foto;
    data['deskripsi'] = this.deskripsi;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
