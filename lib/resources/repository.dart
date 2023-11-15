import 'package:aplikasi_arisan/page/model/admin_me_model.dart';
import 'package:aplikasi_arisan/page/model/admin_model.dart';
import 'package:aplikasi_arisan/page/model/arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/model/arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/page/model/arisan_menang.dart';
import 'package:aplikasi_arisan/page/model/arisan_selesai.dart';
import 'package:aplikasi_arisan/page/model/arisan_selesai_detail.dart';
import 'package:aplikasi_arisan/page/model/bank_model.dart';
import 'package:aplikasi_arisan/page/model/detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/model/detail_arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/page/model/detail_lelang_model.dart';
import 'package:aplikasi_arisan/page/model/lelang_disetujui.dart';
import 'package:aplikasi_arisan/page/model/lelang_model.dart';
import 'package:aplikasi_arisan/page/model/owner_model.dart';
import 'package:aplikasi_arisan/page/model/paket_model.dart';
import 'package:aplikasi_arisan/page/model/peserta_detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/page/model/peserta_detail_model.dart';
import 'package:aplikasi_arisan/page/model/peserta_model.dart';
import 'package:aplikasi_arisan/page/model/poster_model.dart';
import 'package:aplikasi_arisan/page/model/search_peserta.dart';
import 'package:aplikasi_arisan/resources/admin_api.dart';
import 'package:aplikasi_arisan/resources/arisan_berjalan_api.dart';
import 'package:aplikasi_arisan/resources/arisan_ditawarkan_api.dart';
import 'package:aplikasi_arisan/resources/arisan_menang.dart';
import 'package:aplikasi_arisan/resources/arisan_selesai.dart';
import 'package:aplikasi_arisan/resources/bank_api.dart';
import 'package:aplikasi_arisan/resources/lelang_api.dart';
import 'package:aplikasi_arisan/resources/paket_api.dart';
import 'package:aplikasi_arisan/resources/peserta_api.dart';
import 'package:aplikasi_arisan/resources/peserta_arisan_berjalan_api.dart';
import 'package:aplikasi_arisan/resources/poster_api.dart';
import 'package:aplikasi_arisan/resources/user_2_api.dart';
import 'package:aplikasi_arisan/resources/user_api.dart';
import 'package:aplikasi_arisan/resources/search_api.dart';
import 'package:aplikasi_arisan/page/model/search_arisan_ditawarkan.dart';
import 'package:aplikasi_arisan/page/model/search_arisan_berjalan.dart';

class ApiRepository {
  final _provider = PaketApiProvider();
  final _providerBank = BankApiProvider();
  final _providerArisanDitawarkan = ArisanDitawarkanApiProvider();
  final _providerArisanBerjalan = ArisanBerjalanApiProvider();
  final _providerArisanSelesai = ArisanSelesaiApiProvider();
  final _providerPesertaArisanBerjalan = PesertaArisanBerjalanApiProvider();
  final _providerAdmin = AdminApiProvider();
  final _providerLelang = LelangApiProvider();
  final _providerPeserta = PesertaApiProvider();
  final _providerUser = UserApiProvider();
  final _providerUser2 = UserApiProvider2();
  final _providerPoster = PosterApiProvider();
  final _providerSearch = SearchApiProvider();
  final _providerArisanMenang = ArisanMenangApiProvider();

  Future<ListPaketModel> fetchCovidList({String event}) {
    return _provider.fetchPaketList();
  }

  Future<OwnerModel> owner({String event}) {
    return _providerUser.fetchOwner();
  }

  Future<AdminModel> admin() {
    return _providerUser2.fetchAdmin();
  }

  Future<BankModel> fetchBankList({String event}) {
    return _providerBank.fetchBankList();
  }

  Future<PosterModel> fetchPosterList({String event}) {
    return _providerPoster.fetchPaketList();
  }

  Future<ArisanBerjalanDetailModel> fetchArisanBerjalanDetail() {
    return _providerArisanBerjalan.fetchArisanBerjalanDetailList();
  }

  Future<ArisanMenangModel> fetchArisanMenang() {
    return _providerArisanMenang.fetchArisanMenangList();
  }

  Future<ArisanBerjalanModel> fetchArisanBerjalan() {
    return _providerArisanBerjalan.fetchArisanBerjalanList();
  }

  Future<PesertaArisanBerjalanDetailModel> fetchPesertaArisanBerjalan() {
    return _providerPesertaArisanBerjalan.fetchPesertaArisanBerjalanList();
  }

  Future<DetailArisanDitawarkan> fetchArisanDitawarkanDetail() {
    return _providerArisanDitawarkan.fetchArisanDitawarkanDetailList();
  }

  Future<ArisanDitawarkanList> fetchArisanDitawarkan() {
    return _providerArisanDitawarkan.fetchArisanDitawarkanList();
  }

  Future<ListAdminModel> fetchAdmin() {
    return _providerAdmin.fetchAdminList();
  }

  Future<PesertaModel> fetchPeserta() {
    return _providerPeserta.fetchPesertaList();
  }

  Future<SearchPesertaModel> fetchSearchPeserta() {
    return _providerPeserta.fetchSearchPesertaList();
  }

  Future<DetailPesertaModel> fetchPesertaDetail() {
    return _providerPeserta.fetchPesertaDetailList();
  }

  Future<DetailLelangModel> fetchLelangDetail() {
    return _providerLelang.fetchLelangDetailList();
  }

  Future<LelangDisetujuiModel> fetchLelangDisetujui() {
    return _providerLelang.fetchLelangDisetujuiList();
  }

  Future<LelangModel> fetchLelang() {
    return _providerLelang.fetchLelangList();
  }

  Future<ArisanSelesaiDetailModel> fetchArisanSelesaiDetail() {
    return _providerArisanSelesai.fetchArisanSelesaiDetailList();
  }

  Future<ArisanSelesaiModel> fetchArisanSelesai() {
    return _providerArisanSelesai.fetchArisanSelesaiList();
  }

  Future<SearchArisanDitawarkanModel> fetchSearchArisanDitawarkan() {
    return _providerSearch.fetchSearchArisanDitawarkanList();
  }

  Future<SearchArisanBerjalanModel> fetchSearchArisanBerjalan() {
    return _providerSearch.fetchSearchArisanBerjalanList();
  }
}

class NetworkError extends Error {}
