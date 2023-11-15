part of 'arisan_berjalan_detail_bloc.dart';

abstract class ArisanBerjalanDetailEvent extends Equatable {
  const ArisanBerjalanDetailEvent();
}

class GetArisanBerjalanDetailList extends ArisanBerjalanDetailEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends ArisanBerjalanDetailEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
