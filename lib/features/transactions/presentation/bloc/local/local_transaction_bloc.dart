import 'package:budgeting_app/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_event.dart';
import 'package:budgeting_app/features/transactions/presentation/bloc/local/local_transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalTransactionBloc
    extends Bloc<LocalTransactionEvent, LocalTransactionState> {
  final AddTransactionUsecase addTransactionUsecase;

  LocalTransactionBloc({
    required this.addTransactionUsecase,
  }) : super(LocalTransactionInitialState()) {
    on<AddTransactionEvent>(_onAddTransaction);
  }

  Future<void> _onAddTransaction(
      AddTransactionEvent event, Emitter<LocalTransactionState> emit) async {
    emit(LocalTransactionLoadingState());
    try {
      final response = await addTransactionUsecase(event.transaction);
      response.fold(
        (failure) => LocalTransactionErrorState(failure.message),
        (transaction) => LocalTransactionFinishedState(transaction),
      );
    } catch (error) {
      emit(LocalTransactionErrorState(error.toString()));
    }
  }
}
