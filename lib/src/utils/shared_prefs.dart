import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<bool> add(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(key, jsonEncode(value));

    print("apasih isinya key ni kle => $key");
    print("apasih isinya value ni kle => $value");
    return prefs.setBool(key, value);
  }

  Future<bool> read(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return jsonDecode(prefs.getString(key));
    bool data = prefs.getBool(key) ?? false;
    print("apasih isinya data ni kle => $data");
    return data;
  }

  Future<bool> delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
