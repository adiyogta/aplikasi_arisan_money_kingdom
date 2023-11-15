part of 'paket_bloc.dart';

abstract class PaketState extends Equatable {
  const PaketState();
}

class PaketInitial extends PaketState {
  const PaketInitial();
  @override
  List<Object> get props => [];
}

class PaketLoading extends PaketState {
  const PaketLoading();
  @override
  List<Object> get props => null;
}

class PaketLoaded extends PaketState {
  final ListPaketModel paketModel;
  const PaketLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class PaketError extends PaketState {
  final String message;
  const PaketError(this.message);
  @override
  List<Object> get props => [message];
}
