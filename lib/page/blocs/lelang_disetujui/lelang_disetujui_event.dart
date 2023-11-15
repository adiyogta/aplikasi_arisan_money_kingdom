part of 'lelang_disetujui_bloc.dart';

abstract class LelangDisetujuiEvent extends Equatable {
  const LelangDisetujuiEvent();
}

class GetLelangDisetujuiList extends LelangDisetujuiEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends LelangDisetujuiEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
