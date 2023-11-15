class ArisanBerjalanDetailModel {
  List<Arisan> arisan;
  String error;

  ArisanBerjalanDetailModel({this.arisan});

  ArisanBerjalanDetailModel.fromJson(Map<String, dynamic> json) {
    if (json['arisan'] != null) {
      arisan = new List<Arisan>();
      json['arisan'].forEach((v) {
        arisan.add(new Arisan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.arisan != null) {
      data['arisan'] = this.arisan.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ArisanBerjalanDetailModel.withError(String errorMessage) {
    if (this.arisan == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class Arisan {
  String nama;
  int slot;
  int jumlahPeriodeBayar;
  int nominal;
  List<Peserta> peserta;

  Arisan(
      {this.nama,
      this.slot,
      this.jumlahPeriodeBayar,
      this.nominal,
      this.peserta});

  Arisan.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    slot = json['slot'];
    jumlahPeriodeBayar = json['jumlah_periode_bayar'];
    nominal = json['nominal'];
    if (json['peserta'] != null) {
      peserta = new List<Peserta>();
      json['peserta'].forEach((v) {
        peserta.add(new Peserta.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['slot'] = this.slot;
    data['jumlah_periode_bayar'] = this.jumlahPeriodeBayar;
    data['nominal'] = this.nominal;
    if (this.peserta != null) {
      data['peserta'] = this.peserta.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Peserta {
  int id;
  int slotNomor;
  String username;
  String tanggalDapat;
  String buktiTransferMenang;

  Peserta({this.id, this.slotNomor, this.username, this.tanggalDapat});

  Peserta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slotNomor = json['slot_nomor'];
    username = json['username'];
    tanggalDapat = json['tanggal_dapat'];
    buktiTransferMenang = json['bukti_transfer_menang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slot_nomor'] = this.slotNomor;
    data['username'] = this.username;
    data['tanggal_dapat'] = this.tanggalDapat;
    data['bukti_transfer_menang'] = this.buktiTransferMenang;
    return data;
  }
}
