part of 'bank_bloc.dart';

abstract class BankState extends Equatable {
  const BankState();
}

class BankInitial extends BankState {
  const BankInitial();
  @override
  List<Object> get props => [];
}

class BankLoading extends BankState {
  const BankLoading();
  @override
  List<Object> get props => null;
}

class BankLoaded extends BankState {
  final BankModel paketModel;
  const BankLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class BankError extends BankState {
  final String message;
  const BankError(this.message);
  @override
  List<Object> get props => [message];
}
