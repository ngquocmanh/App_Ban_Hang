import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_01/db/productDB.dart';
import 'package:app_01/product/Sanpham.dart';

class QlySanPham extends StatefulWidget {
  const QlySanPham({super.key});

  @override
  State<QlySanPham> createState() => _QlySanPhamState();
}

class _QlySanPhamState extends State<QlySanPham> {
  List<Product2> products = [];
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController motaCtrl = TextEditingController();
  final TextEditingController quantityCtrl = TextEditingController();

  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _loadProducts() async {
    final allProducts = await ProductDatabase.instance.getProducts();
    setState(() {
      products = allProducts;
    });
  }

  Future<void> _addProduct() async {
    if (nameCtrl.text.isEmpty ||
        priceCtrl.text.isEmpty ||
        motaCtrl.text.isEmpty ||
        quantityCtrl.text.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    final newProduct = Product2(
      name1: nameCtrl.text,
      image1: _image!.path,
      price: double.tryParse(priceCtrl.text) ?? 0,
      mota: motaCtrl.text,
      quantity: int.tryParse(quantityCtrl.text) ?? 1,
    );

    final id = await ProductDatabase.instance.insertProduct(newProduct);
    newProduct.id = id;

    setState(() {
      products.add(newProduct);
      nameCtrl.clear();
      priceCtrl.clear();
      motaCtrl.clear();
      quantityCtrl.clear();
      _image = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Thêm sản phẩm thành công!")),
    );
  }

  Future<void> _deleteProduct(int index) async {
    final product = products[index];
    if (product.id != null) {
      await ProductDatabase.instance.deleteProduct(product.id!);
    }
    setState(() {
      products.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã xoá sản phẩm')),
    );
  }

  Future<void> _updateQuantity(Product2 product, int quantity) async {
    product.quantity = quantity;
    await ProductDatabase.instance.updateProduct(product);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Quản lý sản phẩm"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Center(
            child:Text(
              'Quản lý sản phẩm',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
           SizedBox(height: 15),
          Card(
            elevation: 3,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  TextField(
                    controller: nameCtrl,
                    decoration: InputDecoration(
                      labelText: "Tên sản phẩm",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: priceCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Giá",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: motaCtrl,
                    decoration: InputDecoration(
                      labelText: "Mô tả",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: quantityCtrl,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Số lượng",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      height: 80,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: _image == null
                          ? const Center(child: Text("Chọn ảnh"))
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(_image!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          _addProduct();
                        },
                        child: const Text("Tạo sản phẩm"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          products.isEmpty
              ?Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Chưa có sản phẩm nào',textAlign: TextAlign.center,)
            ],
          ),)
              : Column(
            children: products.map((product) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 3,
                child: Padding(
                  padding:EdgeInsets.symmetric(vertical: 2 , horizontal: 0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(product.image1),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(product.name1,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            Text("Giá: ${product.price} VND",
                                style:  TextStyle(
                                    fontSize: 16, color: Colors.green)),
                            Row(
                              children: [
                                Expanded(child:Text("Số lượng: "), ),
                                Expanded(child:IconButton(
                                  icon:Icon(Icons.remove),
                                  onPressed: () {
                                    if (product.quantity > 1) {
                                      _updateQuantity(
                                          product, product.quantity - 1);
                                    }
                                  },
                                ),),
                                Expanded(child:
                                Text("${product.quantity}"),),
                                Expanded(child:IconButton(
                                  icon:Icon(Icons.add),
                                  onPressed: () {
                                    _updateQuantity(
                                        product, product.quantity + 1);
                                  },
                                ),)
                              ],
                            ),
                            Text(product.mota,overflow: TextOverflow.ellipsis,maxLines: 1,),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: 50,
                        child:Column(
                          children: [
                            IconButton(
                                icon: Icon(Icons.delete,color: Colors.amber,),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Xác nhận xoá'),
                                        content: Text.rich(
                                          TextSpan(
                                            children: [
                                              const TextSpan(text: "Bạn có chắc muốn xoá sản phẩm ",style: TextStyle(fontSize: 17)),
                                              TextSpan(
                                                text: "'${product.name1}'",
                                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red,fontSize: 17),
                                              ),
                                              const TextSpan(text: " không ?",style: TextStyle(fontSize: 17)),
                                            ],
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        actions: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          }, child: Text('Đóng')),
                                          TextButton(onPressed: (){
                                            _deleteProduct(products.indexOf(product));
                                            Navigator.of(context).pop();
                                          }, child: Text('Xoá'))
                                        ],
                                      )
                                  );
                                }
                            ),
                            IconButton(
                                onPressed: () {},
                                icon:Icon(Icons.edit)
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
