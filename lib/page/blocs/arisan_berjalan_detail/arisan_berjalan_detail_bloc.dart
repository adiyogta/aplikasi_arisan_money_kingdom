import 'package:aplikasi_arisan/page/model/detail_arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'arisan_berjalan_detail_state.dart';
part 'arisan_berjalan_detail_event.dart';

class ArisanBerjalanDetailBloc
    extends Bloc<ArisanBerjalanDetailEvent, ArisanBerjalanDetailState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanBerjalanDetailState get initialState => ArisanBerjalanDetailInitial();

  @override
  Stream<ArisanBerjalanDetailState> mapEventToState(
    ArisanBerjalanDetailEvent event,
  ) async* {
    if (event is GetArisanBerjalanDetailList) {
      try {
        yield ArisanBerjalanDetailLoading();
        final maList = await _apiRepository.fetchArisanBerjalanDetail();
        yield ArisanBerjalanDetailLoaded(maList);
        if (maList.error != null) {
          yield ArisanBerjalanDetailError(maList.error);
        }
      } on NetworkError {
        yield ArisanBerjalanDetailError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
