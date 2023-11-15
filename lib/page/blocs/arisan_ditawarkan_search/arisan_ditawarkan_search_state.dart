part of 'arisan_ditawarkan_search_bloc.dart';

abstract class ArisanDitawarkanSearchState extends Equatable {
  const ArisanDitawarkanSearchState();
}

class ArisanDitawarkanSearchInitial extends ArisanDitawarkanSearchState {
  const ArisanDitawarkanSearchInitial();
  @override
  List<Object> get props => [];
}

class ArisanDitawarkanSearchLoading extends ArisanDitawarkanSearchState {
  const ArisanDitawarkanSearchLoading();
  @override
  List<Object> get props => null;
}

class ArisanDitawarkanSearchLoaded extends ArisanDitawarkanSearchState {
  final SearchArisanDitawarkanModel paketModel;
  const ArisanDitawarkanSearchLoaded(this.paketModel);
  @override
  List<Object> get props => [paketModel];
}

class ArisanDitawarkanSearchError extends ArisanDitawarkanSearchState {
  final String message;
  const ArisanDitawarkanSearchError(this.message);
  @override
  List<Object> get props => [message];
}

class UpdateToolbarState extends ArisanDitawarkanSearchState {
  final bool showSearchField;

  UpdateToolbarState({this.showSearchField});

  @override
  List<Object> get props => [showSearchField];

  @override
  String toString() {
    return 'UpdateSearchIconState{showSearchIcon: $showSearchField}';
  }
}
