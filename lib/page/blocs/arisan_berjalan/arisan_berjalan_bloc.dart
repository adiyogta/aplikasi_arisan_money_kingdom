import 'package:aplikasi_arisan/page/model/arisan_berjalan_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'arisan_berjalan_state.dart';
part 'arisan_berjalan_event.dart';

class ArisanBerjalanBloc
    extends Bloc<ArisanBerjalanEvent, ArisanBerjalanState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanBerjalanState get initialState => ArisanBerjalanInitial();

  @override
  Stream<ArisanBerjalanState> mapEventToState(
    ArisanBerjalanEvent event,
  ) async* {
    if (event is GetArisanBerjalanList) {
      try {
        yield ArisanBerjalanLoading();
        final maList = await _apiRepository.fetchArisanBerjalan();
        yield ArisanBerjalanLoaded(maList);
        if (maList.error != null) {
          yield ArisanBerjalanError(maList.error);
        }
      } on NetworkError {
        yield ArisanBerjalanError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
