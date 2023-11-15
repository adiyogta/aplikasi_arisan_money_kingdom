part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
}

class GetAdminList extends AdminEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends AdminEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
