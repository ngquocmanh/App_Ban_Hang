import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app_01/db/productDB.dart';
import 'package:app_01/product/Sanpham.dart';
import '../product/ChiTietSanPham.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  List<Product2> searchResults = [];
  final TextEditingController searchCtrl = TextEditingController();
  final PageController bannerCtrl = PageController();

  @override
  void initState() {
    super.initState();
    searchCtrl.addListener(_searchProducts);
  }

  Future<void> _searchProducts() async {
    final query = searchCtrl.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() => searchResults = []);
      return;
    }

    final allProducts = await ProductDatabase.instance.getProducts();
    setState(() {
      searchResults = allProducts
          .where((p) => p.name1.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    bannerCtrl.dispose();
    super.dispose();
  }
  Widget _buildBanner(String img, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Image.asset(
                img,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                alignment: Alignment.bottomLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(color: Colors.black, blurRadius: 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f7f7),
      appBar: AppBar(
        title: const Text(
          "Tìm kiếm món ăn",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: TextField(
              controller: searchCtrl,
              decoration: InputDecoration(
                labelText: "Nhập tên sản phẩm...",
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, size: 28),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide:
                  const BorderSide(color: Colors.deepOrangeAccent, width: 2),
                ),
              ),
            ),
          ),
          if (searchCtrl.text.isEmpty)
            SizedBox(
              height: 140,
              child: PageView(
                controller: bannerCtrl,
                children: [
                  _buildBanner("assets/images/Image1.png", "Giảm giá 20% hôm nay!"),
                  _buildBanner("assets/images/Image2.png", "Combo 2 người siêu rẻ"),
                  _buildBanner("assets/images/Image3.jpg", "Món mới vừa cập nhật"),
                ],
              ),
            ),
          const SizedBox(height: 10),
          if (searchResults.isEmpty && searchCtrl.text.isEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.fastfood_rounded, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    "Nhập từ khóa để tìm món ăn...",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          else if (searchResults.isEmpty && searchCtrl.text.isNotEmpty)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.search_off_outlined, size: 100, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    "Không tìm thấy sản phẩm nào",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                    itemCount: searchResults.length,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemBuilder: (context, index) {
                      final product = searchResults[index];
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Chitietsanpham(product: product),
                            ),
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                File(product.image1),
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              product.name1,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Giá: ${product.price} VNĐ\nSố lượng: ${product.quantity}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87),
                            ),
                            trailing:
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ),
                      );
               }
               ),
          ),
        ],
      ),
    );
  }
}
