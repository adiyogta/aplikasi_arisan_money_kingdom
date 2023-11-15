part of 'lelang_bloc.dart';

abstract class LelangState extends Equatable {
  const LelangState();
}

class LelangInitial extends LelangState {
  const LelangInitial();
  @override
  List<Object> get props => [];
}

class LelangLoading extends LelangState {
  const LelangLoading();
  @override
  List<Object> get props => null;
}

class LelangLoaded extends LelangState {
  final LelangModel paketModel;
  const LelangLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class LelangError extends LelangState {
  final String message;
  const LelangError(this.message);
  @override
  List<Object> get props => [message];
}
