class OwnerModel {
  Owner owner;
  String error;

  OwnerModel({this.owner});

  OwnerModel.fromJson(Map<String, dynamic> json) {
    owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    return data;
  }

  OwnerModel.withError(String errorMessage) {
    if (this.owner == null) {
      error = 'Data Tidak Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Owner {
  int id;
  String username;
  String nama;
  String createdAt;
  String updatedAt;

  Owner({this.id, this.username, this.nama, this.createdAt, this.updatedAt});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    nama = json['nama'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['nama'] = this.nama;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
