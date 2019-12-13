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

  Future addCart(String key, id, {value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cart = [];

    if (prefs.getString("cart") != null) {
      cart = jsonDecode(prefs.getString("cart"));
      List cartKey = [];

      for (var item in cart) {
        cartKey.add(item.keys.first);
      }

      if (cart.isEmpty == false && cartKey.contains(id)) {
        cart[cartKey.indexOf(id)][id]['qty'] += 1;
        cart[cartKey.indexOf(id)][id]['total'] = (cart[cartKey.indexOf(id)][id]
                    ['qty'] *
                int.parse(cart[cartKey.indexOf(id)][id]['price']))
            .toString();
      } else {
        if (value != null) {
          print('um, ketambah? => $value');
          cart.add(value);
        }
      }
    }
    if (cart.isEmpty || cart == null) {
      cart = [];
      cart.add(value);
    }

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
    Future.delayed(Duration(seconds: 10));
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

  Future decreaseCart(String key, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List cart;

    if (prefs.getString(key) != null) {
      cart = jsonDecode(prefs.getString(key));
      List cartKey = [];

      for (var item in cart) {
        cartKey.add(item.keys.first);
      }

      if (cart.isEmpty == false &&
          cart[cartKey.indexOf(id)].containsKey(id) &&
          cart[cartKey.indexOf(id)][id]['qty'] > 0) {
        cart[cartKey.indexOf(id)][id]['qty'] -= 1;
        cart[cartKey.indexOf(id)][id]['total'] =
            (int.parse(cart[cartKey.indexOf(id)][id]['total']) -
                    int.parse(cart[cartKey.indexOf(id)][id]['price']))
                .toString();
      }
    }

    return prefs.setString(key, jsonEncode(cart));
  }
}
