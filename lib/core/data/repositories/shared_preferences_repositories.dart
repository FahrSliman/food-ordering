import 'dart:convert';
import 'package:food/core/data/models/cart_model.dart';
import 'package:food/core/enum/data_type.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/apis/token_info.dart';

class SharedPreferencesRepositories {
  SharedPreferences globalSharedprefs = Get.find();

  String PREF_FIRST_LAUNCH = 'first_launch';
  String IS_LOGGED_IN = 'is_logged_in';
  String PREF_TOKEN_INFO = 'token_info';
  String PREF_APP_LANG = 'app_language';
  String PREF_CART_LIST = 'cart_list';
  String PREF_ORDER_PLACED = 'order_placed';
    String PREF_SUB_STATUS = 'sub_status';

  setSubStatus(bool value) {
    setPrefrance(
      dataType: DataType.BOOL,
      key: PREF_SUB_STATUS,
      value: value,
    );
  }

  bool getSubStatus() {
    if (globalSharedprefs.containsKey(PREF_SUB_STATUS)) {
      return getPrefrance(key: PREF_SUB_STATUS);
    } else {
      return true;
    }
  }

  setIsLoggedIn(bool value) {
    setPrefrance(dataType: DataType.BOOL, key: IS_LOGGED_IN, value: value);
  }

  bool getIsLoggedIn() {
    if (globalSharedprefs.containsKey(IS_LOGGED_IN)) {
      return getPrefrance(key: IS_LOGGED_IN);
    } else {
      return false;
    }
  }

  setAppLanguage(String value) {
    setPrefrance(
      dataType: DataType.STRING,
      key: PREF_APP_LANG,
      value: value,
    );
  }

  String getAppLanguage() {
    if (globalSharedprefs.containsKey(PREF_APP_LANG)) {
      return getPrefrance(key: PREF_APP_LANG);
    } else {
      return 'ar';
    }
  }

  setFirstLunch(bool value) {
    setPrefrance(
      dataType: DataType.BOOL,
      key: PREF_FIRST_LAUNCH,
      value: value,
    );
  }

  bool getFirstLunch() {
    if (globalSharedprefs.containsKey(PREF_FIRST_LAUNCH)) {
      return getPrefrance(key: PREF_FIRST_LAUNCH);
    } else {
      return true;
    }
  }

  setTokenInfo(TokenInfo value) {
    setPrefrance(
      dataType: DataType.STRING,
      key: PREF_TOKEN_INFO,
      value: jsonEncode(value),
    );
  }

  TokenInfo? getTokenInfo() {
    if (globalSharedprefs.containsKey(PREF_TOKEN_INFO)) {
      return TokenInfo.fromJson(jsonDecode(getPrefrance(key: PREF_TOKEN_INFO)));
    } else {
      return null;
    }
  }

  setPrefrance(
      {required DataType dataType,
      required String key,
      required dynamic value}) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedprefs.setInt(key, value);
        break;
      case DataType.BOOL:
        await globalSharedprefs.setBool(key, value);
        break;
      case DataType.STRING:
        await globalSharedprefs.setString(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedprefs.setDouble(key, value);
        break;
      case DataType.LISTSTRING:
        await globalSharedprefs.setStringList(key, value);
        break;
    }
  }

  dynamic getPrefrance({required String key}) {
    return globalSharedprefs.get(key);
  }

  void setCartList(List<CartModel> list) {
    setPrefrance(
        dataType: DataType.STRING,
        key: PREF_CART_LIST,
        value: CartModel.encode(list));
  }

  List<CartModel> getCartList() {
    if (globalSharedprefs.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getPrefrance(key: PREF_CART_LIST));
    } else {
      return [];
    }
  }

  setOrderPlaced(bool value) {
    setPrefrance(
      dataType: DataType.BOOL,
      key: PREF_ORDER_PLACED,
      value: value,
    );
  }

  bool getOrderPlaced() {
    if (globalSharedprefs.containsKey(PREF_ORDER_PLACED)) {
      return getPrefrance(key: PREF_ORDER_PLACED);
    } else {
      return false;
    }
  }
}
