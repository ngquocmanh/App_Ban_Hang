import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TroGiup extends StatelessWidget {
  const TroGiup({super.key});

  Future<void> _openLink(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      bool launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!launched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không mở được $url')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Trợ giúp", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Bạn cần hỗ trợ gì ?',style: TextStyle(color: Colors.orange,fontSize: 20),),
                SizedBox(height: 8),
              ],
            ),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
            leading: const Icon(Icons.web, color: Colors.white),
            title: const Text("Website chính thức", style: TextStyle(color: Colors.white)),
            subtitle: const Text("https://www.facebook.com/NgQuocManh.26/", style: TextStyle(color: Colors.white70, fontSize: 13)),
            onTap: () => _openLink(context, "https://www.facebook.com/NgQuocManh.26/"),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
            leading: const Icon(Icons.phone, color: Colors.white),
            title: const Text("Gọi hỗ trợ", style: TextStyle(color: Colors.white)),
            subtitle: const Text("+84 333437424", style: TextStyle(color: Colors.white70, fontSize: 13)),
            onTap: () => _openLink(context, "tel:+84333437424"),
          ),
          ListTile(
            trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
            leading: const Icon(Icons.email, color: Colors.white),
            title: const Text("Gửi email", style: TextStyle(color: Colors.white)),
            subtitle: const Text("nguyenquocmanhxyz@gmail.com", style: TextStyle(color: Colors.white70, fontSize: 13)),
            onTap: () => _openLink(context, "mailto:nguyenquocmanhxyz@gmail.com"),
          ),
        ],
      ),
    );
  }
}
