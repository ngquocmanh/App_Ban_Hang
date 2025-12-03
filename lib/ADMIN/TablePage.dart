// import 'package:flutter/material.dart';
// import 'package:app_01/db/BookingDataBaseHepler.dart';
// class TablePage extends StatefulWidget {
//   const TablePage({super.key});
//
//   @override
//   State<TablePage> createState() => _TablePageState();
// }
//
// class _TablePageState extends State<TablePage> {
//   List<Ban> danhSachBan = List.generate(
//     9,
//         (index) => Ban(id: index, name: "Bàn ${index + 1}"),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _loadBookings();
//   }
//
//   Future<void> _loadBookings() async {
//     final data = await BookingDataBaseHelper.instance.getAllBookings();
//
//     setState(() {
//       danhSachBan.forEach((ban) {
//         final booking = data.firstWhere(
//               (b) => b['soBan'] == ban.name,
//           orElse: () => {},
//         );
//
//         if (booking.isNotEmpty) {
//           ban.status = 'daDat';
//           ban.customerName = booking['name'];
//           ban.customerPhone = booking['phone'];
//         } else {
//           ban.status = 'trong';
//           ban.customerName = null;
//           ban.customerPhone = null;
//         }
//       });
//     });
//   }
//
//   void _xoaBooking(Ban ban) async {
//     final data = await BookingDataBaseHelper.instance.getAllBookings();
//     final booking = data.firstWhere(
//           (b) => b['soBan'] == ban.name,
//       orElse: () => {},
//     );
//
//     if (booking.isNotEmpty) {
//       await BookingDataBaseHelper.instance.deleteBooking(booking['id']);
//       setState(() {
//         ban.status = 'trong';
//         ban.customerName = null;
//         ban.customerPhone = null;
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Đã xoá booking ${ban.name}')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quản lý bàn'),
//         centerTitle: true,
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 1,
//         ),
//         itemCount: danhSachBan.length,
//         itemBuilder: (context, index) {
//           final ban = danhSachBan[index];
//           Color color = ban.status == 'daDat' ? Colors.red : Colors.green;
//           return GestureDetector(
//             onTap: () {
//               if (ban.status == 'daDat') {
//
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       title: Text('Thông tin ${ban.name}'),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('Tên khách: ${ban.customerName}'),
//                           Text('SĐT: ${ban.customerPhone}'),
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () => Navigator.pop(context),
//                           child: const Text('Đóng'),
//                         ),
//                         TextButton(
//                           onPressed: () {
//                             _xoaBooking(ban);
//                             Navigator.pop(context);
//                           },
//                           child: const Text('Xoá booking', style: TextStyle(color: Colors.red)),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Center(
//                 child: Text(
//                   ban.name,
//                   style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
// class Ban {
//   int id;
//   String name;
//   String status;
//   String? customerName;
//   String? customerPhone;
//
//   Ban({required this.id, required this.name, this.status = 'trong', this.customerName, this.customerPhone});
// }
