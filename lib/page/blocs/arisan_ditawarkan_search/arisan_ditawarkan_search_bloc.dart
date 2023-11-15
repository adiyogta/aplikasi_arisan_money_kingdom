import 'package:aplikasi_arisan/page/model/search_arisan_ditawarkan.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'arisan_ditawarkan_search_state.dart';
part 'arisan_ditawarkan_search_event.dart';

class ArisanDitawarkanSearchBloc
    extends Bloc<ArisanDitawarkanSearchEvent, ArisanDitawarkanSearchState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  ArisanDitawarkanSearchState get initialState =>
      ArisanDitawarkanSearchInitial();

  @override
  Stream<ArisanDitawarkanSearchState> mapEventToState(
    ArisanDitawarkanSearchEvent event,
  ) async* {
    if (event is GetArisanDitawarkanSearchList) {
      try {
        yield ArisanDitawarkanSearchLoading();
        final maList = await _apiRepository.fetchSearchArisanDitawarkan();
        yield ArisanDitawarkanSearchLoaded(maList);

        if (maList.error != null) {
          yield ArisanDitawarkanSearchError(maList.error);
        }
      } on NetworkError {
        yield ArisanDitawarkanSearchError(
            "Failed to fetch data. is your device online?");
      }
    }
  }
  //  Stream<ArisanDitawarkanSearchState> _mapSearchQueryChangedToState(String keyword) async* {
  //   yield ArisanDitawarkanSearchLoading();

  //   try {
  //     final response = await _apiRepository.fetchArisanDitawarkanSearch();

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
