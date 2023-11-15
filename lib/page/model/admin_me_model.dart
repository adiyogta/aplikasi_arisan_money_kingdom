class AdminModel {
  Admin admin;
  String error;

  AdminModel({this.admin});

  AdminModel.fromJson(Map<String, dynamic> json) {
    admin = json['admin'] != null ? new Admin.fromJson(json['admin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.admin != null) {
      data['admin'] = this.admin.toJson();
    }
    return data;
  }

  AdminModel.withError(String errorMessage) {
    if (this.admin == null) {
      error = 'Data Tidak Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Admin {
  int id;
  String username;
  String nama;
  String createdAt;
  String updatedAt;

  Admin({this.id, this.username, this.nama, this.createdAt, this.updatedAt});

  Admin.fromJson(Map<String, dynamic> json) {
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
