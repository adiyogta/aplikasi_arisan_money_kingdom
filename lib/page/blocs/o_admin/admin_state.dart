part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
}

class AdminInitial extends AdminState {
  const AdminInitial();
  @override
  List<Object> get props => [];
}

class AdminLoading extends AdminState {
  const AdminLoading();
  @override
  List<Object> get props => null;
}

class AdminLoaded extends AdminState {
  final AdminModel paketModel;
  const AdminLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override
  List<Object> get props => [message];
}
