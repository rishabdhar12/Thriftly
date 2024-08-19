import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_event.dart';
import 'package:budgeting_app/features/home/presentation/views/bloc/bottom_navigation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const HomeState()) {
    on<HomeEvent>(_onLoadHome);
    on<AnalysisEvent>(_onLoadAnalysis);
    on<TransactionEvent>(_onLoadTransaction);
    on<CategoriesTxnEvent>(_onLoadCategoriesTxn);
    on<ProfileEvent>(_onLoadProfile);
  }

  void _onLoadHome(HomeEvent event, Emitter<BottomNavigationState> emit) {
    emit(const HomeState());
  }

  void _onLoadAnalysis(
      AnalysisEvent event, Emitter<BottomNavigationState> emit) {
    emit(const AnalysisState());
  }

  void _onLoadTransaction(
      TransactionEvent event, Emitter<BottomNavigationState> emit) {
    emit(const TransactionState());
  }

  void _onLoadCategoriesTxn(
      CategoriesTxnEvent event, Emitter<BottomNavigationState> emit) {
    emit(const CategoriesTxnState());
  }

  void _onLoadProfile(ProfileEvent event, Emitter<BottomNavigationState> emit) {
    emit(const ProfileState());
  }
}
