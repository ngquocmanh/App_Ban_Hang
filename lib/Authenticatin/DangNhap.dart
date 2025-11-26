import 'dart:async';
import 'package:app_01/Authenticatin/DangKy.dart';
import 'package:app_01/Setting/QuenMatKhau.dart';
import 'package:app_01/db/UserDatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
class Dangnhap extends StatefulWidget {
  const Dangnhap({super.key});

  @override
  State<Dangnhap> createState() => _DangnhapState();
}

class _DangnhapState extends State<Dangnhap> {
  bool _obscureText = true;
  bool remember = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final List<String> _images = [
    'https://images.pexels.com/photos/4744789/pexels-photo-4744789.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/5210192/pexels-photo-5210192.jpeg?auto=compress&cs=tinysrgb&w=600',
    'https://images.pexels.com/photos/1172064/pexels-photo-1172064.jpeg?auto=compress&cs=tinysrgb&w=600',
  ];

  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

  // Future<void> _loginUser() async {
  //   if (_formKey.currentState!.validate()) {
  //     final user = await UserDatabaseHelper.instance
  //         .loginUser(_phoneController.text, _passController.text);
  //     if (!mounted) return;
  //     if (user != null) {
  //       Navigator.pushReplacementNamed(context, '/shop');
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text(
  //             'Sai tài khoản hoặc mật khẩu',
  //             style: TextStyle(color: Colors.red),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }
  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final user = await UserDatabaseHelper.instance.loginUser(
        _phoneController.text.trim(),
        _passController.text.trim(),
      );

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', user.name);
        await prefs.setString('phone', user.phone);
        await prefs.setString('role', user.role);

        if (user.role == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin');
        } else {
          Navigator.pushReplacementNamed(context, '/shop');
        }

        Get.snackbar(
          'Chào mừng',
          'Xin chào ${user.name}',
          backgroundColor: Colors.white,
          colorText: Colors.orangeAccent,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sai số điện thoại hoặc mật khẩu', style: TextStyle(color: Colors.red)),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Image.network(
                _images[index],
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              );
            },
          ),


          Container(
            color: Colors.black.withOpacity(0.6),
          ),


          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Đăng nhập",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 40),

                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Số điện thoại',
                        labelStyle: const TextStyle(color: Colors.white70),
                        hintText: 'Nhập số điện thoại',
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon:
                        const Icon(Icons.phone, color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                          const BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập số điện thoại';
                        }
                        if (value.length < 9 || value.length > 11) {
                          return 'Số điện thoại không hợp lệ';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Mật khẩu
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: _passController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        labelText: 'Mật khẩu',
                        labelStyle: const TextStyle(color: Colors.white70),
                        hintText: 'Nhập mật khẩu',
                        hintStyle: const TextStyle(color: Colors.white54),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                          const BorderSide(color: Colors.white, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:
                          const BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Vui lòng nhập mật khẩu';
                        }
                        if (value.length < 6) {
                          return 'Mật khẩu tối thiểu 6 ký tự';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Checkbox(
                          value: remember,
                          onChanged: (value) {
                            setState(() {
                              remember = value!;
                            });
                          },
                          activeColor: Colors.red,
                        ),
                        const Text(
                          'Lưu mật khẩu',
                          style: TextStyle(color: Colors.white),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QuenMK()),
                            );
                          },
                          child: const Text(
                            'Quên mật khẩu ?',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),

                    ElevatedButton(
                      onPressed:(){
                        _loginUser();
                        Get.snackbar('Cửa hàng ABC', "Xin chào quý khach",backgroundColor: Colors.white , colorText: Colors.orangeAccent);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Chưa có tài khoản? ',
                          style: TextStyle(color: Colors.white70),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dangky()),
                            );
                          },
                          child: const Text(
                            'Đăng ký ngay',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
