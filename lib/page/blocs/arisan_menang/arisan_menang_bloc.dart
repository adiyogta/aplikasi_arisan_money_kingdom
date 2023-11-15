import 'package:aplikasi_arisan/page/model/arisan_menang.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'arisan_menang_state.dart';
part 'arisan_menang_event.dart';

class ArisanMenangBloc extends Bloc<ArisanMenangEvent, ArisanMenangState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanMenangState get initialState => ArisanMenangInitial();

  @override
  Stream<ArisanMenangState> mapEventToState(
    ArisanMenangEvent event,
  ) async* {
    if (event is GetArisanMenangList) {
      try {
        yield ArisanMenangLoading();
        final maList = await _apiRepository.fetchArisanMenang();
        yield ArisanMenangLoaded(maList);
        if (maList.error != null) {
          yield ArisanMenangError(maList.error);
        }
      } on NetworkError {
        yield ArisanMenangError("Failed to fetch data. is your device online?");
      }
    }
  }
}
