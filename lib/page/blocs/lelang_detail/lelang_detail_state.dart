part of 'lelang_detail_bloc.dart';

abstract class LelangDetailState extends Equatable {
  const LelangDetailState();
}

class LelangDetailInitial extends LelangDetailState {
  const LelangDetailInitial();
  @override
  List<Object> get props => [];
}

class LelangDetailLoading extends LelangDetailState {
  const LelangDetailLoading();
  @override
  List<Object> get props => null;
}

class LelangDetailLoaded extends LelangDetailState {
  final DetailLelangModel paketModel;
  const LelangDetailLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class LelangDetailError extends LelangDetailState {
  final String message;
  const LelangDetailError(this.message);
  @override
  List<Object> get props => [message];
}
