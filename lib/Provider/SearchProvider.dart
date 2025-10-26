import 'package:app_01/product/Sanpham.dart';
import 'package:flutter/material.dart';
class SearchProvider extends ChangeNotifier{
  final List<Product2> _allProduct = [
    Product2(
      name1: 'Bún Tôm',
      image1: 'https://images.pexels.com/photos/699953/pexels-photo-699953.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 30000,
      mota: 'Bún tươi kết hợp tôm tươi và rau thơm, nước dùng đậm đà hương vị biển.',
    ),
    Product2(
      name1: 'Bánh Mỳ',
      image1: 'https://images.pexels.com/photos/1633525/pexels-photo-1633525.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
      mota: 'Ổ bánh mì giòn rụm, nhân chả lụa – pate – rau sống thơm ngon truyền thống Việt Nam.',
    ),
    Product2(
      name1: 'Hamburger',
      image1: 'https://images.pexels.com/photos/1199957/pexels-photo-1199957.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 50000,
      mota: 'Bánh hamburger với lớp bò nướng mọng nước, phô mai tan chảy và rau tươi mát.',
    ),
    Product2(
      name1: 'Beefsteak',
      image1: 'https://images.pexels.com/photos/769289/pexels-photo-769289.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 150000,
      mota: 'Miếng bò Mỹ mềm mọng, áp chảo vừa chín tới, dùng kèm khoai tây và sốt tiêu đen.',
    ),
    Product2(
      name1: 'Thịt Xiên Nướng',
      image1: 'https://images.pexels.com/photos/2641886/pexels-photo-2641886.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 50000,
      mota: 'Thịt heo tẩm ướp gia vị đặc biệt, nướng than thơm phức, dùng kèm rau và nước chấm.',
    ),
    Product2(
      name1: 'Pizza',
      image1: 'https://images.pexels.com/photos/604969/pexels-photo-604969.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 150000,
      mota: 'Pizza đế mỏng giòn với phô mai mozzarella, sốt cà chua và topping xúc xích thơm lừng.',
    ),
    Product2(
      name1: 'Khoai tây chiên',
      image1: 'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
      mota: 'Khoai tây chiên giòn vàng rụm, rắc muối tinh tế – món ăn nhẹ hoàn hảo mọi lúc.',
    ),
    Product2(
      name1: 'Bún bò Huế',
      image1: 'https://images.pexels.com/photos/2664216/pexels-photo-2664216.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
      mota: 'Món đặc sản Huế với nước dùng cay nồng, thịt bò và chả đặc trưng hương vị miền Trung.',
    ),
    Product2(
      name1: 'Cà Phê',
      image1: 'https://images.pexels.com/photos/33928334/pexels-photo-33928334.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 50000,
      mota: 'Ly cà phê nguyên chất đậm đà, thơm nồng hương Arabica – Robusta hòa quyện.',
    ),
    Product2(
      name1: 'Coca',
      image1: 'https://images.pexels.com/photos/33930870/pexels-photo-33930870.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
      mota: 'Nước ngọt có gas mát lạnh, vị ngọt nhẹ sảng khoái cho mọi bữa ăn.',
    ),
    Product2(
      name1: 'Bia',
      image1: 'https://images.pexels.com/photos/33929953/pexels-photo-33929953.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 30000,
      mota: 'Bia vàng mát lạnh, bọt mịn và hương thơm lúa mạch, phù hợp cho mọi cuộc vui.',
    ),
    Product2(
      name1: 'Nước ép dưa hấu',
      image1: 'https://images.pexels.com/photos/1337825/pexels-photo-1337825.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 20000,
      mota: 'Nước ép dưa hấu tươi mát, vị ngọt tự nhiên và giải nhiệt tuyệt vời cho ngày hè.',
    ),
    Product2(
      name1: 'Chanh giã tay',
      image1: 'https://images.pexels.com/photos/33107428/pexels-photo-33107428.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 20000,
      mota: 'Chanh tươi giã tay giữ trọn hương vị tự nhiên, vị chua thanh và mát lạnh.',
    ),
    Product2(
      name1: 'Nước ép táo',
      image1: 'https://images.pexels.com/photos/4551975/pexels-photo-4551975.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
      mota: 'Nước ép táo nguyên chất, vị chua ngọt dịu nhẹ, giàu vitamin và khoáng chất.',
    ),
    Product2(
      name1: 'Nước ép kiwi',
      image1: 'https://images.pexels.com/photos/8679385/pexels-photo-8679385.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
      mota: 'Nước ép kiwi chua nhẹ thanh mát, giúp bổ sung vitamin C và tăng sức đề kháng.',
    ),
    Product2(
      name1: 'Nước ép xoài',
      image1: 'https://images.pexels.com/photos/4955257/pexels-photo-4955257.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      price: 15000,
      mota: 'Nước ép xoài sánh mịn, hương thơm quyến rũ, vị ngọt tự nhiên hấp dẫn.',
    ),
  ];
  List<Product2> _filteredProducts = [];
  ProductProvider() {
    _filteredProducts = _allProduct;
  }
  List<Product2> get products => _filteredProducts;
  List<Product2> get topProducts => _allProduct.take(4).toList();
  void search(String query) {
    if (query.isEmpty) {
      _filteredProducts = _allProduct;
    } else {
      _filteredProducts = _allProduct
          .where((p) =>
          p.name1.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
