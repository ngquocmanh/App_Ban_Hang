import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Person extends StatefulWidget {
  const Person({super.key});

  @override
  State<Person> createState() => _PersonPageState();
}

class _PersonPageState extends State<Person> {
  File? _avatar;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _introduceController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();

  String selectedDistrict = 'Bắc Từ Liêm';
  String selectedWard = 'Phường Cổ Nhuế 1';

  final Map<String, List<String>> districtToWards = {
    'Bắc Từ Liêm': ['Phường Cổ Nhuế 1', 'Phường Cổ Nhuế 2', 'Phường Xuân Đỉnh', 'Phường Minh Khai', 'Phường Thụy Phương'],
    'Nam Từ Liêm': ['Phường Mỹ Đình 1', 'Phường Mỹ Đình 2', 'Phường Mễ Trì'],
    'Ba Đình': ['Phường Điện Biên', 'Phường Trúc Bạch', 'Phường Vĩnh Phúc'],
    'Hoàn Kiếm': ['Phường Hàng Bài', 'Phường Tràng Tiền', 'Phường Cửa Đông'],
    'Cầu Giấy' : ["Dịch Vọng" , "Dịch Vọng Hậu","Quan Hoa"," Nghĩa Đô","Nghĩa Đô "," Mai Dịch"],
    "Thanh Xuân": ["Nhân Chính" , "Thượng Đình" , "Khương Mai" , "Khương Trung", "Khương Đình", "Thanh Xuân Bắc","Thanh Xuân Nam","Thanh Xuân Trung"],
    "Hai Bà Trưng": ["Bách Khoa" ,  "Lê Thanh Nghị" , "Võ  Thị Sáu" , "Minh Khai" , "Vĩnh Tuy", "Cầu Dền"]
  };

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.photos.request();
    await Permission.storage.request();
  }

  Future<void> _pickImage(ImageSource source) async {
    await _requestPermissions();
    final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _avatar = File(pickedFile.path);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatarPath', pickedFile.path);
    }
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _phoneController.text = prefs.getString('phone') ?? '';
      _introduceController.text = prefs.getString('introduce') ?? '';
      _streetController.text = prefs.getString('street') ?? '';
      selectedDistrict = prefs.getString('district') ?? 'Bắc Từ Liêm';
      selectedWard = prefs.getString('ward') ?? districtToWards[selectedDistrict]![0];

      final avatarPath = prefs.getString('avatarPath');
      if (avatarPath != null && avatarPath.isNotEmpty) {
        _avatar = File(avatarPath);
      }
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('introduce', _introduceController.text);
    await prefs.setString('district', selectedDistrict);
    await prefs.setString('ward', selectedWard);
    await prefs.setString('street', _streetController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Thông tin đã được lưu')),
    );
  }

  InputDecoration lightInput(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Trang Cá Nhân', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return SizedBox(
                          height: 120,
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Chụp ảnh'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Chọn từ thư viện'),
                                onTap: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.gallery);
                                },
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: ClipOval(
                  child: _avatar != null
                      ? Image.file(_avatar!, width: 120, height: 120, fit: BoxFit.cover)
                      : Image.asset('assets/images/person.jpg', width: 120, height: 120, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(controller: _nameController, decoration: lightInput('Tên')),
              const SizedBox(height: 10),
              TextFormField(controller: _emailController, decoration: lightInput('Email'), keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 10),
              TextFormField(controller: _phoneController, decoration: lightInput('Số điện thoại'), keyboardType: TextInputType.phone),
              const SizedBox(height: 10),
              TextFormField(controller: _introduceController, decoration: lightInput('Giới thiệu bản thân'), maxLines: 3),
              const SizedBox(height: 10),

              // Dropdown Quận/Huyện
              DropdownButtonFormField<String>(
                value: selectedDistrict,
                decoration: lightInput('Quận/Huyện'),
                items: districtToWards.keys.map((district) {
                  return DropdownMenuItem(value: district, child: Text(district));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value!;
                    selectedWard = districtToWards[selectedDistrict]![0];
                  });
                },
              ),
              const SizedBox(height: 10),

              // Dropdown Phường/Xã
              DropdownButtonFormField<String>(
                value: selectedWard,
                decoration: lightInput('Phường/Xã'),
                items: districtToWards[selectedDistrict]!.map((ward) {
                  return DropdownMenuItem(value: ward, child: Text(ward));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWard = value!;
                  });
                },
              ),
              const SizedBox(height: 10),


              TextFormField(controller: _streetController, decoration: lightInput('Đường / Ngõ / Số nhà')),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Lưu thông tin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
