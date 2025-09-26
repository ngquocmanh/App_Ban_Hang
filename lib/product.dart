class Product3 {
  final String ten;
  final List<String> anhs; // nhiều ảnh
  final double gia;
  final String mota;
  int quantity;

  Product3({
    required this.ten,
    required this.anhs,
    required this.gia,
    required this.mota,
    this.quantity = 1,
  });
}
