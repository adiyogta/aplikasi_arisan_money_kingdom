import 'package:aplikasi_arisan/page/model/lelang_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'lelang_state.dart';
part 'lelang_event.dart';

class LelangBloc extends Bloc<LelangEvent, LelangState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  LelangState get initialState => LelangInitial();

  @override
  Stream<LelangState> mapEventToState(
    LelangEvent event,
  ) async* {
    if (event is GetLelangList) {
      try {
        yield LelangLoading();
        final mList = await _apiRepository.fetchLelang();
        yield LelangLoaded(mList);
        if (mList.error != null) {
          yield LelangError(mList.error);
        }
      } on NetworkError {
        yield LelangError("Failed to fetch data. is your device online?");
      }
    }
  }
}
