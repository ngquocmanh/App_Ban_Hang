import 'dart:ffi';

class Product2 {
  final String name1;
  final String image1;
  final double price;
  final String mota;
  int quantity;
  Product2({required this.name1 , required this.image1 , required this.price, this.quantity = 1 , required this.mota});
  //Chuyển tối tượng user thành map
  Map<String ,dynamic> toMap(){
    return {
      'name1' : name1,
      'image1' : image1,
      'price' : price,
      'quantity': quantity,
      'mota':mota,
    };
  }
  //Tạo user từ map
  factory Product2.fromMap(Map<String , dynamic> map){
    return Product2(
        name1: map['name1'],
        image1: map['image1'],
        price: map['price'],
        quantity: map['quantity'],
        mota: map['mota']
    );
  }
}
