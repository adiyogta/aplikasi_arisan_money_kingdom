part of 'arisan_ditawarkan_bloc.dart';

abstract class ArisanDitawarkanState extends Equatable {
  const ArisanDitawarkanState();
}

class ArisanDitawarkanInitial extends ArisanDitawarkanState {
  const ArisanDitawarkanInitial();
  @override
  List<Object> get props => [];
}

class ArisanDitawarkanLoading extends ArisanDitawarkanState {
  const ArisanDitawarkanLoading();
  @override
  List<Object> get props => null;
}

class ArisanDitawarkanLoaded extends ArisanDitawarkanState {
  final ArisanDitawarkanList paketModel;
  const ArisanDitawarkanLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanDitawarkanError extends ArisanDitawarkanState {
  final String message;
  const ArisanDitawarkanError(this.message);
  @override
  List<Object> get props => [message];
}
