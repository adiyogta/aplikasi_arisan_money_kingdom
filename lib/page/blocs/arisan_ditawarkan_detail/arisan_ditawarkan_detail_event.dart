part of 'arisan_ditawarkan_detail_bloc.dart';

abstract class ArisanDitawarkanDetailEvent extends Equatable {
  const ArisanDitawarkanDetailEvent();
}

class GetArisanDitawarkanDetailList extends ArisanDitawarkanDetailEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends ArisanDitawarkanDetailEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
