
import 'package:shared_preferences/shared_preferences.dart';
class UserHelper {
  static Future<int?> getCurrentUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      print(' UserHelper.getCurrentUserId() = $userId');

      if (userId == null || userId <= 0) {
        print('Cảnh báo: userId không hợp lệ hoặc null');
        return null;
      }

      return userId;
    } catch (e) {
      print('ERROR UserHelper.getCurrentUserId: $e');
      return null;
    }
  }

  static Future<void> setCurrentUser(int userId, String username, String phone, String role) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userId', userId);
      await prefs.setString('username', username);
      await prefs.setString('phone', phone);
      await prefs.setString('role', role);

      print('Đã lưu user: ID=$userId, Name=$username, Role=$role');
    } catch (e) {
      print(' Lỗi lưu user: $e');
    }
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('userId');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    await prefs.remove('username');
    await prefs.remove('phone');
    await prefs.remove('role');
    print(' Đã đăng xuất, xoá user data');
  }
}