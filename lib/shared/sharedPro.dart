import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference1{

Future<bool> setSellerId(String sellerId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("sellerID", sellerId);
}

Future<String> getSellerId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("sellerID") ?? '';
}

Future<bool> setProId(String proId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("product_id", proId);
}

Future<String> getProId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("product_id") ?? '';
}

}