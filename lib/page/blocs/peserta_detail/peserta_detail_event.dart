part of 'peserta_detail_bloc.dart';

abstract class PesertaDetailEvent extends Equatable {
  const PesertaDetailEvent();
}

class GetPesertaDetailList extends PesertaDetailEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends PesertaDetailEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
