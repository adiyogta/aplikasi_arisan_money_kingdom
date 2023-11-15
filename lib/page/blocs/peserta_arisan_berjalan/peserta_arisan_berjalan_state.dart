part of 'peserta_arisan_berjalan_bloc.dart';

abstract class PesertaArisanBerjalanState extends Equatable {
  const PesertaArisanBerjalanState();
}

class PesertaArisanBerjalanInitial extends PesertaArisanBerjalanState {
  const PesertaArisanBerjalanInitial();
  @override
  List<Object> get props => [];
}

class PesertaArisanBerjalanLoading extends PesertaArisanBerjalanState {
  const PesertaArisanBerjalanLoading();
  @override
  List<Object> get props => null;
}

class PesertaArisanBerjalanLoaded extends PesertaArisanBerjalanState {
  final PesertaArisanBerjalanDetailModel paketModel;
  const PesertaArisanBerjalanLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class PesertaArisanBerjalanError extends PesertaArisanBerjalanState {
  final String message;
  const PesertaArisanBerjalanError(this.message);
  @override
  List<Object> get props => [message];
}
