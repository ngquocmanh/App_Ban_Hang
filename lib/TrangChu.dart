import 'package:app_01/CardProvider.dart';
import 'package:app_01/ChiTietSanPham.dart';
import 'package:app_01/DatBan.dart';
import 'package:app_01/LichSu.dart';
import 'package:app_01/Location.dart';
import 'package:app_01/Setting.dart';
import 'package:flutter/material.dart';
import 'package:app_01/Sanpham.dart';
import 'package:app_01/Thanhtoan.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'product.dart';
class Shop2 extends StatefulWidget {
  const Shop2({super.key});

  @override
  State<Shop2> createState() => _Shop2State();
}

class _Shop2State extends State<Shop2> {
  List<Product2> cart = [];
  int _selecIndex = 1;
  List<Product2> productfood = [
    Product2(
      name1: 'Bún Tôm',
      image1:
      'https://images.pexels.com/photos/699953/pexels-photo-699953.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 30000,
    ),
    Product2(
      name1: 'Bánh Mỳ',
      image1:
      'https://images.pexels.com/photos/1633525/pexels-photo-1633525.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
    ),
    Product2(
      name1: 'Hamburger',
      image1:
      'https://images.pexels.com/photos/1199957/pexels-photo-1199957.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 50000,
    ),
    Product2(
      name1: 'Beefsteak',
      image1:
      'https://images.pexels.com/photos/769289/pexels-photo-769289.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 150000,
    ),
    Product2(
      name1: 'Thịt Xiên Nướng',
      image1:
      'https://images.pexels.com/photos/2641886/pexels-photo-2641886.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 50000,
    ),
    Product2(
      name1: 'Pizza',
      image1:
      'https://images.pexels.com/photos/604969/pexels-photo-604969.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 150000,
    ),
    Product2(
        name1: 'Khoai tây chiên',
        image1:
        'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 15000),
    Product2(
        name1: 'Bún bò huế',
        image1:
        'https://images.pexels.com/photos/2664216/pexels-photo-2664216.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 15000),
  ];

  List<Product2> productdink = [
    Product2(
        name1: 'Cà Phê',
        image1:
        'https://images.pexels.com/photos/33928334/pexels-photo-33928334.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 50000),
    Product2(
        name1: 'Coca',
        image1:
        'https://images.pexels.com/photos/33930870/pexels-photo-33930870.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 15000),
    Product2(
        name1: 'Bia ',
        image1:
        'https://images.pexels.com/photos/33929953/pexels-photo-33929953.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 30000),
    Product2(
        name1: 'Nước ép dưa hấu',
        image1:
        'https://images.pexels.com/photos/1337825/pexels-photo-1337825.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 20000),
    Product2(
        name1: 'Chanh giã tay',
        image1:
        'https://images.pexels.com/photos/33107428/pexels-photo-33107428.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 20000),
    Product2(
        name1: 'Nước ép táo',
        image1:
        'https://images.pexels.com/photos/4551975/pexels-photo-4551975.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 15000),
    Product2(
        name1: 'Nước ép kiwi',
        image1:
        'https://images.pexels.com/photos/8679385/pexels-photo-8679385.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 15000),
    Product2(
        name1: 'Nước ép xoài',
        image1:
        'https://images.pexels.com/photos/4955257/pexels-photo-4955257.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
        price: 15000),
  ];
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.local_restaurant, color: Colors.white),
              SizedBox(width: 8),
              Text("Trang Chủ", style: TextStyle(color: Colors.white)),
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: 'Đồ ăn',
                icon: Icon(Icons.fastfood, color: Colors.white),
              ),
              Tab(
                text: 'Đồ uống',
                icon: Icon(Icons.free_breakfast, color: Colors.white),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.location_on, color: Colors.white),
            ),
          ],
        ),
        body: TabBarView(
          children: [
            buildProductList(productfood),
            buildProductList(productdink),
            //  buildProductCard2(productcombo),
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
                  child: const Icon(Icons.shopping_cart, color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.white, width: 1),
                  ),
                ),
                if (cartProvider.cartCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${cartProvider.cartCount}',
                        style: const TextStyle(
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
                TextButton(
                  onPressed: () {
                    setState(() {
                      _selecIndex = 1;
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(60, 60),
                    padding: EdgeInsets.zero,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.home, size: 28, color: _selecIndex == 1 ? Colors.blue : Colors.white),
                      Text("Trang chủ", style: TextStyle(color: _selecIndex == 1 ? Colors.blue : Colors.white)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PromoPage()));
                    setState(() {
                      _selecIndex =2;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(60, 60),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.calendar_month_outlined, size: 28,color: _selecIndex == 2 ? Colors.blue : Colors.white,),
                      Text('Đặt bàn',style: TextStyle(color: _selecIndex == 2 ? Colors.blue : Colors.white),),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Lichsu()));
                    setState(() {
                      _selecIndex = 3;
                    });
                  },
                  style: TextButton.styleFrom(
                    minimumSize: const Size(60, 60),
                    padding: EdgeInsets.zero,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.history, size: 28, color: _selecIndex ==3 ?Colors.blue :Colors.white,),
                      Text("Lịch sử",style: TextStyle(color: _selecIndex ==3 ?Colors.blue :Colors.white,),),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Setting()));
                    setState(() {
                      _selecIndex = 4;
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(60, 60),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.settings, size: 28,color: _selecIndex ==4 ?Colors.blue :Colors.white,),
                      Text('Cài đặt',style: TextStyle(color: _selecIndex ==4 ?Colors.blue :Colors.white,)),
                    ],
                  ),
                ),
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
  Widget buildProductCard2(Product2 product){
    return Card(
      child: Expanded(
          child: ClipRRect(
              child: PageView.builder(
                  itemCount: product.image1.length,
                  itemBuilder: (context, index){
                    return Image.network(
                      product.image1[index],
                      fit: BoxFit.cover,
                    );
                  }
              ))
      ),
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
                child: Image.network(
                  product.image1,
                  fit: BoxFit.cover,
                ),
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
                    "${NumberFormat.decimalPattern('vi').format(product.price)} VND",
                    style: const TextStyle(color: Colors.orangeAccent),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              '${product.name1} đã được thêm vào giỏ hàng!'),
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
}
