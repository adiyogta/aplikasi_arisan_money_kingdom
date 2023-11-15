part of 'arisan_menang_bloc.dart';

abstract class ArisanMenangState extends Equatable {
  const ArisanMenangState();
}

class ArisanMenangInitial extends ArisanMenangState {
  const ArisanMenangInitial();
  @override
  List<Object> get props => [];
}

class ArisanMenangLoading extends ArisanMenangState {
  const ArisanMenangLoading();
  @override
  List<Object> get props => null;
}

class ArisanMenangLoaded extends ArisanMenangState {
  final ArisanMenangModel paketModel;
  const ArisanMenangLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanMenangError extends ArisanMenangState {
  final String message;
  const ArisanMenangError(this.message);
  @override
  List<Object> get props => [message];
}
