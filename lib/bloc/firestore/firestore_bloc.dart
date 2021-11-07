import 'package:bloc/bloc.dart';
import 'package:cryptowallet/models/expense.dart';
import 'package:cryptowallet/models/income.dart';
import 'package:cryptowallet/models/user_data.dart';
import 'package:cryptowallet/repository/firestore_repository.dart';
import 'package:equatable/equatable.dart';

part 'firestore_event.dart';
part 'firestore_state.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  FirestoreBloc() : super(FirestoreInitialState(UserData.empty()));
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  Stream<FirestoreState> _mapAddIncomeToState(
      FirestoreAddIncomeEvent event) async* {
    try {
      await _firestoreRepository.addIncome(event.income);
      final UserData? userData = await _firestoreRepository.getAllUserData();
      if (userData == null) {
        yield FirestoreUnauthorizedState(state.userData);
      } else {
        yield FirestoreSuccessState(userData);
      }
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapAddExpenseToState(
      FirestoreAddExpenseEvent event) async* {
    try {
      if ((event.expense.amount + state.userData.totalExpense) >
          state.userData.totalIncome) {
        yield FirestoreIllegalExpenseState(
            'Total expense cannot be greater than total income',
            state.userData);
        return;
      }
      await _firestoreRepository.addExpense(event.expense);
      final UserData? userData = await _firestoreRepository.getAllUserData();
      if (userData == null) {
        yield FirestoreUnauthorizedState(state.userData);
      } else {
        yield FirestoreSuccessState(userData);
      }
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapRemoveIncomeToState(
      FirestoreRemoveIncomeEvent event) async* {
    try {
      await _firestoreRepository.removeIncome(event.income);
      final UserData? userData = await _firestoreRepository.getAllUserData();
      if (userData == null) {
        yield FirestoreUnauthorizedState(state.userData);
      } else {
        yield FirestoreSuccessState(userData);
      }
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapRemoveExpenseToState(
      FirestoreRemoveExpenseEvent event) async* {
    try {
      await _firestoreRepository.removeExpense(event.expense);
      final UserData? userData = await _firestoreRepository.getAllUserData();
      if (userData == null) {
        yield FirestoreUnauthorizedState(state.userData);
      } else {
        yield FirestoreSuccessState(userData);
      }
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapGetAllIncomesToState(
      FirestoreGetAllIncomesEvent event) async* {
    try {
      var incomes = await _firestoreRepository.getAllIncomes();
      yield FirestoreGetIncomeSuccessState(
          state.userData.copyWith(incomes: incomes));
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapAddGetExpensesToState(
      FirestoreGetAllExpensesEvent event) async* {
    try {
      final expenses = await _firestoreRepository.getAllExpenses();
      yield FirestoreGetExpenseSuccessState(
          state.userData.copyWith(expense: expenses));
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapUpdateIncomeToState(
      FirestoreUpdateIncomeEvent event) async* {
    try {
      final totalIncome = await _firestoreRepository.updateIncome();
      yield FirestoreUpdateIncomeSuccessState(totalIncome, state.userData);
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapUpdateExpenseToState(
      FirestoreUpdateExpenseEvent event) async* {
    try {
      final totalExpense = await _firestoreRepository.updateExpense();
      yield FirestoreUpdateExpenseSuccessState(totalExpense, state.userData);
    } catch (e) {
      yield FirestoreFailureState(e.toString(), state.userData);
    }
  }

  Stream<FirestoreState> _mapUpdateUserDataToState(
      FirestoreUpdateUserDataEvent event) async* {
    try {
      final UserData? userData = await _firestoreRepository.getAllUserData();
      if (userData == null) {
        yield FirestoreUnauthorizedState(state.userData);
      } else {
        yield FirestoreAuthorizedState(userData);
      }
    } catch (e) {
      yield FirestoreUnauthorizedState(state.userData);
    }
  }

  @override
  Stream<FirestoreState> mapEventToState(
    FirestoreEvent event,
  ) async* {
    switch (event.runtimeType) {
      case FirestoreAddIncomeEvent:
        yield* _mapAddIncomeToState(event as FirestoreAddIncomeEvent);
        break;

      case FirestoreAddExpenseEvent:
        yield* _mapAddExpenseToState(event as FirestoreAddExpenseEvent);
        break;

      case FirestoreRemoveIncomeEvent:
        yield* _mapRemoveIncomeToState(event as FirestoreRemoveIncomeEvent);

        break;

      case FirestoreRemoveExpenseEvent:
        yield* _mapRemoveExpenseToState(event as FirestoreRemoveExpenseEvent);

        break;

      case FirestoreUpdateIncomeEvent:
        yield* _mapUpdateIncomeToState(event as FirestoreUpdateIncomeEvent);
        break;

      case FirestoreUpdateExpenseEvent:
        yield* _mapUpdateExpenseToState(event as FirestoreUpdateExpenseEvent);
        break;

      case FirestoreGetAllExpensesEvent:
        yield* _mapAddGetExpensesToState(event as FirestoreGetAllExpensesEvent);
        break;

      case FirestoreGetAllIncomesEvent:
        yield* _mapGetAllIncomesToState(event as FirestoreGetAllIncomesEvent);
        break;

      case FirestoreUpdateUserDataEvent:
        yield* _mapUpdateUserDataToState(event as FirestoreUpdateUserDataEvent);
        break;

      default:
    }
  }
}
