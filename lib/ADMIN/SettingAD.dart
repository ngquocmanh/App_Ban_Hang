import 'package:app_01/Authenticatin/GiaoDien.dart';
import 'package:flutter/material.dart';
class Settingad extends StatelessWidget {
  const Settingad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>Giaodien() ));
        },
            child: Text('Đăng xuất')),
      ),
    );
  }
}
