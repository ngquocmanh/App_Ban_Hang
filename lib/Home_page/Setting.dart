import 'package:app_01/Authenticatin/GiaoDien.dart';
import 'package:app_01/Setting/Trogiup.dart';
import 'package:app_01/Home_page/DatBan.dart';
import 'package:app_01/Setting/Person.dart';
import 'package:flutter/material.dart';
import 'TrangChu.dart';
import 'LichSu.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  int _selectedIndex = 4;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Row(
          children: const [
            Text('Cài đặt', style: TextStyle(color: Colors.white)),
            SizedBox(width: 10),
            Icon(Icons.settings, color: Colors.white),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(4.0),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white60, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "Tài khoản",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.white),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white, size: 18),
                  title: const Text("Thông tin cá nhân",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Person()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.lock, color: Colors.white),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined,
                      color: Colors.white, size: 18),
                  title: const Text("Đổi mật khẩu",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: const Text("Đăng xuất",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                                color: Colors.white60, width: 0.8),
                          ),
                          title: const Text('Bạn có muốn đăng xuất không ?',
                              style: TextStyle(color: Colors.white)),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Giaodien()),
                                          (route) => false,
                                    );
                                  },
                                  child: const Text('Đồng ý',
                                      style: TextStyle(color: Colors.white)),
                                ),
                                const SizedBox(width: 40),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Không',
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white60, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "Ứng dụng",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode, color: Colors.white),
                  title: const Text("Chế độ tối",
                      style: TextStyle(color: Colors.white)),
                  value: true,
                  onChanged: (val) {},
                ),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.white),
                  title: const Text("Ngôn ngữ",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.white),
                  title: const Text("Thông báo",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white60, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.only(bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    "Hỗ trợ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.help, color: Colors.white),
                  title: const Text("Trợ giúp",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>TroGiup()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip, color: Colors.white),
                  title: const Text("Chính sách bảo mật",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.white70,
                              ),
                            ),
                            content: SizedBox(
                              width: 350,
                              height: 550,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text('Chính sách bảo mật' ,style: TextStyle(color: Colors.green,fontSize: 25),),
                                    Text('Ứng dụng Đặt Đồ Ăn Nhanh được xây dựng với mục tiêu mang lại cho người dùng trải nghiệm thuận tiện, nhanh chóng và an toàn. Chúng tôi cam kết bảo vệ thông tin cá nhân và quyền riêng tư của bạn. Các dữ liệu được thu thập chỉ nhằm mục đích phục vụ hoạt động của ứng dụng, bao gồm quản lý tài khoản, hỗ trợ khách hàng, cải thiện chất lượng dịch vụ và gửi thông báo liên quan. Chúng tôi tuyệt đối không bán, cho thuê hay chia sẻ thông tin cá nhân cho bên thứ ba nếu không có sự đồng ý của người dùng, trừ khi pháp luật yêu cầu.Người dùng có trách nhiệm cung cấp thông tin chính xác và sử dụng ứng dụng một cách hợp pháp. Việc lạm dụng dịch vụ để thực hiện các hành vi gian lận, vi phạm pháp luật hoặc gây hại đến quyền lợi của người khác sẽ bị xử lý theo quy định. Khi tiếp tục sử dụng, bạn đồng ý tuân thủ các điều khoản và chính sách này. Chúng tôi có quyền thay đổi nội dung chính sách theo thời gian và sẽ thông báo khi cần thiết. Mọi thắc mắc hoặc yêu cầu hỗ trợ, vui lòng liên hệ đội ngũ chăm sóc khách hàng của chúng tôi',
                                      style: TextStyle(color: Colors.white,fontSize: 20),)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info, color: Colors.white),
                  title: const Text("Về ứng dụng",
                      style: TextStyle(color: Colors.white)),
                  subtitle: const Text("Phiên bản 1.0.0",
                      style: TextStyle(color: Colors.white)),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
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
                    context, MaterialPageRoute(builder: (context) => const Shop2()));
              }),
              buildBottomNavItem(Icons.calendar_month_outlined, "Đặt bàn", 2, () {
                setState(() => _selectedIndex = 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>PromoPage()));
              }),
              buildBottomNavItem(Icons.history, "Lịch sử", 3, () {
                setState(() => _selectedIndex = 3);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => const Lichsu()));
              }),
              buildBottomNavItem(Icons.settings, "Cài đặt", 4, () {
                setState(() => _selectedIndex = 4);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
