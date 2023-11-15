import 'package:aplikasi_arisan/page/model/detail_lelang_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lelang_detail_state.dart';
part 'lelang_detail_event.dart';

class LelangDetailBloc extends Bloc<LelangDetailEvent, LelangDetailState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  LelangDetailState get initialState => LelangDetailInitial();

  @override
  Stream<LelangDetailState> mapEventToState(
    LelangDetailEvent event,
  ) async* {
    if (event is GetLelangDetailList) {
      try {
        yield LelangDetailLoading();
        final mList = await _apiRepository.fetchLelangDetail();
        yield LelangDetailLoaded(mList);
        if (mList.error != null) {
          yield LelangDetailError(mList.error);
        }
      } on NetworkError {
        yield LelangDetailError("Failed to fetch data. is your device online?");
      }
    }
  }
}
