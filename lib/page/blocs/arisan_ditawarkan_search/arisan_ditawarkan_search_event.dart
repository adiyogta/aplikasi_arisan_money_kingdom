part of 'arisan_ditawarkan_search_bloc.dart';

abstract class ArisanDitawarkanSearchEvent extends Equatable {
  const ArisanDitawarkanSearchEvent();
}

class GetArisanDitawarkanSearchList extends ArisanDitawarkanSearchEvent {
  @override
  List<Object> get props => null;
}

class GetSearchArisanDitawarkanSearchList extends ArisanDitawarkanSearchEvent {
  @override
  List<Object> get props => null;
}

class ClickIconSearch extends ArisanDitawarkanSearchEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ClickCloseSearch extends ArisanDitawarkanSearchEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SearchQueryChanged extends ArisanDitawarkanSearchEvent {
  final String keyword;

  SearchQueryChanged({this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchQueryChanged{keyword: $keyword}';
  }
}
