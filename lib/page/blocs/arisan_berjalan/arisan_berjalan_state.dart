part of 'arisan_berjalan_bloc.dart';

abstract class ArisanBerjalanState extends Equatable {
  const ArisanBerjalanState();
}

class ArisanBerjalanInitial extends ArisanBerjalanState {
  const ArisanBerjalanInitial();
  @override
  List<Object> get props => [];
}

class ArisanBerjalanLoading extends ArisanBerjalanState {
  const ArisanBerjalanLoading();
  @override
  List<Object> get props => null;
}

class ArisanBerjalanLoaded extends ArisanBerjalanState {
  final ArisanBerjalanModel paketModel;
  const ArisanBerjalanLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanBerjalanError extends ArisanBerjalanState {
  final String message;
  const ArisanBerjalanError(this.message);
  @override
  List<Object> get props => [message];
}
