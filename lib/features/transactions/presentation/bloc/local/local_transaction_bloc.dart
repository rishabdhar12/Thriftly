import 'package:budgeting_app/core/usecase/usecase.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/edit_transaction_usecase.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/get_transactions_by_categoryid_usecase.dart';
import 'package:budgeting_app/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_event.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalTransactionBloc
    extends Bloc<LocalTransactionEvent, LocalTransactionState> {
  final AddTransactionUsecase addTransactionUsecase;
  final GetTransactionsByCategoryIdUsecase getTransactionsByCategoryIdUsecase;
  final EditTransactionUsecase editTransactionsUsecase;
  final DeleteTransactionUsecase deleteTransactionUsecase;
  final GetTransactionsUsecase getTransactionsUsecase;

  LocalTransactionBloc({
    required this.addTransactionUsecase,
    required this.getTransactionsByCategoryIdUsecase,
    required this.editTransactionsUsecase,
    required this.deleteTransactionUsecase,
    required this.getTransactionsUsecase,
  }) : super(LocalTransactionInitialState()) {
    on<AddTransactionEvent>(_onAddTransaction);
    on<GetTransactionByCategoryIdEvent>(_onGetTransactionByCategoryId);
    on<EditTransactionEvent>(_onEditTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<GetTransactionsEvent>(_onGetTransactions);
  }

  Future<void> _onAddTransaction(
      AddTransactionEvent event, Emitter<LocalTransactionState> emit) async {
    emit(LocalTransactionLoadingState());

    try {
      final addTransactionResponse = await addTransactionUsecase(event.params);

      if (addTransactionResponse.isLeft()) {
        final failure = addTransactionResponse.getLeft().toNullable();
        emit(LocalTransactionErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final getTransactionResponse =
          await getTransactionsByCategoryIdUsecase(event.params.categoryId);

      if (getTransactionResponse.isLeft()) {
        final failure = getTransactionResponse.getLeft().toNullable();
        emit(LocalTransactionErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final transaction = getTransactionResponse.getRight().toNullable();
      emit(LocalTransactionsFetchedState(transaction ?? []));
    } catch (error) {
      emit(LocalTransactionErrorState(error.toString()));
    }
  }

  Future<void> _onEditTransaction(
      EditTransactionEvent event, Emitter<LocalTransactionState> emit) async {
    emit(LocalTransactionLoadingState());

    try {
      final editTransactionResponse =
          await editTransactionsUsecase(event.params);

      if (editTransactionResponse.isLeft()) {
        final failure = editTransactionResponse.getLeft().toNullable();
        emit(LocalTransactionErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final getTransactionResponse =
          await getTransactionsByCategoryIdUsecase(event.params.categoryId);

      if (getTransactionResponse.isLeft()) {
        final failure = getTransactionResponse.getLeft().toNullable();
        emit(LocalTransactionErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final transaction = getTransactionResponse.getRight().toNullable();
      emit(LocalTransactionsFetchedState(transaction ?? []));
    } catch (error) {
      emit(LocalTransactionErrorState(error.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
      DeleteTransactionEvent event, Emitter<LocalTransactionState> emit) async {
    emit(LocalTransactionLoadingState());

    try {
      final deleteTransactionResponse =
          await deleteTransactionUsecase(event.params);

      if (deleteTransactionResponse.isLeft()) {
        final failure = deleteTransactionResponse.getLeft().toNullable();
        emit(LocalTransactionErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final getTransactionResponse =
          await getTransactionsByCategoryIdUsecase(event.params.categoryId);

      if (getTransactionResponse.isLeft()) {
        final failure = getTransactionResponse.getLeft().toNullable();
        emit(LocalTransactionErrorState(failure?.message ?? "Unknown error"));
        return;
      }

      final transaction = getTransactionResponse.getRight().toNullable();
      emit(LocalTransactionsFetchedState(transaction ?? []));
    } catch (error) {
      emit(LocalTransactionErrorState(error.toString()));
    }
  }

  Future<void> _onGetTransactionByCategoryId(
      GetTransactionByCategoryIdEvent event,
      Emitter<LocalTransactionState> emit) async {
    emit(LocalTransactionLoadingState());
    try {
      final response =
          await getTransactionsByCategoryIdUsecase(event.categoryId);
      response
          .fold((failure) => emit(LocalTransactionErrorState(failure.message)),
              (transactions) {
        emit(LocalTransactionsFetchedState(transactions));
      });
    } catch (error) {
      emit(LocalTransactionErrorState(error.toString()));
    }
  }

  Future<void> _onGetTransactions(
      GetTransactionsEvent event, Emitter<LocalTransactionState> emit) async {
    emit(LocalTransactionLoadingState());
    try {
      final response = await getTransactionsUsecase(NoParams());
      response.fold(
        (failure) => emit(LocalTransactionErrorState(failure.message)),
        (transactions) => emit(LocalTransactionsFetchedState(transactions)),
      );
    } catch (error) {
      emit(LocalTransactionErrorState(error.toString()));
    }
  }
}
