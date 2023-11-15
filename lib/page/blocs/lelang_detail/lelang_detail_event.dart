part of 'lelang_detail_bloc.dart';

abstract class LelangDetailEvent extends Equatable {
  const LelangDetailEvent();
}

class GetLelangDetailList extends LelangDetailEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends LelangDetailEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
