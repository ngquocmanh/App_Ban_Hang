import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Person extends StatefulWidget {
  final String phone;
  const Person({super.key, required this.phone});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _introduceController =TextEditingController();

  String selectedCity = 'Hà Nội';
  InputDecoration lightInput(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    _loadProfile();
  }
  Future<void> _loadProfile() async{
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _introduceController.text = prefs.getString('introduce') ?? '';
      selectedCity = prefs.getString('city') ?? 'Hà Nội';
    });
  }
  Future<void> _saveProfile() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('introduce', _introduceController.text);
    await prefs.setString('city', selectedCity);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lưu thông tin thành công'),
      backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text(
          'Trang Cá Nhân',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/person.jpg',
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.black),
                  decoration: lightInput("Tên"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.emailAddress,
                  decoration: lightInput("Email"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  style: const TextStyle(color: Colors.black),
                  keyboardType: TextInputType.phone,
                  decoration: lightInput("Số điện thoại"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _introduceController,
                  style: const TextStyle(color: Colors.black),
                  decoration: lightInput("Giới thiệu bản thân"),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  decoration: lightInput("Tỉnh / Thành phố"),
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black),
                  iconEnabledColor: Colors.black54,
                  items: [
                    'Hà Nội',
                    'Hải Phòng',
                    'Quảng Ninh',
                    'Lạng Sơn',
                    'Thái Nguyên',
                    'Bắc Giang',
                    'Lào Cai',
                    'Điện Biên',
                    'Hà Giang',
                    'Thanh Hóa',
                    'Nghệ An',
                    'Ninh Bình',
                    'Thái Bình',
                    'Hòa Bình',
                    'Vĩnh Phúc',
                    'Bắc Ninh',
                    'Quảng Bình',
                    'Thừa Thiên Huế',
                    'Đà Nẵng',
                    'Quảng Ngãi',
                    'Bình Định',
                    'Phú Yên',
                    'Khánh Hòa',
                    'Ninh Thuận',
                    'Bình Thuận',
                    'Đắk Lắk',
                    'Gia Lai',
                    'Lâm Đồng',
                    'TP Hồ Chí Minh',
                    'Đồng Nai',
                    'Long An',
                    'Cần Thơ',
                    'An Giang',
                    'Hà Tĩnh',
                  ].map((city) {
                    return DropdownMenuItem(
                      value: city,
                      child: Text(city),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                    });
                  },
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _saveProfile,
                  child: const Text(
                    'Lưu thông tin',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
