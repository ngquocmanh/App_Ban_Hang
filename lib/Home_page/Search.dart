import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_01/product/Sanpham.dart';
import 'package:app_01/product/ChiTietSanPham.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_01/Provider/SearchProvider.dart';
class ListAnh {
  final List<String> anh;
  ListAnh({required this.anh});
}
class DemoMonAn{
  final String name;
  final String url;
  final String description;
  final String dateTime;
  DemoMonAn({required this.name , required this.url , required this.description , required this.dateTime});
}
class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String searchText = " ";
  final List<ListAnh> comboanh = [
    ListAnh(anh: [
      "https://images.pexels.com/photos/106343/pexels-photo-106343.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/3434523/pexels-photo-3434523.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/588776/pexels-photo-588776.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/1860204/pexels-photo-1860204.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/1833349/pexels-photo-1833349.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
    ]),
  ];
  final List<DemoMonAn> MonAnDemo = [
    DemoMonAn(
        name: 'Thịt heo nướng tảng',
        url: "https://images.pexels.com/photos/32584548/pexels-photo-32584548.jpeg",
        description: "Thịt heo nướng tảng là một khối thịt heo nguyên miếng được chế biến bằng cách nướng, thường giữ lại độ ngọt tự nhiên và hương vị đậm đà vì các thớ thịt không bị cắt nhỏ",
        dateTime: "Comming soon"),
    DemoMonAn(
        name: "Bò nướng sốt phô mai",
        url: "https://images.pexels.com/photos/29724645/pexels-photo-29724645.jpeg",
        description: "Bò nướng tảng sốt phô mai là một món ăn với miếng thịt bò tảng dày được nướng chín tới, giữ được độ mềm ngọt tự nhiên, phủ lên trên là lớp sốt phô mai béo ngậy, thơm lừng",
        dateTime: "Comming soon"),
    DemoMonAn(
        name: "Sushi Nhật Bản",
        url: "https://images.pexels.com/photos/33106043/pexels-photo-33106043.jpeg",
        description: "Sushi là món ăn truyền thống của Nhật Bản, đặc trưng bởi cơm trộn giấm (gọi là shari) kết hợp với các nguyên liệu khác (neta), phổ biến nhất là hải sản tươi sống hoặc chín. Món ăn này có hương vị chua nhẹ, ngọt bùi từ cơm và giấm, kết hợp với vị tươi ngon của các loại hải sản hoặc các nguyên liệu khác như rau củ và trứng",
        dateTime: "Comming soon")
  ];
  final Map<int, PageController> _scontrollers = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < comboanh.length; i++) {
      _scontrollers[i] = PageController();
    }
  }
  @override
  Widget build(BuildContext context) {
    final products = context.watch<SearchProvider>().products;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Nhập món ăn',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                  context.read<SearchProvider>().search(value);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (int index = 0; index < comboanh.length; index++) ...[
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
            //  const Divider(thickness: 1, indent: 16, endIndent: 16),
              if (searchText.trim().isEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Top món ăn ngon",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    buildProductList(context.read<SearchProvider>().topProducts),
                  //  const Divider(thickness: 1, indent: 16, endIndent: 16),
                    Text("  🔥Những món ăn chuẩn bị ra mắt 🔥",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    buildProductDemo(MonAnDemo),
                  ],
                )
              else if (products.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Không tìm thấy sản phẩm nào ',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                buildProductList(products),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProductList(List<Product2> products) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 3,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return buildProductItem(product, context);
      },
    );
  }

  Widget buildProductItem(Product2 product, BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.grey, width: 0.5),
      ),
      elevation: 0.3,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Chitietsanpham(product: product),
            ),
          );
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
                padding: const EdgeInsets.all(8),
                child: Text(
                  product.name1,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildProductDemo(List<DemoMonAn> demo) {
    final int itemCount = demo.length;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.65,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final product = demo[index];
        return buildProductItemDemo(product, context);
      },
    );
  }
  Widget buildProductItemDemo(DemoMonAn product, BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  content: Container(
                    height: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            product.url,
                            fit: BoxFit.cover,
                            height:200,
                            width: 300,
                          ),
                        ),
                        SizedBox(height: 15,),
                        Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(product.name,style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                                  Text(product.description,textAlign: TextAlign.start,style: TextStyle(fontSize: 20,color: Colors.grey.shade800),),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                );
              }
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 1.2,
                child: Image.network(
                  product.url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                        color: Colors.grey.shade300,
                        child: const Icon(Icons.fastfood, size: 40, color: Colors.grey)
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    product.dateTime,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.redAccent,
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
