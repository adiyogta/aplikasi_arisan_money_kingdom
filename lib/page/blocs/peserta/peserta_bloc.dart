import 'package:aplikasi_arisan/page/model/peserta_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'peserta_state.dart';
part 'peserta_event.dart';

class PesertaBloc extends Bloc<PesertaEvent, PesertaState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  PesertaState get initialState => PesertaInitial();

  @override
  Stream<PesertaState> mapEventToState(
    PesertaEvent event,
  ) async* {
    if (event is GetPesertaList) {
      try {
        yield PesertaLoading();
        final maList = await _apiRepository.fetchPeserta();
        yield PesertaLoaded(maList);

        if (maList.error != null) {
          yield PesertaError(maList.error);
        }
      } on NetworkError {
        yield PesertaError("Failed to fetch data. is your device online?");
      }
    }
  }
  //  Stream<PesertaState> _mapSearchQueryChangedToState(String keyword) async* {
  //   yield PesertaLoading();

  //   try {
  //     final response = await _apiRepository.fetchPeserta();

  //     //this should be execute at server side
  //     bool query(Show show) =>
  //         keyword.isEmpty ||
  //             show.name.toLowerCase().contains(keyword.toLowerCase());

  //     response.nowShowing = response.nowShowing.where(query).toList();
  //     response.comingSoon = response.comingSoon.where(query).toList();
  //     response.exclusive = response.exclusive.where(query).toList();

  //     final meta = _metaFromResponse(response);

  //     yield DisplayListShows.data(meta);
  //   } catch (e) {
  //     yield DisplayListShows.error(e.toString());
  //   }
  // }
}
