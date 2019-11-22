import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future addBool(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(key, jsonEncode(value));

    // print("apasih isinya key ni kle => $key");
    // print("apasih isinya value ni kle => $value");
    return prefs.setBool(key, value);
  }

  Future addCart(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cart;

    if (prefs.getString("cart") != null) {
      cart = jsonDecode(prefs.getString("cart"));
    } else {
      cart = [];
    }
    cart.add(value);

    print(
        "cart after inser => $cart\ncart after inser encode => ${jsonEncode(cart)}\n");

    return prefs.setString(key, jsonEncode(cart));
  }

  Future<bool> readBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return jsonDecode(prefs.getString(key));
    bool data = prefs.getBool(key) ?? false;
    // print("apasih isinya data ni kle => $data");
    return data;
  }

  Future<List> readCart(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // return jsonDecode(prefs.getString(key));
    String data = prefs.getString(key);
    return jsonDecode(data);
  }

  Future delete(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future deleteCart(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cart = jsonDecode(prefs.getString("cart")) ?? [];
    cart.removeAt(id);

    return prefs.setString("cart", jsonEncode(cart));
  }
}
