part of 'paket_bloc.dart';

abstract class PaketEvent extends Equatable {
  const PaketEvent();
}

class GetPaketList extends PaketEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends PaketEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
