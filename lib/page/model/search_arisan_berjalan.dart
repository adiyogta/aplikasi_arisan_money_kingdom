class SearchArisanBerjalanModel {
  List<ArisanB> arisanBerjalan;
  String error;
  String message;

  SearchArisanBerjalanModel({this.arisanBerjalan});

  SearchArisanBerjalanModel.fromJson(Map<String, dynamic> json) {
    if (json['arisan_berjalan'] != null) {
      arisanBerjalan = new List<ArisanB>();
      json['arisan_berjalan'].forEach((v) {
        arisanBerjalan.add(new ArisanB.fromJson(v));
      });
    } else if (json['arisan_berjalan'] == null && json['message'] != null) {
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arisanBerjalan != null) {
      data['arisan_berjalan'] =
          this.arisanBerjalan.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SearchArisanBerjalanModel.withError(String errorMessage) {
    if (this.arisanBerjalan == null) {
      error = 'Data Belum Ada';
    } else if (this.arisanBerjalan == null && this.message != null) {
      error = 'Data Tidak Ditemukan';
    } else {
      error = errorMessage;
    }
  }
}

class ArisanB {
  int id;
  String nama;
  int paketId;
  String startArisan;
  String finishArisan;
  String status;
  String createdAt;
  String updatedAt;

  ArisanB(
      {this.id,
      this.nama,
      this.paketId,
      this.startArisan,
      this.finishArisan,
      this.status,
      this.createdAt,
      this.updatedAt});

  ArisanB.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    paketId = json['paket_id'];
    startArisan = json['start_arisan'];
    finishArisan = json['finish_arisan'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    data['paket_id'] = this.paketId;
    data['start_arisan'] = this.startArisan;
    data['finish_arisan'] = this.finishArisan;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
