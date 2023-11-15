part of 'arisan_selesai_detail_bloc.dart';

abstract class ArisanSelesaiDetailEvent extends Equatable {
  const ArisanSelesaiDetailEvent();
}

class GetArisanSelesaiDetailList extends ArisanSelesaiDetailEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends ArisanSelesaiDetailEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
