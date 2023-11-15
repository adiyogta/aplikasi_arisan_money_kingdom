import 'package:aplikasi_arisan/page/model/search_peserta.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'peserta_search_state.dart';
part 'peserta_search_event.dart';

class PesertaSearchBloc extends Bloc<PesertaSearchEvent, PesertaSearchState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  PesertaSearchState get initialState => PesertaSearchInitial();

  @override
  Stream<PesertaSearchState> mapEventToState(
    PesertaSearchEvent event,
  ) async* {
    if (event is GetPesertaSearchList) {
      try {
        yield PesertaSearchLoading();
        final maList = await _apiRepository.fetchSearchPeserta();
        yield PesertaSearchLoaded(maList);

        if (maList.error != null) {
          yield PesertaSearchError(maList.error);
        }
      } on NetworkError {
        yield PesertaSearchError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
  //  Stream<PesertaSearchState> _mapSearchQueryChangedToState(String keyword) async* {
  //   yield PesertaSearchLoading();

  //   try {
  //     final response = await _apiRepository.fetchPesertaSearch();

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
