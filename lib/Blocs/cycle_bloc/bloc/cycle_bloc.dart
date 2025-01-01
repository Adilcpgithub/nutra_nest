import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/model/cycle.dart';

part 'cycle_event.dart';
part 'cycle_state.dart';

class CycleBloc extends Bloc<CycleEvent, CycleState> {
  CycleBloc() : super(CycleLoadingState()) {
    on<LoadCycleByType>(_fetchCycles);
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
      emit(CycleLoadedState(newCycles));
      print('ssssssssssssss');
      print(newCycles);
      log(' new cycles length is ${newCycles.length}');
    } catch (e) {
      emit(CycleErrorState(e.toString()));
    }
  }
}
