import 'package:aplikasi_arisan/page/model/peserta_detail_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'peserta_detail_state.dart';
part 'peserta_detail_event.dart';

class PesertaDetailBloc extends Bloc<PesertaDetailEvent, PesertaDetailState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  PesertaDetailState get initialState => PesertaDetailInitial();

  @override
  Stream<PesertaDetailState> mapEventToState(
    PesertaDetailEvent event,
  ) async* {
    if (event is GetPesertaDetailList) {
      try {
        yield PesertaDetailLoading();
        final maList = await _apiRepository.fetchPesertaDetail();
        yield PesertaDetailLoaded(maList);
        if (maList.error != null) {
          yield PesertaDetailError(maList.error);
        }
      } on NetworkError {
        yield PesertaDetailError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
