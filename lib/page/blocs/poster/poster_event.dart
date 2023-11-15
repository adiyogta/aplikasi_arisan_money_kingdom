part of 'poster_bloc.dart';

abstract class PosterEvent extends Equatable {
  const PosterEvent();
}

class GetPosterList extends PosterEvent {
  @override
  List<Object> get props => null;
}

class ClickIconSearch extends PosterEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ClickCloseSearch extends PosterEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SearchQueryChanged extends PosterEvent {
  final String keyword;

  SearchQueryChanged({this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchQueryChanged{keyword: $keyword}';
  }
}
