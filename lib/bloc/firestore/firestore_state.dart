part of 'firestore_bloc.dart';

abstract class FirestoreState extends Equatable {
  final bool loading;
  final UserData userData;
  const FirestoreState(this.loading, this.userData);

  @override
  List<Object> get props => [];
}

class FirestoreInitialState extends FirestoreState {
  const FirestoreInitialState(UserData state) : super(false, state);
}

class FirestoreAddIncomeState extends FirestoreState {
  const FirestoreAddIncomeState(UserData userData) : super(false, userData);
}

class FirestoreAddExpenseState extends FirestoreState {
  const FirestoreAddExpenseState(UserData userData) : super(false, userData);
}

class FirestoreRemoveIncomeState extends FirestoreState {
  const FirestoreRemoveIncomeState(UserData userData) : super(false, userData);
}

class FirestoreRemoveExpenseState extends FirestoreState {
  const FirestoreRemoveExpenseState(UserData userData) : super(false, userData);
}

class FirestoreUpdateIncomeState extends FirestoreState {
  const FirestoreUpdateIncomeState(UserData userData) : super(false, userData);
}

class FirestoreUpdateExpenseState extends FirestoreState {
  const FirestoreUpdateExpenseState(UserData userData) : super(false, userData);
}

class FirestoreUpdateIncomeSuccessState extends FirestoreState {
  final double totalIncome;
  const FirestoreUpdateIncomeSuccessState(this.totalIncome, UserData userData)
      : super(false, userData);
}

class FirestoreUpdateExpenseSuccessState extends FirestoreState {
  final double totalExpense;
  const FirestoreUpdateExpenseSuccessState(this.totalExpense, UserData userData)
      : super(false, userData);
}

class FirestoreGetAllIncomesState extends FirestoreState {
  const FirestoreGetAllIncomesState(UserData userData) : super(false, userData);
}

class FirestoreGetAllExpensesState extends FirestoreState {
  const FirestoreGetAllExpensesState(UserData userData)
      : super(false, userData);
}

class FirestoreGetIncomeSuccessState extends FirestoreState {
  const FirestoreGetIncomeSuccessState(UserData userData)
      : super(false, userData);
}

class FirestoreSuccessState extends FirestoreState {
  const FirestoreSuccessState(UserData userData) : super(false, userData);
}

class FirestoreGetExpenseSuccessState extends FirestoreState {
  const FirestoreGetExpenseSuccessState(UserData userData)
      : super(false, userData);
}

class FirestoreFailureState extends FirestoreState {
  final String errorMessage;
  const FirestoreFailureState(this.errorMessage, UserData userData)
      : super(false, userData);
}

class FirestoreIllegalExpenseState extends FirestoreState {
  final String errorMessage;
  const FirestoreIllegalExpenseState(this.errorMessage, UserData userData)
      : super(false, userData);
}

class FirestoreUnauthorizedState extends FirestoreState {
  const FirestoreUnauthorizedState(UserData userData) : super(false, userData);
}

class FirestoreAuthorizedState extends FirestoreState {
  const FirestoreAuthorizedState(UserData userdata) : super(false, userdata);
}
