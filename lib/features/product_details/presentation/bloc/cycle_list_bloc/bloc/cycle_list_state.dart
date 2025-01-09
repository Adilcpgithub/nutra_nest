part of 'cycle_list_bloc.dart';

sealed class CycleState extends Equatable {
  const CycleState();

  @override
  List<Object> get props => [];
}

class CycleLoadingState extends CycleState {}

class CycleLoadedState extends CycleState {
  final List<Cycle> cycles;
  final Set<String> favorites;

  const CycleLoadedState(this.cycles, {this.favorites = const {}});
  @override
  List<Object> get props => [cycles, favorites];
}

class CycleErrorState extends CycleState {
  final String error;

  const CycleErrorState(this.error);
  @override
  List<Object> get props => [error];
}
