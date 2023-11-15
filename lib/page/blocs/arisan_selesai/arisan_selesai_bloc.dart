import 'package:aplikasi_arisan/page/model/arisan_selesai.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'arisan_selesai_state.dart';
part 'arisan_selesai_event.dart';

class ArisanSelesaiBloc extends Bloc<ArisanSelesaiEvent, ArisanSelesaiState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanSelesaiState get initialState => ArisanSelesaiInitial();

  @override
  Stream<ArisanSelesaiState> mapEventToState(
    ArisanSelesaiEvent event,
  ) async* {
    if (event is GetArisanSelesaiList) {
      try {
        yield ArisanSelesaiLoading();
        final maList = await _apiRepository.fetchArisanSelesai();
        yield ArisanSelesaiLoaded(maList);
        if (maList.error != null) {
          yield ArisanSelesaiError(maList.error);
        }
      } on NetworkError {
        yield ArisanSelesaiError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
