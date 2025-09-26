import 'package:app_01/Thanhtoan.dart';
import 'package:flutter/material.dart';
import 'Sanpham.dart';
class TrangChu extends StatefulWidget {
  const TrangChu({super.key});

  @override
  State<TrangChu> createState() => _TrangChuState();
}

class _TrangChuState extends State<TrangChu> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int cartCount2 = 0;
  final List<Product2> cart = [];
  List<Product2> product2 = [
    Product2(
      name1: 'Bún Tôm',
      image1: 'https://images.pexels.com/photos/699953/pexels-photo-699953.jpeg',
      price: 30000,
    ),
    Product2(
        name1: 'Bánh Mỳ',
        image1: 'https://images.pexels.com/photos/1633525/pexels-photo-1633525.jpeg',
        price: 15000),
    Product2(
        name1: 'Hambeger',
        image1: 'https://images.pexels.com/photos/1199957/pexels-photo-1199957.jpeg',
        price: 50000
    ),
    Product2(
        name1: 'Beefsteak',
        image1: 'https://images.pexels.com/photos/769289/pexels-photo-769289.jpeg',
        price: 150000),
    Product2(
        name1: 'Thịt Xiên Nướng',
        image1: 'https://images.pexels.com/photos/2641886/pexels-photo-2641886.jpeg',
        price: 50000),
    Product2(
        name1: 'Pizza',
        image1: 'https://images.pexels.com/photos/604969/pexels-photo-604969.jpeg',
        price: 150000),
    Product2(
        name1: 'Bánh Mỳ Chảo',
        image1: 'https://images.pexels.com/photos/691114/pexels-photo-691114.jpeg',
        price:50000 ),
    Product2(
        name1: 'Khoai Tây Chiên',
        image1: 'https://images.pexels.com/photos/1583884/pexels-photo-1583884.jpeg',
        price: 30000),
    Product2(
        name1: 'Há Cảo',
        image1: 'https://images.pexels.com/photos/955137/pexels-photo-955137.jpeg',
        price: 50000),
    Product2(
        name1: 'Cà Phê' ,
        image1: 'https://images.pexels.com/photos/33852343/pexels-photo-33852343.jpeg',
        price:50000 ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     //   extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            "Trang Chủ", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: Padding(padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.account_circle_outlined, size: 35,),
                  title: Text('Cá Nhân'),
                ),
                Center(
                    child: Text(
                      'Thông Tin Cá Nhân', style: TextStyle(fontSize: 20,),
                    )
                ),
                SizedBox(height: 20,),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Họ và Tên',
                            hintText: 'Nhập Họ và Tên',
                            prefixIcon: const Icon(Icons.account_circle),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập họ tên';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Nhập Example@gmail.com',
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng Email';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            labelText: 'Địa chỉ',
                            hintText: 'Nhập Địa chỉ',
                            prefixIcon: const Icon(Icons.place),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập địa chỉ';
                            }
                            return null;
                          },
                          onSaved: (value) {

                          },
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext dialogcontext) {
                                    return AlertDialog(
                                      title: Text('Lưu thông tin của bạn'),
                                      actions: [
                                        OutlinedButton(onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Text('Đã lưu thông tin');
                                          }
                                          Navigator.of(dialogcontext).pop();
                                        },
                                          child: Text('Xác nhận'),
                                        ),
                                        SizedBox(width: 30,),
                                        OutlinedButton(onPressed: () {
                                          Navigator.of(context).pop();
                                        }, child: Text('Hủy'),
                                          style: OutlinedButton.styleFrom(

                                          ),
                                        ),
                                      ],
                                    );
                                  }
                              );
                            }, child: Text('Lưu')),
                            SizedBox(width: 40,),
                            ElevatedButton(onPressed: () {
                              _nameController.clear();
                              _emailController.clear();
                              _addressController.clear();
                            }, child: Text('Hủy'))
                          ],
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://images.pexels.com/photos/33041/antelope-canyon-lower-canyon-arizona.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Padding(padding: EdgeInsets.all(16),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return buildImageCard(product2[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 30);
                    },
                    itemCount: product2.length),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  print('Trang Chủ');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.home, color: Colors.blue),
                    SizedBox(height: 4),
                    Text('Trang Chủ', style: TextStyle(color: Colors.blue)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {

                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.person, color: Colors.grey),
                    SizedBox(height: 4),
                    Text('Cá nhân', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print('Thông báo');
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.notifications, color: Colors.grey),
                    SizedBox(height: 4),
                    Text('Thông báo', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Stack(
        children: [
          Positioned(
              child: SizedBox(
            height: 60,
            width: 60,
            child: IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Pay2()));
            }, icon: Icon(Icons.shopping_cart_sharp,size: 25,color: Colors.yellow,),style: IconButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            ),
          )),
          if(cartCount2 > 0)
            Positioned(
              right: 0,
              left: 35,
              child: Text("$cartCount2",style: TextStyle(color: Colors.white,fontSize: 17),)
            ),
        ],
        )
    );
  }
  Widget buildImageCard(Product2 product) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image1,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${product.price} VND",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  cart.add(product);
                  cartCount2 = cart.length;
                });
              },
              icon: const Icon(Icons.add_shopping_cart, size: 18),
              label: const Text("Thêm"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
