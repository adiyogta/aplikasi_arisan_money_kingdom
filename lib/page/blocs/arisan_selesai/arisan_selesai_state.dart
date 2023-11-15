part of 'arisan_selesai_bloc.dart';

abstract class ArisanSelesaiState extends Equatable {
  const ArisanSelesaiState();
}

class ArisanSelesaiInitial extends ArisanSelesaiState {
  const ArisanSelesaiInitial();
  @override
  List<Object> get props => [];
}

class ArisanSelesaiLoading extends ArisanSelesaiState {
  const ArisanSelesaiLoading();
  @override
  List<Object> get props => null;
}

class ArisanSelesaiLoaded extends ArisanSelesaiState {
  final ArisanSelesaiModel paketModel;
  const ArisanSelesaiLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanSelesaiError extends ArisanSelesaiState {
  final String message;
  const ArisanSelesaiError(this.message);
  @override
  List<Object> get props => [message];
}
