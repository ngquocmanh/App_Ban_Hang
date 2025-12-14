import 'dart:io';
import 'package:app_01/Home_page/DatBan.dart';
import 'package:app_01/Home_page/LichSuMuaHang.dart';
import 'package:app_01/Home_page/Search.dart';
import 'package:app_01/Home_page/Setting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_01/Provider/CardProvider.dart';
import 'package:app_01/product/ChiTietSanPham.dart';
import 'package:app_01/db/productDB.dart';
import 'package:app_01/product/Sanpham.dart';
import 'package:app_01/Pay/Thanhtoan.dart';

class TrangChu extends StatefulWidget {
  final int userId;
  const TrangChu({super.key,required this.userId});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  String? _username;
  int _selectedIndex = 1;

  List<Product2> productfood = [];
  List<Product2> productdrink = [];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
    _loadProducts();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Người dùng';
    });
  }

  Future<void> _loadProducts() async {
    final allProducts = await ProductDatabase.instance.getProducts();
    setState(() {
      productfood = allProducts.where((p) => p.type == 'food').toList();
      productdrink = allProducts.where((p) => p.type == 'drink').toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Hi, ${_username ?? ''}',
                  style: TextStyle(color: Colors.red)),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductSearch()));
                },
                icon: Icon(Icons.search_rounded, color: Colors.white),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Đồ ăn',
                  icon: Icon(Icons.fastfood, color: Colors.white)),
              Tab(text: 'Đồ uống',
                  icon: Icon(Icons.free_breakfast, color: Colors.white)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildProductList(productfood),
            buildProductList(productdrink),
          ],
        ),
        floatingActionButton: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Pay2()),
                    );
                  },
                  child:  Icon(Icons.shopping_cart, color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                if (cartProvider.cartCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartProvider.cartCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          color: Colors.black,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildBottomNavItem(Icons.home, "Trang chủ", 1, () {
                  setState(() => _selectedIndex = 1);
                }),
                buildBottomNavItem(
                    Icons.calendar_month_outlined, "Đặt bàn", 2, () {
                  setState(() => _selectedIndex = 2);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DatBan(userId: widget.userId)));
                }),
                buildBottomNavItem(Icons.history, "Lịch sử", 3, () {
                  setState(() => _selectedIndex = 3);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LichSuMuaHang(userId: widget.userId)),
                  );
                }),
                buildBottomNavItem(Icons.settings, "Cài đặt", 4, () {
                  setState(() => _selectedIndex = 4);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Setting(userId: widget.userId)),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildProductList(List<Product2> products) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(0, 180, 0, 0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.6,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return buildProductCard(products[index]);
      },
    );
  }
  Widget buildProductCard(Product2 product) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Colors.white, width: 1.5),
      ),
      elevation: 6,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chitietsanpham(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: product.image1.startsWith('http')
                    ? Image.network(product.image1, fit: BoxFit.cover)
                    : Image.file(File(product.image1), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${NumberFormat.decimalPattern('vi').format(
                        product.price)} VND",
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text('${product.name1} đã được thêm vào giỏ hàng!'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: const Size.fromHeight(35),
                      elevation: 6,
                    ),
                    child: const Text(
                      "Chọn",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavItem(IconData icon, String label, int index,
      VoidCallback onTap) {
    bool isSelected = _selectedIndex == index;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: const Size(60, 60),
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: isSelected ? Colors.blue : Colors.white),
          Text(label,
              style: TextStyle(color: isSelected ? Colors.blue : Colors.white)),
        ],
      ),
    );
  }
}
