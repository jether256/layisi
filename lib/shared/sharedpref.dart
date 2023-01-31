import 'package:shared_preferences/shared_preferences.dart';


class SharedPreference {

  Future<bool> setLoggedIn(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("logged_in", status);
  }

  Future<bool> getLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("logged_in") ?? false;
  }
  Future<bool> setUserId(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("id", userId);
  }

  Future<String> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("id") ?? '';
  }

  Future<bool> setUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("name", userName);
  }

  Future<String> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("name") ?? '';
  }


  Future<bool> setUserEmail(String userEmail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("email", userEmail);
  }

  Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? '';
  }

  Future<bool> setUserNumber(String userNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("number", userNumber);
  }

  Future<String> getUserNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("number") ?? '';
  }

  Future<bool> setUserPass(String userPass) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("password", userPass);
  }

  Future<String> getUserPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("password") ?? '';
  }

  Future<bool> setUserPic(String userPic) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("pic", userPic);
  }

  Future<String> getUserPic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("pic") ?? '';
  }


  //
  // Future<bool> setUserLoc(String userLoc) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString("location", userLoc);
  // }
  //
  // Future<String> getUserLoc() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString("location") ?? '';
  // }




  Future<bool> setUserAdd(String userAdd) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("address", userAdd);
  }

  Future<String> getUserAdd() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("address") ?? '';
  }

  Future<bool> setUserCity(String userCity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("city", userCity);
  }

  Future<String> getUserCity() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("city") ?? '';
  }

  Future<bool> setUserCountry(String userCountry) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("country", userCountry);
  }

  Future<String> getUserCountry() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("country") ?? '';
  }

  Future<bool> setUserStatus(String userStatus) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("status", userStatus);
  }

  Future<String> getUserStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("status") ?? '';
  }


  

}