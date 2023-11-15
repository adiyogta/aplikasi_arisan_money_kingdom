class SearchArisanDitawarkanModel {
  List<ArisanDitawarkan> arisanDitawarkan;
  String error;
  String message;

  SearchArisanDitawarkanModel({this.arisanDitawarkan});

  SearchArisanDitawarkanModel.fromJson(Map<String, dynamic> json) {
    if (json['arisan_ditawarkan'] != null) {
      arisanDitawarkan = new List<ArisanDitawarkan>();
      json['arisan_ditawarkan'].forEach((v) {
        arisanDitawarkan.add(new ArisanDitawarkan.fromJson(v));
      });
    } else if (json['arisan_ditawarkan'] == null && json['message'] != null) {
      message = json['message'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arisanDitawarkan != null) {
      data['arisan_ditawarkan'] =
          this.arisanDitawarkan.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SearchArisanDitawarkanModel.withError(String errorMessage) {
    if (this.arisanDitawarkan == null) {
      error = 'Data Belum Ada';
    } else if (this.arisanDitawarkan == null && this.message != null) {
      error = 'Data Tidak Ditemukan';
    } else {
      error = errorMessage;
    }
  }
}

class ArisanDitawarkan {
  int id;
  String nama;
  int paketId;
  Null startArisan;
  Null finishArisan;
  String status;
  String createdAt;
  String updatedAt;

  ArisanDitawarkan(
      {this.id,
      this.nama,
      this.paketId,
      this.startArisan,
      this.finishArisan,
      this.status,
      this.createdAt,
      this.updatedAt});

  ArisanDitawarkan.fromJson(Map<String, dynamic> json) {
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
