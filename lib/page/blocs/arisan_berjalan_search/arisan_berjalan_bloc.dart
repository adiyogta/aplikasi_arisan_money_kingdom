import 'package:aplikasi_arisan/page/model/search_arisan_berjalan.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'arisan_berjalan_state.dart';
part 'arisan_berjalan_event.dart';

class ArisanBerjalanSearchBloc
    extends Bloc<ArisanBerjalanSearchEvent, ArisanBerjalanSearchState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanBerjalanSearchState get initialState => ArisanBerjalanSearchInitial();

  @override
  Stream<ArisanBerjalanSearchState> mapEventToState(
    ArisanBerjalanSearchEvent event,
  ) async* {
    if (event is GetArisanBerjalanSearchList) {
      try {
        yield ArisanBerjalanSearchLoading();
        final maList = await _apiRepository.fetchSearchArisanBerjalan();
        yield ArisanBerjalanSearchLoaded(maList);

        if (maList.error != null) {
          yield ArisanBerjalanSearchError(maList.error);
        }
      } on NetworkError {
        yield ArisanBerjalanSearchError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
  //  Stream<ArisanBerjalanSearchState> _mapSearchQueryChangedToState(String keyword) async* {
  //   yield ArisanBerjalanSearchLoading();

  //   try {
  //     final response = await _apiRepository.fetchArisanBerjalanSearch();

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
