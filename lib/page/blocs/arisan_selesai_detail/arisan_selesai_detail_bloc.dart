import 'package:aplikasi_arisan/page/model/arisan_selesai_detail.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'arisan_selesai_detail_state.dart';
part 'arisan_selesai_detail_event.dart';

class ArisanSelesaiDetailBloc
    extends Bloc<ArisanSelesaiDetailEvent, ArisanSelesaiDetailState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanSelesaiDetailState get initialState => ArisanSelesaiDetailInitial();

  @override
  Stream<ArisanSelesaiDetailState> mapEventToState(
    ArisanSelesaiDetailEvent event,
  ) async* {
    if (event is GetArisanSelesaiDetailList) {
      try {
        yield ArisanSelesaiDetailLoading();
        final maList = await _apiRepository.fetchArisanSelesaiDetail();
        yield ArisanSelesaiDetailLoaded(maList);
        if (maList.error != null) {
          yield ArisanSelesaiDetailError(maList.error);
        }
      } on NetworkError {
        yield ArisanSelesaiDetailError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
}
