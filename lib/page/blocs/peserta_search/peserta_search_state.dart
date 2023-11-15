part of 'peserta_search_bloc.dart';

abstract class PesertaSearchState extends Equatable {
  const PesertaSearchState();
}

class PesertaSearchInitial extends PesertaSearchState {
  const PesertaSearchInitial();
  @override
  List<Object> get props => [];
}

class PesertaSearchLoading extends PesertaSearchState {
  const PesertaSearchLoading();
  @override
  List<Object> get props => null;
}

class PesertaSearchLoaded extends PesertaSearchState {
  final SearchPesertaModel paketModel;
  const PesertaSearchLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class PesertaSearchError extends PesertaSearchState {
  final String message;
  const PesertaSearchError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateToolbarState extends PesertaSearchState {
  final bool showSearchField;

  UpdateToolbarState({this.showSearchField});

  @override
  List<Object> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}
