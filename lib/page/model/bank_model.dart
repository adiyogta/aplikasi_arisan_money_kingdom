class BankModel {
  List<Bank> bank;
  String error;

  BankModel({this.bank});

  BankModel.fromJson(Map<String, dynamic> json) {
    if (json['bank'] != null) {
      bank = new List<Bank>();
      json['bank'].forEach((v) {
        bank.add(new Bank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bank != null) {
      data['bank'] = this.bank.map((v) => v.toJson()).toList();
    }
    return data;
  }

  BankModel.withError(String errorMessage) {
    if (this.bank == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Bank {
  int id;
  String nama;

  Bank({this.id, this.nama});

  Bank.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nama'] = this.nama;
    return data;
  }
}
