import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:nutra_nest/features/home/data/models/review_model.dart';

part 'review_event.dart';
part 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ReviewBloc() : super(ReviewInitial()) {
    on<FetchReviewsEvent>(_onFetchReviews);
    on<AddReviewEvent>(_onAddReview);
  }
  Future<void> _onFetchReviews(
      FetchReviewsEvent event, Emitter<ReviewState> emit) async {
    emit(ReviewLoading());
    try {
      final snapshot = await _firestore
          .collection('cycles')
          .doc(event.productId)
          .collection('reviews')
          .orderBy('date', descending: true)
          .get();

      final reviews =
          snapshot.docs.map((doc) => Review.fromFirestore(doc)).toList();

      emit(ReviewsLoaded(reviews));
    } catch (e) {
      emit(ReviewError('Failed to fetch reviews: $e'));
    }
  } // Handle adding a new review

  Future<void> _onAddReview(
      AddReviewEvent event, Emitter<ReviewState> emit) async {
    try {
      final reviewRef = _firestore
          .collection('cycles')
          .doc(event.productId)
          .collection('reviews')
          .doc();

      await reviewRef.set(event.review.toMap());

      emit(ReviewAdded(event.review));

      // Fetch updated reviews after adding
      add(FetchReviewsEvent(event.productId));
    } catch (e) {
      emit(ReviewError('Failed to add review: $e'));
    }
  }
}
