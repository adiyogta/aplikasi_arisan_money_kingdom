part of 'lelang_bloc.dart';

abstract class LelangEvent extends Equatable {
  const LelangEvent();
}

class GetLelangList extends LelangEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends LelangEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
