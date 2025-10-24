import 'package:flutter/material.dart';
import 'package:app_01/product/Sanpham.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_01/product/ChiTietSanPham.dart';
class ListAnh {
  final List<String> anh;
  ListAnh({ required this.anh});
}

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<ListAnh> comboanh = [
    ListAnh(anh: [
      "https://images.pexels.com/photos/106343/pexels-photo-106343.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/3434523/pexels-photo-3434523.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/588776/pexels-photo-588776.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      'https://images.pexels.com/photos/1860204/pexels-photo-1860204.jpeg?auto=compress&cs=tinysrgb&w=300&h=300',
      "https://images.pexels.com/photos/1833349/pexels-photo-1833349.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
    ]),
  ];

  final List<Product2> products =  [
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
  ];

  final Map<int, PageController> _scontrollers = {};

  @override
  void initState(){
    super.initState();
    for(int i  = 0 ; i<comboanh.length ; i++){
      _scontrollers[i] = PageController();
    }
  }

  @override
  void dispose() {
    _scontrollers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: TextField(
              decoration: InputDecoration(
                // labelText: 'Tìm món ăn ',
                hintText: 'Nhập món ăn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.search)
                ),
              ),
            ))
          ],
        ),
      ),
      body: SafeArea(child:SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 16, 8, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.fastfood_outlined),
                        label: const Text('Đồ ăn'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.free_breakfast_rounded),
                        label: const Text('Đồ uống'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.rice_bowl_outlined),
                        label: const Text('Khác'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for(int index = 0 ; index <comboanh.length;index++) ...[
              Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView(
                            controller: _scontrollers[index],
                            children: comboanh[index].anh.map((url) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 8,
                            child: SmoothPageIndicator(
                              controller: _scontrollers[index]!,
                              count: comboanh[index].anh.length,
                              effect: const WormEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Divider( thickness: 1, indent: 16, endIndent: 16),
            Container(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.centerLeft,
              child: const Text(
                "   Đề xuất cho bạn",
                style: TextStyle(fontSize: 20, color: Colors.grey, fontWeight: FontWeight.bold,),
              ),
            ),
            buildProductList(products),
          ],
        ),
       ),
      )
    );
  }
  Widget buildProductList(List<Product2> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics:  NeverScrollableScrollPhysics(),
      padding:  EdgeInsets.all(8.0),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 0,
        childAspectRatio: 3,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return buildProductItem(product);
      },
    );
  }
  Widget buildProductItem(Product2 product){
    return SizedBox(
     // height: 50,
      width:double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.grey, width: 0.5),
        ),
        elevation: 0.3,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>Chitietsanpham(product: product)));
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product.image1,
                  height: 90,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name1,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black87),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      // const SizedBox(height: 4),
                      // Text(
                      //   '${product.price} VNĐ',
                      //   style: const TextStyle(fontSize: 14, color: Colors.red),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}