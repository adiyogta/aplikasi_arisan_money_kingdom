part of 'owner_bloc.dart';

abstract class OwnerEvent extends Equatable {
  const OwnerEvent();
}

class GetOwnerList extends OwnerEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends OwnerEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
