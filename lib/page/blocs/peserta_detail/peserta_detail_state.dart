part of 'peserta_detail_bloc.dart';

abstract class PesertaDetailState extends Equatable {
  const PesertaDetailState();
}

class PesertaDetailInitial extends PesertaDetailState {
  const PesertaDetailInitial();
  @override
  List<Object> get props => [];
}

class PesertaDetailLoading extends PesertaDetailState {
  const PesertaDetailLoading();
  @override
  List<Object> get props => null;
}

class PesertaDetailLoaded extends PesertaDetailState {
  final DetailPesertaModel paketModel;
  const PesertaDetailLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class PesertaDetailError extends PesertaDetailState {
  final String message;
  const PesertaDetailError(this.message);
  @override
  List<Object> get props => [message];
}
