part of 'arisan_berjalan_bloc.dart';

abstract class ArisanBerjalanSearchState extends Equatable {
  const ArisanBerjalanSearchState();
}

class ArisanBerjalanSearchInitial extends ArisanBerjalanSearchState {
  const ArisanBerjalanSearchInitial();
  @override
  List<Object> get props => [];
}

class ArisanBerjalanSearchLoading extends ArisanBerjalanSearchState {
  const ArisanBerjalanSearchLoading();
  @override
  List<Object> get props => null;
}

class ArisanBerjalanSearchLoaded extends ArisanBerjalanSearchState {
  final SearchArisanBerjalanModel paketModel;
  const ArisanBerjalanSearchLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanBerjalanSearchError extends ArisanBerjalanSearchState {
  final String message;
  const ArisanBerjalanSearchError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateToolbarState extends ArisanBerjalanSearchState {
  final bool showSearchField;

  UpdateToolbarState({this.showSearchField});

  @override
  List<Object> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}
