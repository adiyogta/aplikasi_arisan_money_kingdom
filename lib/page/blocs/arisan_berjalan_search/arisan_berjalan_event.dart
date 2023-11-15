part of 'arisan_berjalan_bloc.dart';

abstract class ArisanBerjalanSearchEvent extends Equatable {
  const ArisanBerjalanSearchEvent();
}

class GetArisanBerjalanSearchList extends ArisanBerjalanSearchEvent {
  @override
  List<Object> get props => null;
}

class GetSearchArisanBerjalanSearchList extends ArisanBerjalanSearchEvent {
  @override
  List<Object> get props => null;
}

class ClickIconSearch extends ArisanBerjalanSearchEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ClickCloseSearch extends ArisanBerjalanSearchEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SearchQueryChanged extends ArisanBerjalanSearchEvent {
  final String keyword;

  SearchQueryChanged({this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchQueryChanged{keyword: $keyword}';
  }
}
