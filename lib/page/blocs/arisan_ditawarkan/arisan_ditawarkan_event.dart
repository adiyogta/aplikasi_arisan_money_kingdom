part of 'arisan_ditawarkan_bloc.dart';

abstract class ArisanDitawarkanEvent extends Equatable {
  const ArisanDitawarkanEvent();
}

class GetArisanDitawarkanList extends ArisanDitawarkanEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends ArisanDitawarkanEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
