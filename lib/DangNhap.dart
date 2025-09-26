
import 'package:app_01/DangKy.dart';
import 'package:app_01/QuenMatKhau.dart';
import 'package:app_01/Home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Dangnhap extends StatefulWidget {
  const Dangnhap({super.key});

  @override
  State<Dangnhap> createState() => _DangnhapState();
}

class _DangnhapState extends State<Dangnhap> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  bool remember = false;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
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
                    hintText: 'Nhập số điện thoại',
                    prefixIcon: const Icon(Icons.phone,color: Colors.white,),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(color: Colors.white ,width: 2),
                    ),
                  ),
                //  validator: (value) {
                //    if (value == null || value.isEmpty) {
                //      return 'Vui lòng nhập số điện thoại';
                //    }
                //    if (value.length < 9 || value.length > 11) {
                //      return 'Số điện thoại không hợp lệ';
                //    }
                //    return null;
                //  },
                ),

                const SizedBox(height: 20),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _passController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Mật khẩu',
                    hintText: 'Nhập mật khẩu',
                    prefixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,color: Colors.white,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
               //   validator: (value) {
               //     if (value == null || value.isEmpty) {
               //       return 'Vui lòng nhập mật khẩu';
               //     }
               //     if (value.length < 6) {
                //      return 'Mật khẩu tối thiểu 6 ký tự';
                //    }
                //    return null;
                //  },
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Checkbox(
                        value: remember,
                        onChanged: (value){
                          setState(() {
                            remember = value!;
                          });
                        }),
                    Text('Lưu mật khẩu',style: TextStyle(color: Colors.red),),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => QuenMK()));
                      },
                      child: const Text(
                        'Quên mật khẩu ?',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, '/shop');
                    }
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
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dangky()));
                      },
                      child: const Text(
                        'Tạo tài khoản',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
