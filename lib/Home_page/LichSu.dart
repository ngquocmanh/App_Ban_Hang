import 'package:app_01/Home_page/DatBan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/HistoryProvider.dart';
import 'TrangChu.dart';
import 'Setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider/CardProvider.dart';
class Lichsu extends StatefulWidget {
  const Lichsu({super.key});

  @override
  State<Lichsu> createState() => _LichsuState();
}
class _LichsuState extends State<Lichsu> {
  int _selectedIndex = 3;
  @override @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProduct();
  }
  Future<void> _loadProduct() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    final historyItems = historyProvider.history;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Lịch sử mua hàng", style: TextStyle(color: Colors.white)),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: historyItems.length,
        itemBuilder: (context, index) {
          final item = historyItems[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white60, width: 1.5),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    item.image1,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.name1,
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text("Số lượng: ${item.quantity}",
                    style: const TextStyle(color: Colors.white, fontSize: 15)),
                trailing: Text("${item.price * item.quantity} VND",
                    style: const TextStyle(color: Colors.orange, fontSize: 15)),
              ),
            ),
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
              buildBottomNavItem(Icons.home, "Trang chủ", 1, () {
                setState(() => _selectedIndex = 1);
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const Shop2()),
                );
              }),
              buildBottomNavItem(Icons.calendar_month_outlined, "Đặt bàn", 2, () {
                setState(() => _selectedIndex = 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>PromoPage()));
              }),
              buildBottomNavItem(Icons.history, "Lịch sử", 3, () {

                setState(() => _selectedIndex = 3);
              }),
              buildBottomNavItem(Icons.settings, "Cài đặt", 4, () {
                setState(() => _selectedIndex = 4);
                Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => const Setting()),
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
          onPressed: (){
            historyProvider.clearHistory();
          },
          label: Text("Xóa"),
        icon: Icon(Icons.delete_outline_outlined,size: 20,),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        ),
      ),
    );
  }

  Widget buildBottomNavItem(
      IconData icon, String label, int index, VoidCallback onTap) {
    bool isSelected = _selectedIndex == index;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        minimumSize: const Size(60, 60),
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: isSelected ? Colors.blue : Colors.white),
          Text(label,
              style: TextStyle(color: isSelected ? Colors.blue : Colors.white)),
        ],
      ),
    );
  }
}
