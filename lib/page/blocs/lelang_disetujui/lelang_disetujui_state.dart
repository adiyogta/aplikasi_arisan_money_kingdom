part of 'lelang_disetujui_bloc.dart';

abstract class LelangDisetujuiState extends Equatable {
  const LelangDisetujuiState();
}

class LelangDisetujuiInitial extends LelangDisetujuiState {
  const LelangDisetujuiInitial();
  @override
  List<Object> get props => [];
}

class LelangDisetujuiLoading extends LelangDisetujuiState {
  const LelangDisetujuiLoading();
  @override
  List<Object> get props => null;
}

class LelangDisetujuiLoaded extends LelangDisetujuiState {
  final LelangDisetujuiModel paketModel;
  const LelangDisetujuiLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class LelangDisetujuiError extends LelangDisetujuiState {
  final String message;
  const LelangDisetujuiError(this.message);
  @override
  List<Object> get props => [message];
}
