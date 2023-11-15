part of 'arisan_menang_bloc.dart';

abstract class ArisanMenangEvent extends Equatable {
  const ArisanMenangEvent();
}

class GetArisanMenangList extends ArisanMenangEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends ArisanMenangEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
