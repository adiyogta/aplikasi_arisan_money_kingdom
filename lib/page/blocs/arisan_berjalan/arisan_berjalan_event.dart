part of 'arisan_berjalan_bloc.dart';

abstract class ArisanBerjalanEvent extends Equatable {
  const ArisanBerjalanEvent();
}

class GetArisanBerjalanList extends ArisanBerjalanEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends ArisanBerjalanEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
