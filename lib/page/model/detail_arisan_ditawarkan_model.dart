class DetailArisanDitawarkan {
  List<ArisanDetail> arisan;
  String error;

  DetailArisanDitawarkan({this.arisan});

  DetailArisanDitawarkan.fromJson(Map<String, dynamic> json) {
    if (json['arisan'] != null) {
      arisan = new List<ArisanDetail>();
      json['arisan'].forEach((v) {
        arisan.add(new ArisanDetail.fromJson(v));
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

  DetailArisanDitawarkan.withError(String errorMessage) {
    if (this.arisan == null) {
      error = 'Data Belum Ada';
    } else {
      error = errorMessage;
    }
  }
}

class ArisanDetail {
  String nama;
  int slot;
  int jumlahPeriodeBayar;
  int nominal;
  List<Peserta> peserta;

  ArisanDetail(
      {this.nama,
      this.slot,
      this.jumlahPeriodeBayar,
      this.nominal,
      this.peserta});

  ArisanDetail.fromJson(Map<String, dynamic> json) {
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
  int pasok;
  String status;
  var tanggalDapat;
  var statusArisanType;

  Peserta(
      {this.id,
      this.slotNomor,
      this.username,
      this.pasok,
      this.status,
      this.tanggalDapat,
      this.statusArisanType});

  Peserta.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slotNomor = json['slot_nomor'];
    username = json['username'];
    pasok = json['pasok'];
    status = json['status'];
    tanggalDapat = json['tanggal_dapat'];
    statusArisanType = json['status_arisan_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slot_nomor'] = this.slotNomor;
    data['username'] = this.username;
    data['pasok'] = this.pasok;
    data['status'] = this.status;
    data['tanggal_dapat'] = this.tanggalDapat;
    data['status_arisan_type'] = this.statusArisanType;
    return data;
  }
}
