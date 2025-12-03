import 'package:app_01/Home_page/DatBan.dart';
import 'package:app_01/Home_page/Setting.dart';
import 'package:app_01/Home_page/TrangChu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../Provider/HistoryProvider.dart';
class LichSuMuaHang extends StatefulWidget {
  final int userId;

  const LichSuMuaHang({super.key, required this.userId});

  @override
  State<LichSuMuaHang> createState() => _LichSuMuaHangState();
}

class _LichSuMuaHangState extends State<LichSuMuaHang> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Lịch sử mua hàng",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: Provider.of<HistoryProvider>(context, listen: false).loadHistory(),
        builder: (context, snapshot) {
          return Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
              final history = historyProvider.historyList;
              if (history.isEmpty) {
                return const Center(
                  child: Text(
                    "Chưa có lịch sử mua hàng",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                );
              }
              return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(item.image, width: 40, height: 120),
                      title: Text(item.name, style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        "${item.quantity} sản phẩm - "
                            "${NumberFormat.decimalPattern('vi').format(item.price)} VND\n",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          historyProvider.deleteHistory(item.id!);
                        },
                      ),
                    ),
                  );
                },
              );
            },
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TrangChu(userId: widget.userId)));
              }),
              buildBottomNavItem(Icons.calendar_month_outlined, "Đặt bàn", 2, () {
                setState(() => _selectedIndex = 2);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DatBan(userId: widget.userId),
                  ),
                );
              }),
              buildBottomNavItem(Icons.history, "Lịch sử", 3, () {
                setState(() => _selectedIndex = 3);
              }),
              buildBottomNavItem(Icons.settings, "Cài đặt", 4, () {
                setState(() => _selectedIndex = 4);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setting(userId: widget.userId)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavItem(IconData icon, String label, int index, VoidCallback onTap) {
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
          Text(label, style: TextStyle(color: isSelected ? Colors.blue : Colors.white)),
        ],
      ),
    );
  }
}

