import 'package:flutter/foundation.dart';
import '../Review/Review.dart';

class ReviewProvider with ChangeNotifier {
  final List<Review> _reviews = [];

  List<Review> get reviews => _reviews;

  void addReview(Review review) {
    _reviews.add(review);
    notifyListeners();
  }
  List<Review> getReviewsForProduct(String productName) {
    return _reviews.where((r) => r.productName == productName).toList();
  }
}
