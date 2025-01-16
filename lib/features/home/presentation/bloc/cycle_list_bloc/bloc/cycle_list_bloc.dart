import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/model/cycle.dart';

part 'cycle_list_event.dart';
part 'cycle_list_state.dart';

class CycleBloc extends Bloc<CycleEvent, CycleState> {
  CycleBloc()
      : super(
          CycleLoadingState(),
        ) {
    on<LoadCycleByType>(_fetchCycles);
    on<ToggleFavoriteEvent>(_toggleFavorite);
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Set<String> _favorites = {};
  _fetchCycles(LoadCycleByType event, Emitter<CycleState> emit) async {
    emit(CycleLoadingState());
    try {
      final cycleSnapshot = await _firestore
          .collection('cycles')
          .where('category', isEqualTo: event.type)
          .get();
      List<Map<String, dynamic>> cycles = cycleSnapshot.docs.map((doc) {
        return {...doc.data(), 'documentId': doc.id};
      }).toList();
      log('cycles length is ${cycles.length}');
      log('cycles length is $cycles');
      List<Cycle> newCycles = cycles
          .map(
            (e) => Cycle.fromMap(e),
          )
          .toList();
      final userId = await UserStatus().getUserId();
      final snapShot =
          await _firestore.collection('favoriteCollection').doc(userId).get();
      snapShot.data();
      if (snapShot.exists) {
        Set<String> currentSet =
            Set<String>.from(snapShot.data()?['favorites'] ?? {});
        _favorites = currentSet;
      }
      emit(CycleLoadedState(newCycles, favorites: _favorites));
      print('ssssssssssssss');
      print(newCycles);
      log(' new cycles length is ${newCycles.length}');
    } catch (e) {
      emit(CycleErrorState(e.toString()));
    }
  }

  void _toggleFavorite(
      ToggleFavoriteEvent event, Emitter<CycleState> emit) async {
    if (state is CycleLoadedState) {
      final currentState = state as CycleLoadedState;
      final updatedFavorites = Set<String>.from(currentState.favorites);
      if (updatedFavorites.contains(event.productId)) {
        updatedFavorites.remove(event.productId);
        emit(
            CycleLoadedState(currentState.cycles, favorites: updatedFavorites));

        try {
          await _firestore
              .collection('favoriteCollection')
              .doc(event.userId)
              .set({'favorites': updatedFavorites});
          print("Set added to Firestore successfully!");
        } catch (e) {
          log('$e');
          print("Failed to add set to Firestore: $e");
        }
      } else {
        updatedFavorites.add(event.productId);
        emit(
            CycleLoadedState(currentState.cycles, favorites: updatedFavorites));
        try {
          await _firestore
              .collection('favoriteCollection')
              .doc(event.userId)
              .set({'favorites': updatedFavorites});
          print("Set added to Firestore successfully!");
        } catch (e) {
          log('$e');
          print("Failed to add set to Firestore: $e");
        }
      }
    }
  }
}
