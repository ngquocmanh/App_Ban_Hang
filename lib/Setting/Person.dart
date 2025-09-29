import 'package:app_01/db/UserDatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:app_01/db/User.dart';

class Person extends StatefulWidget {
  final String phone;
  const Person({super.key, required this.phone});

  @override
  State<Person> createState() => _PersonState();
}

class _PersonState extends State<Person> {
  String selectedCity = "Hà Nội";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Input style sáng
  InputDecoration lightInput(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87),
      filled: true,
      fillColor: Colors.white, // nền trắng
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
        borderSide: const BorderSide(color: Colors.blue), // viền xanh khi focus
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final user = await UserDatabaseHelper.instance.getUser(widget.phone);
    if (user != null) {
      setState(() {
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // nền xanh nhạt
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
                  style: const TextStyle(color: Colors.black),
                  decoration: lightInput("Giới thiệu bản thân"),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedCity,
                  decoration: lightInput("Thành Phố"),
                  dropdownColor: Colors.white,
                  style: const TextStyle(color: Colors.black),
                  iconEnabledColor: Colors.black54,
                  items: [
                    'Hà Nội',
                    'Hà Tĩnh',
                    'Đà Nẵng',
                    'TP HCM',
                    'Hải Phòng',
                    'Cần Thơ'
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed:(){
                    loadData();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Lưu thông tin thành công'),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      )
                    );
                  },
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
