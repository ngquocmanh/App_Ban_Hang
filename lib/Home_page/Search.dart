import 'package:app_01/main.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class ListAnh{
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
  final Map<int, PageController> _scontrollers = {};
  @override
  void initState(){
    super.initState();
    for(int i  = 0 ; i<comboanh.length ; i++){
      _scontrollers[i] =PageController();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(child:  TextField(
              decoration: InputDecoration(
                // labelText: 'Tìm món ăn ',
                hintText: 'Nhập món ăn',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.search)
                ),
              ),
            ))
          ],
        ),
      ),
      body: SingleChildScrollView(
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
            ]
          ],
        ),
      ),
    );
  }
}

