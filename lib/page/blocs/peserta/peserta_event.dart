part of 'peserta_bloc.dart';

abstract class PesertaEvent extends Equatable {
  const PesertaEvent();
}

class GetPesertaList extends PesertaEvent {
  @override
  List<Object> get props => null;
}

class GetSearchPesertaList extends PesertaEvent {
  @override
  List<Object> get props => null;
}

class ClickIconSearch extends PesertaEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ClickCloseSearch extends PesertaEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SearchQueryChanged extends PesertaEvent {
  final String keyword;

  SearchQueryChanged({this.keyword});

  @override
  List<Object> get props => [keyword];

  @override
  String toString() {
    return 'SearchQueryChanged{keyword: $keyword}';
  }
}
