part of 'firestore_bloc.dart';

abstract class FirestoreEvent extends Equatable {
  const FirestoreEvent();

  @override
  List<Object> get props => [];
}

class FirestoreAddExpenseEvent extends FirestoreEvent {
  final Expense expense;

  const FirestoreAddExpenseEvent(this.expense);
}

class FirestoreRemoveExpenseEvent extends FirestoreEvent {
  final Expense expense;

  const FirestoreRemoveExpenseEvent(this.expense);
}

class FirestoreAddIncomeEvent extends FirestoreEvent {
  final Income income;

  const FirestoreAddIncomeEvent(this.income);
}

class FirestoreRemoveIncomeEvent extends FirestoreEvent {
  final Income income;

  const FirestoreRemoveIncomeEvent(this.income);
}

class FirestoreUpdateIncomeEvent extends FirestoreEvent {
  const FirestoreUpdateIncomeEvent();
}

class FirestoreGetAllExpensesEvent extends FirestoreEvent {}

class FirestoreGetAllIncomesEvent extends FirestoreEvent {}

class FirestoreUpdateExpenseEvent extends FirestoreEvent {}

class FirestoreUpdateUserDataEvent extends FirestoreEvent {
  const FirestoreUpdateUserDataEvent();
}
