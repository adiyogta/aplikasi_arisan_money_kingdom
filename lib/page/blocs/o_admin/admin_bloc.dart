import 'package:aplikasi_arisan/page/model/admin_me_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'admin_state.dart';
part 'admin_event.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  AdminState get initialState => AdminInitial();

  @override
  Stream<AdminState> mapEventToState(
    AdminEvent event,
  ) async* {
    if (event is GetAdminList) {
      try {
        yield AdminLoading();
        final mList = await _apiRepository.admin();
        yield AdminLoaded(mList);
        if (mList.error != null) {
          yield AdminError(mList.error);
        }
      } on NetworkError {
        yield AdminError("Failed to fetch data. is your device online?");
      }
    }
  }
}
