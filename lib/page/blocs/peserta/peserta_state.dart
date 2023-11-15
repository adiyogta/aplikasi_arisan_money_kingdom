part of 'peserta_bloc.dart';

abstract class PesertaState extends Equatable {
  const PesertaState();
}

class PesertaInitial extends PesertaState {
  const PesertaInitial();
  @override
  List<Object> get props => [];
}

class PesertaLoading extends PesertaState {
  const PesertaLoading();
  @override
  List<Object> get props => null;
}

class PesertaLoaded extends PesertaState {
  final PesertaModel paketModel;
  const PesertaLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class PesertaSearchLoaded extends PesertaState {
  final PesertaModel paketModel;
  const PesertaSearchLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class PesertaError extends PesertaState {
  final String message;
  const PesertaError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateToolbarState extends PesertaState {
  final bool showSearchField;

  UpdateToolbarState({this.showSearchField});

  @override
  List<Object> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}
