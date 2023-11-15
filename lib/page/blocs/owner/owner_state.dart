part of 'owner_bloc.dart';

abstract class OwnerState extends Equatable {
  const OwnerState();
}

class OwnerInitial extends OwnerState {
  const OwnerInitial();
  @override
  List<Object> get props => [];
}

class OwnerLoading extends OwnerState {
  const OwnerLoading();
  @override
  List<Object> get props => null;
}

class OwnerLoaded extends OwnerState {
  final OwnerModel paketModel;
  const OwnerLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class OwnerError extends OwnerState {
  final String message;
  const OwnerError(this.message);
  @override
  List<Object> get props => [message];
}
