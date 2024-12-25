part of 'cycle_bloc.dart';

sealed class CycleState extends Equatable {
  const CycleState();

  @override
  List<Object> get props => [];
}

class CycleLoadingState extends CycleState {}

class CycleLoadedState extends CycleState {
  final List<Cycle> cycles;

  const CycleLoadedState(this.cycles);
  @override
  List<Object> get props => [cycles];
}

class CycleErrorState extends CycleState {
  final String error;

  const CycleErrorState(this.error);
  @override
  List<Object> get props => [error];
}
