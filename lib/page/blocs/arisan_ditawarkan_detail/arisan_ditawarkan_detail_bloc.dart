import 'package:aplikasi_arisan/page/model/detail_arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'arisan_ditawarkan_detail_state.dart';
part 'arisan_ditawarkan_detail_event.dart';

class ArisanDitawarkanDetailBloc
    extends Bloc<ArisanDitawarkanDetailEvent, ArisanDitawarkanDetailState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanDitawarkanDetailState get initialState =>
      ArisanDitawarkanDetailInitial();

  @override
  Stream<ArisanDitawarkanDetailState> mapEventToState(
    ArisanDitawarkanDetailEvent event,
  ) async* {
    if (event is GetArisanDitawarkanDetailList) {
      try {
        yield ArisanDitawarkanDetailLoading();

        final maList = await _apiRepository.fetchArisanDitawarkanDetail();
        yield ArisanDitawarkanDetailLoaded(maList);
        if (maList.error != null) {
          yield ArisanDitawarkanDetailError(maList.error);
        }
      } on NetworkError {
        yield ArisanDitawarkanDetailError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
