import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  final String userId;
  final String userName;
  final String comment;
  final double rating;
  final DateTime date;

  Review({
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.date,
  });

  // Convert Review object to JSON for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userName': userName,
      'comment': comment,
      'rating': rating,
      'date': date.toIso8601String(),
    };
  }

  // Create Review object from Firestore document snapshot
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? 'Unknown',
      comment: map['comment'] ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      date: map['date'] != null ? DateTime.parse(map['date']) : DateTime.now(),
    );
  }

  // Create Review object from Firestore snapshot
  factory Review.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Review.fromMap(data);
  }
}
