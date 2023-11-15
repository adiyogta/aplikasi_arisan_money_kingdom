import 'package:aplikasi_arisan/page/model/owner_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'owner_state.dart';
part 'owner_event.dart';

class OwnerBloc extends Bloc<OwnerEvent, OwnerState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  OwnerState get initialState => OwnerInitial();

  @override
  Stream<OwnerState> mapEventToState(
    OwnerEvent event,
  ) async* {
    if (event is GetOwnerList) {
      try {
        yield OwnerLoading();
        final mList = await _apiRepository.owner();
        yield OwnerLoaded(mList);
        if (mList.error != null) {
          yield OwnerError(mList.error);
        }
      } on NetworkError {
        yield OwnerError("Failed to fetch data. is your device online?");
      }
    }
  }
}
