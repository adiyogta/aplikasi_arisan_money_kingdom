part of 'peserta_arisan_berjalan_bloc.dart';

abstract class PesertaArisanBerjalanEvent extends Equatable {
  const PesertaArisanBerjalanEvent();
}

class GetPesertaArisanBerjalanList extends PesertaArisanBerjalanEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends PesertaArisanBerjalanEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
