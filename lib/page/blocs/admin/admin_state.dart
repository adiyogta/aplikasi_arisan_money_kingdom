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
  final ListAdminModel adminModel;
  const AdminLoaded(this.adminModel);
  @override
  List<Object> get props => [adminModel];
}

class AdminError extends AdminState {
  final String message;
  const AdminError(this.message);
  @override
  List<Object> get props => [message];
}
