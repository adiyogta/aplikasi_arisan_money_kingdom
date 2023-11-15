part of 'arisan_selesai_bloc.dart';

abstract class ArisanSelesaiEvent extends Equatable {
  const ArisanSelesaiEvent();
}

class GetArisanSelesaiList extends ArisanSelesaiEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends ArisanSelesaiEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
