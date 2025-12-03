import 'package:app_01/ADMIN/QlySanPham.dart';
import 'package:app_01/ADMIN/HomePageAdmin.dart';
import 'package:app_01/Provider/SearchProvider.dart';
import 'package:app_01/Provider/SetBrightNess.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/CardProvider.dart';
import 'Provider/ReviewProvider.dart';
import 'Authenticatin/DangNhap.dart';
import 'Authenticatin/GiaoDien.dart';
import 'Pay/Thanhtoan.dart';
import 'Home_page/TrangChu.dart';
import 'Provider/HistoryProvider.dart';
import 'package:get/get.dart';
import 'Provider/UserHepler.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
        ChangeNotifierProvider(create: (_) => SetBrightNess()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: context.watch<SetBrightNess>().isDark
            ? Brightness.dark
            : Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
          labelSmall: const TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
// Trong main.dart, sửa route '/shop'
      routes: {
        '/login': (context) => const Dangnhap(),
        '/shop': (context) => FutureBuilder<int?>(
          future: UserHelper.getCurrentUserId(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (snapshot.hasError) {
              print('Error loading userId: ${snapshot.error}');
              return const Scaffold(
                body: Center(child: Text('Lỗi tải thông tin người dùng')),
              );
            }

            final userId = snapshot.data;
            print('TrangChu với userId: $userId');

            if (userId == null || userId <= 0) {

              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, '/login');
              });
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            return TrangChu(userId: userId);
          },
        ),
        '/admin': (context) => AdminHomePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/pay') {
          return MaterialPageRoute(
            builder: (context) => const Pay2(),
          );
        }
        return null;
      },
      home: const Giaodien(),
    );
  }
}

