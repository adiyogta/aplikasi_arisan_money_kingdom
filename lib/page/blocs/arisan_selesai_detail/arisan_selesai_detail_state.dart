part of 'arisan_selesai_detail_bloc.dart';

abstract class ArisanSelesaiDetailState extends Equatable {
  const ArisanSelesaiDetailState();
}

class ArisanSelesaiDetailInitial extends ArisanSelesaiDetailState {
  const ArisanSelesaiDetailInitial();
  @override
  List<Object> get props => [];
}

class ArisanSelesaiDetailLoading extends ArisanSelesaiDetailState {
  const ArisanSelesaiDetailLoading();
  @override
  List<Object> get props => null;
}

class ArisanSelesaiDetailLoaded extends ArisanSelesaiDetailState {
  final ArisanSelesaiDetailModel paketModel;
  const ArisanSelesaiDetailLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanSelesaiDetailError extends ArisanSelesaiDetailState {
  final String message;
  const ArisanSelesaiDetailError(this.message);
  @override
  List<Object> get props => [message];
}
