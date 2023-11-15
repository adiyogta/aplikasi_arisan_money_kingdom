part of 'peserta_search_bloc.dart';

abstract class PesertaSearchEvent extends Equatable {
  const PesertaSearchEvent();
}

class GetPesertaSearchList extends PesertaSearchEvent {
  @override
  List<Object> get props => null;
}

class GetSearchPesertaSearchList extends PesertaSearchEvent {
  @override
  List<Object> get props => null;
}

class ClickIconSearch extends PesertaSearchEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ClickCloseSearch extends PesertaSearchEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SearchQueryChanged extends PesertaSearchEvent {
  final String keyword;

  SearchQueryChanged({this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchQueryChanged{keyword: $keyword}';
  }
}
