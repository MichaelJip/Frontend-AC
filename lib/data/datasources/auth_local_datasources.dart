import 'package:astro_front/data/models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(LoginResponseModel loginResponseData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', loginResponseData.data ?? '');
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token'); // Retrieve only the token
  }

  Future<bool> isAuthExists() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }
}
