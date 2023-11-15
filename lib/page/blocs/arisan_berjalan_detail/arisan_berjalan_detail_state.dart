part of 'arisan_berjalan_detail_bloc.dart';

abstract class ArisanBerjalanDetailState extends Equatable {
  const ArisanBerjalanDetailState();
}

class ArisanBerjalanDetailInitial extends ArisanBerjalanDetailState {
  const ArisanBerjalanDetailInitial();
  @override
  List<Object> get props => [];
}

class ArisanBerjalanDetailLoading extends ArisanBerjalanDetailState {
  const ArisanBerjalanDetailLoading();
  @override
  List<Object> get props => null;
}

class ArisanBerjalanDetailLoaded extends ArisanBerjalanDetailState {
  final ArisanBerjalanDetailModel paketModel;
  const ArisanBerjalanDetailLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanBerjalanDetailError extends ArisanBerjalanDetailState {
  final String message;
  const ArisanBerjalanDetailError(this.message);
  @override
  List<Object> get props => [message];
}
