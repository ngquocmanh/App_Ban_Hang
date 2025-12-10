import 'package:app_01/%20Other_functions/LichSuDatBan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../db/BookingDataBaseHepler.dart';
import '../db/book_table.dart';
import 'TrangChu.dart';
import '../Home_page/LichSuMuaHang.dart';
import '../product/Sanpham.dart';
import '../db/productDB.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tableController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  DateTime? _dateTime;
  String? _selectedTable;
  Set<String> _reservedTables = {};
  int _selectedIndex = 2;


  final List<Product2> _cartItems = [];
  final Map<int, int> _cartQuantities = {};

  Future<void> _loadReservedTables() async {
    final bookings = await BookingDataBaseHelper.instance.getAllBookings();
    setState(() {
      _reservedTables = bookings.map((b) => b.soBan).toSet();
    });
  }

  Future<List<Product2>> _loadProducts() async {
    return await ProductDatabase.instance.getProducts();
  }

  Future<void> _placeBooking() async {
    if (!_formKey.currentState!.validate()) return;

    final existing = await BookingDataBaseHelper.instance.getAllBookings();
    if (existing.any((b) => b.soBan == _tableController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bàn này đã được đặt, vui lòng chọn bàn khác')),
      );
      return;
    }

    final booking = Booking(
      userId: widget.userId,
      name: _nameController.text,
      phone: _phoneController.text,
      soBan: _tableController.text,
      bookingdate: _dateController.text,
      bookingtime: _timeController.text,
    );

    await BookingDataBaseHelper.instance.insertBooking(booking.toMap());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Đặt bàn thành công!\n'
              'Tên: ${_nameController.text}\n'
              'Số điện thoại: ${_phoneController.text}\n'
              'Bàn: ${_tableController.text}\n'
              'Ngày: ${_dateController.text} - Giờ: ${_timeController.text}',
        ),
        duration: const Duration(seconds: 3),
      ),
    );
    _nameController.clear();
    _phoneController.clear();
    _tableController.clear();
    _dateController.clear();
    _timeController.clear();
    _selectedTable = null;

    await _loadReservedTables();
  }
  void _showFoodOrderBottomSheet() async {
    final products = await _loadProducts();

    final foodProducts = products.where((p) => p.type == 'food').toList();

    if (foodProducts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Hiện chưa có món ăn trong menu')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FoodOrderBottomSheet(
        products: foodProducts,
        cartItems: _cartItems,
        cartQuantities: _cartQuantities,
        onUpdateCart: () {
          setState(() {});
        },
        onSubmitOrder: _submitFoodOrder,
        selectedTable: _selectedTable ?? "Chưa chọn bàn",
      ),
    );
  }

  void _submitFoodOrder() {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn món ăn')),
      );
      return;
    }

    if (_selectedTable == null || _selectedTable!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn bàn trước khi đặt món')),
      );
      return;
    }
    double totalAmount = 0;
    String orderDetails = "Đơn hàng cho $_selectedTable:\n";
    for (var item in _cartItems) {
      int quantity = _cartQuantities[item.id!] ?? 0;
      if (quantity > 0) {
        double itemTotal = item.price * quantity;
        totalAmount += itemTotal;
        orderDetails += "${item.name1} x$quantity: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(itemTotal)}\n";
      }
    }
    orderDetails += "\nTổng cộng: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(totalAmount)}";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Xác nhận đặt món"),
        content: SingleChildScrollView(
          child: Text(orderDetails),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Hủy"),
          ),
          ElevatedButton(
            onPressed: () {
              _saveFoodOrder(totalAmount);
              Navigator.pop(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Đặt món thành công cho $_selectedTable'),
                  duration: const Duration(seconds: 2),
                ),
              );
              setState(() {
                _cartItems.clear();
                _cartQuantities.clear();
              });
            },
            child: const Text("Xác nhận"),
          ),
        ],
      ),
    );
  }

  // Hàm lưu đơn hàng (cần tạo thêm database cho đơn hàng)
  void _saveFoodOrder(double totalAmount) {
    print("ĐƠN HÀNG MÓN ĂN ");
    print("Bàn: $_selectedTable");
    print("User ID: ${widget.userId}");
    print("Tổng tiền: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(totalAmount)}");
    print("Chi tiết:");

    for (var item in _cartItems) {
      int quantity = _cartQuantities[item.id!] ?? 0;
      if (quantity > 0) {
        print("- ${item.name1} x$quantity: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(item.price * quantity)}");
      }
    }

    //Tạo thêm database OrderDatabase để lưu đơn hàng
  }

  Widget _FoodOrderBottomSheet({
    required List<Product2> products,
    required List<Product2> cartItems,
    required Map<int, int> cartQuantities,
    required VoidCallback onUpdateCart,
    required VoidCallback onSubmitOrder,
    required String selectedTable,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Đặt món ăn',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Bàn: $selectedTable',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          const Divider(height: 1),
          Expanded(
            child: products.isEmpty
                ? const Center(
              child: Text('Không có món ăn nào'),
            )
                : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final quantity = cartQuantities[product.id!] ?? 0;
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(product.image1),
                    ),
                    title: Text(
                      product.name1,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.mota,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(product.price),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    trailing: quantity == 0
                        ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          cartQuantities[product.id!] = 1;
                          if (!cartItems.contains(product)) {
                            cartItems.add(product);
                          }
                        });
                        onUpdateCart();
                      },
                      child: const Text('Thêm'),
                    )
                        : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) {
                                cartQuantities[product.id!] = quantity - 1;
                              } else {
                                cartQuantities.remove(product.id!);
                                cartItems.remove(product);
                              }
                            });
                            onUpdateCart();
                          },
                        ),
                        Text('$quantity'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              cartQuantities[product.id!] = quantity + 1;
                            });
                            onUpdateCart();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Giỏ hàng và nút đặt món
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: const Border(top: BorderSide(color: Colors.grey, width: 0.5)),
            ),
            child: Column(
              children: [
                // Thông tin giỏ hàng
                if (cartItems.isNotEmpty)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Giỏ hàng:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${cartItems.length} món',
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ...cartItems.map((item) {
                        final quantity = cartQuantities[item.id!] ?? 0;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name1} x$quantity',
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(item.price * quantity),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 8),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Tổng cộng:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(
                              cartItems.fold<double>(0, (sum, item) {
                                final quantity = cartQuantities[item.id!] ?? 0;
                                return sum + (item.price * quantity);
                              }),
                            ),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),

                // Nút đặt món
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: cartItems.isEmpty ? null : onSubmitOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cartItems.isEmpty ? Colors.grey : Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      cartItems.isEmpty ? 'Chưa có món nào' : 'ĐẶT MÓN',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List<Product> combos = [
    Product(anhs: [
      "https://images.pexels.com/photos/3297807/pexels-photo-3297807.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
      "https://images.pexels.com/photos/6646067/pexels-photo-6646067.jpeg?auto=compress&cs=tinysrgb&w=300&h=300",
    ]),
  ];

  final Map<int, PageController> _controller = {};

  @override
  void initState() {
    super.initState();
    _loadReservedTables();
    for (int i = 0; i < combos.length; i++) {
      _controller[i] = PageController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: const Text("Đặt bàn", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LichSuDatBan(userId: widget.userId)));
            },
            icon: const Icon(Icons.history_outlined, color: Colors.white),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              for (int index = 0; index < combos.length; index++) ...[
                SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView(
                        controller: _controller[index],
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            combos[index].anhs.length,
                                (i) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Họ tên',
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng nhập họ tên' : null,
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
                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng nhập số điện thoại' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: _tableController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Số bàn',
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng chọn bàn' : null,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Chọn số bàn', style: TextStyle(color: Colors.black)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(9, (i) {
                            String table = 'Bàn ${i + 1}';
                            bool isReserved = _reservedTables.contains(table);
                            return RadioListTile<String>(
                              value: table,
                              title: Text(
                                table + (isReserved ? " (Đã đặt)" : ""),
                                style: TextStyle(
                                  color: isReserved ? Colors.grey : Colors.black,
                                ),
                              ),
                              groupValue: _selectedTable,
                              onChanged: isReserved
                                  ? null
                                  : (value) {
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
              SizedBox(height: 15),
              TextFormField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: 'Ngày đặt',
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: const Icon(Icons.date_range, color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng chọn ngày đặt' : null,
                onTap: () async {
                  DateTime today = DateTime.now();
                  DateTime? pickDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(today.year, today.month, today.day),
                    lastDate: DateTime(2050),
                    initialDate: today,
                  );
                  if (pickDate != null) {
                    String formattedDate = DateFormat('dd/MM/yyyy').format(pickDate);
                    setState(() {
                      _dateController.text = formattedDate;
                      _dateTime = pickDate;
                    });
                  }
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                readOnly: true,
                controller: _timeController,
                decoration: InputDecoration(
                  hintText: 'Giờ đặt',
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: const Icon(Icons.access_time, color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? 'Vui lòng chọn giờ' : null,
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
                    String formattedTime = DateFormat('HH:mm').format(selectedDateTime);
                    setState(() {
                      _timeController.text = formattedTime;
                    });
                  }
                },
              ),
              SizedBox(height: 15,),
              ElevatedButton(
                onPressed: _showFoodOrderBottomSheet,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.restaurant_menu, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Đặt món ăn',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _placeBooking,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Đặt bàn',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
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
                    context, MaterialPageRoute(builder: (context) => TrangChu(userId: widget.userId)));
              }),
              buildBottomNavItem(Icons.calendar_month_outlined, "Đặt bàn", 2, () {
                setState(() => _selectedIndex = 2);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DatBan(userId: widget.userId)));
              }),
              buildBottomNavItem(Icons.history, "Lịch sử", 3, () {
                setState(() => _selectedIndex = 3);
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => LichSuMuaHang(userId: widget.userId)));
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

  Widget buildBottomNavItem(IconData icon, String label, int index, VoidCallback onTap) {
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
          Text(label, style: TextStyle(color: isSelected ? Colors.blue : Colors.white)),
        ],
      ),
    );
  }
}