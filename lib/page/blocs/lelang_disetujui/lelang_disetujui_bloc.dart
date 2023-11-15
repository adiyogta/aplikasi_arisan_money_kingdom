import 'package:aplikasi_arisan/page/model/lelang_disetujui.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lelang_disetujui_state.dart';
part 'lelang_disetujui_event.dart';

class LelangDisetujuiBloc
    extends Bloc<LelangDisetujuiEvent, LelangDisetujuiState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  LelangDisetujuiState get initialState => LelangDisetujuiInitial();

  @override
  Stream<LelangDisetujuiState> mapEventToState(
    LelangDisetujuiEvent event,
  ) async* {
    if (event is GetLelangDisetujuiList) {
      try {
        yield LelangDisetujuiLoading();
        final mList = await _apiRepository.fetchLelangDisetujui();
        yield LelangDisetujuiLoaded(mList);
        if (mList.error != null) {
          yield LelangDisetujuiError(mList.error);
        }
      } on NetworkError {
        yield LelangDisetujuiError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
