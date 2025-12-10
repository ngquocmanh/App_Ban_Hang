import 'package:app_01/ADMIN/QlySanPham.dart';
import 'package:app_01/ADMIN/SettingAd.dart';
import 'package:app_01/ADMIN/TablePage.dart';
import 'package:app_01/Home_page/Setting.dart';
import 'package:flutter/material.dart';
 class OrderPage extends StatelessWidget { const OrderPage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title:  Text("Đơn hàng"))); }
 class UserPage extends StatelessWidget { const UserPage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Người dùng"))); }
 class StatisticPage extends StatelessWidget { const StatisticPage({super.key}); @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text("Thống kê"))); }

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = [
      ["Sản phẩm", Icons.shopping_bag,QlySanPham()],
      ["Đơn hàng", Icons.receipt_long,OrderPage()],
      ["Bàn", Icons.table_restaurant,TablePage()],
      ["Người dùng", Icons.group,UserPage()],
      ["Thống kê", Icons.bar_chart,StatisticPage()],
      ["Cài Đặt", Icons.settings,Settingad()],
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trang Quản Trị"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
          ),
          itemCount: menus.length,
          itemBuilder: (context, index) {
            final title = menus[index][0] as String;
            final icon = menus[index][1] as IconData;
            final page = menus[index][2] as Widget;
            return _buildMenuCard(context, title, icon, page);
          },
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset:Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.blue.shade100,
              child: Icon(icon, color: Colors.blue),
            ),
            SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Mở', style: TextStyle(fontSize: 12, color: Colors.grey)),
                Icon(Icons.chevron_right, size: 18, color: Colors.grey),
              ],
            )
          ],
        ),
      ),
    );
  }
}
