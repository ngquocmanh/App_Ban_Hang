
import 'package:app_01/Review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'ReviewProvider.dart';
import 'Sanpham.dart';

class ReviewPage extends StatefulWidget {
  final String productName;
  const ReviewPage({super.key, required this.productName});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 3;
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final productReviews = reviewProvider.reviews
        .where((r) => r.productName == widget.productName)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Đánh giá ${widget.productName}')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              maxRating: 5,
              allowHalfRating: true,
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                _rating = rating;
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Nhập nhận xét',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_commentController.text.isNotEmpty) {
                  reviewProvider.addReview(Review(
                    productName: widget.productName,
                    rating: _rating,
                    comment: _commentController.text,
                  ));
                  _commentController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã gửi đánh giá')));
                }
              },
              child: Text('Gửi đánh giá'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: productReviews.length,
                itemBuilder: (context, index) {
                  final review = productReviews[index];
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text('${review.rating} ⭐'),
                    subtitle: Text(review.comment),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
