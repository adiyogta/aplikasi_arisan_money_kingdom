import 'package:aplikasi_arisan/page/model/peserta_detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'peserta_arisan_berjalan_state.dart';
part 'peserta_arisan_berjalan_event.dart';

class PesertaArisanBerjalanBloc
    extends Bloc<PesertaArisanBerjalanEvent, PesertaArisanBerjalanState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  PesertaArisanBerjalanState get initialState => PesertaArisanBerjalanInitial();

  @override
  Stream<PesertaArisanBerjalanState> mapEventToState(
    PesertaArisanBerjalanEvent event,
  ) async* {
    if (event is GetPesertaArisanBerjalanList) {
      try {
        yield PesertaArisanBerjalanLoading();
        final mList = await _apiRepository.fetchPesertaArisanBerjalan();
        yield PesertaArisanBerjalanLoaded(mList);
        if (mList.error != null) {
          yield PesertaArisanBerjalanError(mList.error);
        }
      } on NetworkError {
        yield PesertaArisanBerjalanError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
