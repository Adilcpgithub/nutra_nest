part of 'search_bloc_bloc.dart';

sealed class SearchBlocEvent extends Equatable {
  const SearchBlocEvent();

  @override
  List<Object> get props => [];
}

class ToggleSearchBarEvent extends SearchBlocEvent {}
