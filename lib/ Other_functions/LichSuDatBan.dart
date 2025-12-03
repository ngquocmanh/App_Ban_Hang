import 'package:flutter/material.dart';
import '../db/BookingDataBaseHepler.dart';
import '../db/book_table.dart';

class LichSuDatBan extends StatefulWidget {
  final int userId;
  const LichSuDatBan({super.key, required this.userId});

  @override
  State<LichSuDatBan> createState() => _LichSuDatBanState();
}

class _LichSuDatBanState extends State<LichSuDatBan> {
  late Future<List<Booking>> _bookings;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    setState(() {
      _bookings = BookingDataBaseHelper.instance.getBookingsByUser(widget.userId);
    });
  }

  void _deleteBooking(int id) async {
    await BookingDataBaseHelper.instance.deleteBooking(id);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Xoá đặt bàn thành công!')),
    );

    _loadBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lịch sử đặt bàn',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<Booking>>(
        future: _bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Chưa có lịch sử đặt bàn'));
          }

          final bookings = snapshot.data!;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, i) {
              final b = bookings[i];

              return Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  title: Text(
                    b.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("📞 SĐT: ${b.phone}"),
                        Text("🪑 Bàn: ${b.soBan}"),
                        Text("📅 Ngày: ${b.bookingdate}"),
                        Text("⏰ Giờ: ${b.bookingtime}"),
                      ],
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteBooking(b.id!),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
