import 'package:app_01/DangKy.dart';
import 'package:app_01/DangNhap.dart';
import 'package:flutter/material.dart';
import 'package:app_01/TrangChu.dart';
class Giaodien extends StatefulWidget {
  const Giaodien({super.key});

  @override
  State<Giaodien> createState() => _GiaodienState();
}

class _GiaodienState extends State<Giaodien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.scale(
                scale: 3.0,
                child: Image.asset(
                  'assets/images/icons8-container-truck-100.png',
                ),
              ),
              const SizedBox(height: 70),
              const Text(
                'Đặt hàng tiện lợi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Giao hàng siêu nhanh',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 ElevatedButton(onPressed: (){
                   Navigator.pushNamed(context, '/login');
                 },
                     child: Text('Đăng nhập',style: TextStyle(color: Colors.white),),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.red,
                     foregroundColor: Colors.black
                   ),
                 ),
                 SizedBox(width: 40,),
                 ElevatedButton(onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Dangky()));
                 },
                   child: Text('Đăng ký',style: TextStyle(color: Colors.white),),
                   style: ElevatedButton.styleFrom( backgroundColor: Color(0xFFBDBDBD)),
                 ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
