import 'package:aplikasi_arisan/page/model/poster_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'poster_state.dart';
part 'poster_event.dart';

class PosterBloc extends Bloc<PosterEvent, PosterState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  PosterState get initialState => PosterInitial();

  @override
  Stream<PosterState> mapEventToState(
    PosterEvent event,
  ) async* {
    if (event is GetPosterList) {
      try {
        yield PosterLoading();
        final maList = await _apiRepository.fetchPosterList();
        yield PosterLoaded(maList);
        if (maList.error != null) {
          yield PosterError(maList.error);
        }
      } on NetworkError {
        yield PosterError("Failed to fetch data. is your device online?");
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
