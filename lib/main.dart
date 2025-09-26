import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CardProvider.dart';
import 'ReviewProvider.dart';
import 'DangNhap.dart';
import 'GiaoDien.dart';
import 'Thanhtoan.dart';
import 'TrangChu.dart';
import 'HistoryProvider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      routes: {
        '/login': (context) => const Dangnhap(),
        '/shop': (context) => const Shop2(),
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
