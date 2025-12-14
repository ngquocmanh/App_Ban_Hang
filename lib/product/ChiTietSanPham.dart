import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Sanpham.dart';
import '../Provider/CardProvider.dart';
import '../Review/Review.dart';
import '../Provider/ReviewProvider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Chitietsanpham extends StatefulWidget {
  final Product2 product;
  const Chitietsanpham({super.key, required this.product});

  @override
  State<Chitietsanpham> createState() => _ChitietsanphamState();
}

class _ChitietsanphamState extends State<Chitietsanpham> {
  double _rating = 3;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);
    final productReviews = reviewProvider.getReviewsForProduct(widget.product.name1);

    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text(widget.product.name1,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.transparent,
         automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child:ClipRRect(borderRadius: BorderRadius.circular(16),
                  child: widget.product.image1.startsWith('http')
                     ? Image.network(widget.product.image1, fit: BoxFit.cover) : Image.file(File(widget.product.image1), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 25),
              Text(
                widget.product.name1,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 20, height: 1.5),
                  children: [
                    TextSpan(
                      text: 'Mô tả : ',
                      style: TextStyle(color: Colors.red),
                    ),
                    TextSpan(
                      text: widget.product.mota,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Giá: ${widget.product.price.toInt()} VNĐ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.red[800],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    backgroundColor: Colors.red[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                  ),
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(widget.product);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Mua ngay',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text(
                "Đánh giá sản phẩm",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              ),
              const SizedBox(height: 15),

              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                maxRating: 5,
                allowHalfRating: true,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              const SizedBox(height: 10),

              TextField(
                controller: _commentController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Nhập nhận xét...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    reviewProvider.addReview(Review(
                      productName: widget.product.name1,
                      rating: _rating,
                      comment: _commentController.text,
                    ));
                    _commentController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Đã gửi đánh giá!')));
                  }
                },
                child: const Text("Gửi đánh giá"),
              ),

              const SizedBox(height: 20),
              const Text("Các đánh giá trước:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
              const SizedBox(height: 10),

              if (productReviews.isEmpty)
                const Text("Chưa có đánh giá nào",style: TextStyle(color: Colors.white),),
              if (productReviews.isNotEmpty)
                ...productReviews.map(
                      (r) => ListTile(
                    leading: const Icon(Icons.person,color: Colors.white,),
                    title: Text('${r.rating} ⭐',style: TextStyle(color: Colors.white)),
                    subtitle: Text(r.comment,style: TextStyle(color: Colors.white),),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
