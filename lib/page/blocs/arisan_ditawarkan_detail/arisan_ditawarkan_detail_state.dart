part of 'arisan_ditawarkan_detail_bloc.dart';

abstract class ArisanDitawarkanDetailState extends Equatable {
  const ArisanDitawarkanDetailState();
}

class ArisanDitawarkanDetailInitial extends ArisanDitawarkanDetailState {
  const ArisanDitawarkanDetailInitial();
  @override
  List<Object> get props => [];
}

class ArisanDitawarkanDetailLoading extends ArisanDitawarkanDetailState {
  const ArisanDitawarkanDetailLoading();
  @override
  List<Object> get props => null;
}

class ArisanDitawarkanDetailLoaded extends ArisanDitawarkanDetailState {
  final DetailArisanDitawarkan paketModel;
  const ArisanDitawarkanDetailLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanDitawarkanDetailError extends ArisanDitawarkanDetailState {
  final String message;
  const ArisanDitawarkanDetailError(this.message);
  @override
  List<Object> get props => [message];
}
