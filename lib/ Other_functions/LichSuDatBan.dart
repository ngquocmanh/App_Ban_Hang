import 'package:flutter/material.dart';
import '../db/BookingDataBaseHepler.dart';
import '../db/book_table.dart';

class LichSuDatBan extends StatefulWidget {
  const LichSuDatBan({super.key});

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
    _bookings = BookingDataBaseHelper.instance.getAllBookings().then(
          (maps) => maps.map((map) => Booking.fromMap(map)).toList(),
    );
  }

  void _deleteBooking(int id) async {
    await BookingDataBaseHelper.instance.deleteBooking(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Xoá đặt bàn thành công!')),
    );
    setState(() {
      _loadBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Lịch sử đặt bàn',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Booking>>(
        future: _bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Chưa có lịch sử đặt bàn'));
          } else {
            final bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      booking.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text('Số điện thoại: ${booking.phone}'),
                        Text('Bàn: ${booking.soBan}'),
                        Text(
                            'Ngày: ${booking.bookingdate} - Giờ: ${booking.bookingtime}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteBooking(booking.id!);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
