class ListAdminModel {
  List<Admin> admin;
  String error;

  ListAdminModel({this.admin});

  ListAdminModel.fromJson(Map<String, dynamic> json) {
    if (json['admin'] != null) {
      admin = new List<Admin>();
      json['admin'].forEach((v) {
        admin.add(new Admin.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.admin != null) {
      data['admin'] = this.admin.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ListAdminModel.withError(String errorMessage) {
    if (this.admin == null) {
      error = 'Data Belum Ada';
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
