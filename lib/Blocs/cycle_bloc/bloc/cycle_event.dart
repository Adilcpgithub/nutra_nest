part of 'cycle_bloc.dart';

sealed class CycleEvent extends Equatable {
  const CycleEvent();

  @override
  List<Object> get props => [];
}

class LoadCycleByType extends CycleEvent {
  final String type;
  const LoadCycleByType(this.type);
  @override
  List<Object> get props => [type];
}

class SearchCycles extends CycleEvent {
  final String query;
  const SearchCycles(this.query);
  @override
  List<Object> get props => [query];
}
