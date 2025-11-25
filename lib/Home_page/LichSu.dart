import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../Provider/HistoryProvider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Lịch sử mua hàng", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: Provider.of<HistoryProvider>(context, listen: false).loadHistory(),
        builder: (context, snapshot) {
          return Consumer<HistoryProvider>(
            builder: (context, historyProvider, child) {
              final history = historyProvider.historyList;
              if (history.isEmpty) {
                return const Center(
                  child: Text("Chưa có lịch sử mua hàng",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                );
              }
              return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final item = history[index];
                  return Card(
                    color: Colors.grey[900],
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      leading: Image.network(item.image, width: 40, height: 120),
                      title: Text(item.name,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        "${item.quantity} sản phẩm - "
                            "${NumberFormat.decimalPattern('vi').format(item.price)} VND\n",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          historyProvider.deleteHistory(item.id!);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
