import 'package:aplikasi_arisan/page/model/arisan_ditawarkan_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'arisan_ditawarkan_state.dart';
part 'arisan_ditawarkan_event.dart';

class ArisanDitawarkanBloc
    extends Bloc<ArisanDitawarkanEvent, ArisanDitawarkanState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanDitawarkanState get initialState => ArisanDitawarkanInitial();

  @override
  Stream<ArisanDitawarkanState> mapEventToState(
    ArisanDitawarkanEvent event,
  ) async* {
    if (event is GetArisanDitawarkanList) {
      try {
        yield ArisanDitawarkanLoading();
        final maList = await _apiRepository.fetchArisanDitawarkan();
        yield ArisanDitawarkanLoaded(maList);
        if (maList.error != null) {
          yield ArisanDitawarkanError(maList.error);
        }
      } on NetworkError {
        yield ArisanDitawarkanError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
