import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../ Other_functions/LichSuDatBan.dart';
import '../db/BookingDataBaseHepler.dart';
import '../db/book_table.dart';
import 'Setting.dart';
import 'TrangChu.dart';
import '../Home_page/LichSuMuaHang.dart';
class Product {
  final List<String> anhs;
  Product({required this.anhs});
}

class DatBan extends StatefulWidget {
  final int userId;

  const DatBan({super.key, required this.userId});

  @override
  State<DatBan> createState() => _DatBanState();
}

class _DatBanState extends State<DatBan> {
  final List<Product> combos = [
    Product(anhs: [
      "https://images.pexels.com/photos/3297807/pexels-photo-3297807.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/6646067/pexels-photo-6646067.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/33933381/pexels-photo-33933381.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/19902245/pexels-photo-19902245.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/32744907/pexels-photo-32744907.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
    ]),
  ];

  final _formKey = GlobalKey<FormState>();
  int _selectedIndex = 2;
  final Map<int, PageController> _controllers = {};

  final TextEditingController _tableController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _dateTime;
  String? _selectedTable;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < combos.length; i++) {
      _controllers[i] = PageController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text(
          "Đặt bàn",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LichSuDatBan(userId: widget.userId),
                ),
              );
            },
            icon: Icon(Icons.history_outlined, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int index = 0; index < combos.length; index++) ...[
              Card(
                margin: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView(
                            controller: _controllers[index],
                            children: combos[index].anhs.map((url) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            }).toList(),
                          ),
                          Positioned(
                            bottom: 8,
                            child: SmoothPageIndicator(
                              controller: _controllers[index]!,
                              count: combos[index].anhs.length,
                              effect: const WormEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Họ tên',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập họ tên';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Số điện thoại',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số điện thoại';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _tableController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Số bàn',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn bàn';
                      }
                      return null;
                    },
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              'Chọn số bàn',
                              style: TextStyle(color: Colors.black),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(9, (i) {
                                String table = 'Bàn ${i + 1}';
                                return RadioListTile<String>(
                                  value: table,
                                  title: Text(table),
                                  groupValue: _selectedTable,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTable = value;
                                      _tableController.text = table;
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              }),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    readOnly: true,
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Ngày đặt',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon:
                      const Icon(Icons.date_range, color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn ngày đặt';
                      }
                      return null;
                    },
                    onTap: () async {
                      DateTime today = DateTime.now();
                      DateTime? pickDate = await showDatePicker(
                        context: context,
                        firstDate:
                        DateTime(today.year, today.month, today.day),
                        lastDate: DateTime(2050),
                        initialDate: today,
                      );
                      if (pickDate != null) {
                        String formattedDate =
                        DateFormat('dd/MM/yyyy').format(pickDate);
                        setState(() {
                          _dateController.text = formattedDate;
                          _dateTime = pickDate;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _timeController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Giờ đặt',
                      hintStyle: const TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon:
                      const Icon(Icons.access_time, color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng chọn giờ';
                      }
                      return null;
                    },
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        final now = DateTime.now();
                        final selectedDateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        String formattedTime =
                        DateFormat('HH:mm').format(selectedDateTime);
                        setState(() {
                          _timeController.text = formattedTime;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      ' 📍 Chọn bàn trên sơ đồ:',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/MapStore.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('DEBUG: Đặt bàn bởi userId=${widget.userId}');
                        print('Tên: ${_nameController.text}');
                        print('SĐT: ${_phoneController.text}');
                        print('Bàn: ${_tableController.text}');
                        print('Ngày: ${_dateController.text}');
                        print('Giờ: ${_timeController.text}');
                        final booking = Booking(
                          userId: widget.userId,
                          name: _nameController.text,
                          phone: _phoneController.text,
                          soBan: _tableController.text,
                          bookingdate: _dateController.text,
                          bookingtime: _timeController.text,
                        );
                        await BookingDataBaseHelper.instance
                            .insertBooking(booking.toMap());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Đặt bàn thành công!\n'
                                  'Tên: ${_nameController.text}\n'
                                  'Số điện thoại: ${_phoneController.text}\n'
                                  'Bàn: ${_tableController.text}\n'
                                  'Ngày: ${_dateController.text} - Giờ: ${_timeController.text}',
                            ),
                            duration: Duration(seconds: 3),
                          ),
                        );

                        _nameController.clear();
                        _phoneController.clear();
                        _tableController.clear();
                        _dateController.clear();
                        _timeController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text(
                      'Đặt bàn',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                  context,
                  MaterialPageRoute(builder: (context) => TrangChu(userId: widget.userId)),
                );
              }),
              buildBottomNavItem(Icons.calendar_month_outlined, "Đặt bàn", 2, () {
                setState(() => _selectedIndex = 2);
              }),
              buildBottomNavItem(Icons.history, "Lịch sử", 3, () {
                setState(() => _selectedIndex = 3);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LichSuMuaHang(userId: widget.userId),
                  ),
                );
              }),
              buildBottomNavItem(Icons.settings, "Cài đặt", 4, () {
                setState(() => _selectedIndex = 4);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Setting(userId: widget.userId)),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomNavItem(
      IconData icon, String label, int index, VoidCallback onTap) {
    bool isSelected = _selectedIndex == index;
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(60, 60),
        backgroundColor: Colors.black,
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28, color: isSelected ? Colors.blue : Colors.white),
          Text(
            label,
            style: TextStyle(color: isSelected ? Colors.blue : Colors.white),
          ),
        ],
      ),
    );
  }
}
