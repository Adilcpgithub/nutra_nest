part of 'review_bloc.dart';

sealed class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

// Initial state
class ReviewInitial extends ReviewState {}

// Loading state
class ReviewLoading extends ReviewState {}

// State when reviews are successfully fetched
class ReviewsLoaded extends ReviewState {
  final List<Review> reviews;

  const ReviewsLoaded(this.reviews);

  @override
  List<Object> get props => [reviews];
}

// State when a new review is added successfully
class ReviewAdded extends ReviewState {
  final Review review;

  const ReviewAdded(this.review);

  @override
  List<Object> get props => [review];
}

// Error state
class ReviewError extends ReviewState {
  final String message;

  const ReviewError(this.message);

  @override
  List<Object> get props => [message];
}
