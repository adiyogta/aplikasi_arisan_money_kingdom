part of 'bank_bloc.dart';

abstract class BankEvent extends Equatable {
  const BankEvent();
}

class GetBankList extends BankEvent {
  @override
  List<Object> get props => null;
}

class SearchTextChangedEvent extends BankEvent {
  final String searchTerm;

  SearchTextChangedEvent({@required this.searchTerm})
      : assert(searchTerm != null);

  @override
  List<Object> get props => null;
}
