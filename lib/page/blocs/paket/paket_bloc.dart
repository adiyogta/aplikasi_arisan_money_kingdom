import 'package:aplikasi_arisan/page/model/paket_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'paket_state.dart';
part 'paket_event.dart';

class PaketBloc extends Bloc<PaketEvent, PaketState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  PaketState get initialState => PaketInitial();

  @override
  Stream<PaketState> mapEventToState(
    PaketEvent event,
  ) async* {
    if (event is GetPaketList) {
      try {
        yield PaketLoading();
        final mList = await _apiRepository.fetchCovidList();
        yield PaketLoaded(mList);
        if (mList.error != null) {
          yield PaketError(mList.error);
        }
      } on NetworkError {
        yield PaketError("Failed to fetch data. is your device online?");
      }
    }
    if (event is SearchTextChangedEvent) {
      print("hitting service");
      final pakets =
          await _apiRepository.fetchCovidList(event: event.searchTerm);
      yield PaketLoaded(pakets);
    }
  }
}
