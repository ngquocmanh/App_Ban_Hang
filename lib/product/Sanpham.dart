class Product2 {
  int? id;
  String name1;
  String image1;
  double price;
  String mota;
  int quantity;
  String type;
  Product2({
    this.id,
    required this.name1,
    required this.image1,
    required this.price,
    required this.mota,
    this.quantity = 1,
    this.type = 'food',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name1,
      'image': image1,
      'price': price,
      'mota': mota,
      'quantity': quantity,
      'type': type,
    };
  }

  factory Product2.fromMap(Map<String, dynamic> map) {
    return Product2(
      id: map['id'],
      name1: map['name'],
      image1: map['image'],
      price: map['price'],
      mota: map['mota'],
      quantity: map['quantity'],
      type: map['type'] ?? 'food',
    );
  }
}
