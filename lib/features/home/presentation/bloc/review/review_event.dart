part of 'review_bloc.dart';

sealed class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object> get props => [];
}

// Event to fetch reviews for a product
class FetchReviewsEvent extends ReviewEvent {
  final String productId;

  const FetchReviewsEvent(this.productId);

  @override
  List<Object> get props => [productId];

  void add(Type fetchReviewsEvent) {}
}

// Event to add a new review
class AddReviewEvent extends ReviewEvent {
  final String productId;
  final Review review;

  const AddReviewEvent(this.productId, this.review);

  @override
  List<Object> get props => [productId, review];
}
