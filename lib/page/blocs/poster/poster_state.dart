part of 'poster_bloc.dart';

abstract class PosterState extends Equatable {
  const PosterState();
}

class PosterInitial extends PosterState {
  const PosterInitial();
  @override
  List<Object> get props => [];
}

class PosterLoading extends PosterState {
  const PosterLoading();
  @override
  List<Object> get props => null;
}

class PosterLoaded extends PosterState {
  final PosterModel paketModel;
  const PosterLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class PosterError extends PosterState {
  final String message;
  const PosterError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateToolbarState extends PosterState {
  final bool showSearchField;

  UpdateToolbarState({this.showSearchField});

  @override
  List<Object> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}
