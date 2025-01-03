import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_bloc_event.dart';
part 'search_bloc_state.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBlocBloc() : super(SearchBarHidden()) {
    on<ToggleSearchBarEvent>((event, emit) {
      if (state is SearchBarVisible) {
        emit(SearchBarHidden());
      } else {
        emit(SearchBarVisible());
      }
    });
  }
}
