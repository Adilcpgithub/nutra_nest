import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/model/cycle.dart';

part 'prodoct_event.dart';
part 'prodoct_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Set<String> _favorites = {};
  ProductBloc() : super(ProductInitial()) {
    on<GetAllPoduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final cycleSnapshot = await _firestore.collection('cycles').get();
        List<Map<String, dynamic>> cycles = cycleSnapshot.docs.map((doc) {
          return {...doc.data(), 'documentId': doc.id};
        }).toList();
        log('cycle lenght is ${cycles.length}');
        cycles = cycles.where((cycle) {
          String name = cycle['name'].toString().toLowerCase();
          return name.contains(event.searchQuery.toLowerCase());
        }).toList();

        log('cycle lenght is ${cycles.length}');
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
        emit(ProductLoadedState(newCycles, favorites: _favorites));
      } catch (e) {
        log(e.toString());
        emit(ProductError(e.toString()));
      }
    });
    on<ProductInitialEvent>((event, emit) {
      emit(ProductInitial());
    });
  }
}
