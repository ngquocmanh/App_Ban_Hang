import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/CardProvider.dart';
import 'package:intl/intl.dart';
import '../Provider/HistoryProvider.dart';

class Pay2 extends StatelessWidget {
  const Pay2({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cart;
    final total = cartProvider.totalPrice;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Thanh toán sản phẩm',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white60, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Địa chỉ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Nhập địa chỉ của bạn',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          suffixIcon: Icon(Icons.edit,color: Colors.white,),
                          filled: true,
                          fillColor: Colors.white12,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  color: Colors.black,
                  margin:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: const BorderSide(color: Colors.white60, width: 1),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.image1,
                            width:10,
                            height: 10,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${item.name1} x${item.quantity}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${NumberFormat.decimalPattern('vi').format(item.price * item.quantity)} VND",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              cartProvider.removeFromCart(item);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Đã xóa ${item.name1}')),
                              );
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'Tổng tiền : ${NumberFormat.decimalPattern('vi').format(total)} VND',
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                    color: Colors.white, width: 1.5),
                              ),
                              title: Text(
                                'Xác nhận thanh toán ${NumberFormat.decimalPattern('vi').format(total)} VND',
                                style: const TextStyle(color: Colors.white),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Thanh toán thành công $total VND')),
                                        );
                                        final historyProvider =
                                        Provider.of<HistoryProvider>(
                                            context,
                                            listen: false);
                                        historyProvider.addToHistory(
                                            List.from(cartProvider.cart));
                                        cartProvider.clearCart();
                                      },
                                      child: const Text('Đồng ý'),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      label: const Text('Hủy'),
                                      icon: const Icon(Icons.cancel),
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.black,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 30),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          },
                        );
                      },
                      label: const Text('Thanh toán'),
                      icon: const Icon(Icons.payment),
                      style: ElevatedButton.styleFrom(
                        iconColor: Colors.black,
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                    ),
                    const SizedBox(width: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: const Text('Quay lại'),
                      icon: const Icon(Icons.arrow_back),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
