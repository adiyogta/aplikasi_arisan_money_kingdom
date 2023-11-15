import 'package:aplikasi_arisan/page/model/bank_model.dart';
import 'package:aplikasi_arisan/resources/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'bank_state.dart';
part 'bank_event.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final ApiRepository _apiRepository = ApiRepository();

  @override
  BankState get initialState => BankInitial();

  @override
  Stream<BankState> mapEventToState(
    BankEvent event,
  ) async* {
    if (event is GetBankList) {
      try {
        yield BankLoading();
        final mList = await _apiRepository.fetchBankList();
        yield BankLoaded(mList);
        if (mList.error != null) {
          yield BankError(mList.error);
        }
      } on NetworkError {
        yield BankError("Failed to fetch data. is your device online?");
      }
    }
  }
}
