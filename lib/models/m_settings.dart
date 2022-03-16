import 'package:flutter/material.dart';

// import '../common/custom_trace.dart';

class Setting {
  String? appName = '';
  double? defaultTax;
  String? defaultCurrency;
  String? distanceUnit = 'km';
  bool currencyRight = false;
  int currencyDecimalDigits = 2;
  bool payPalEnabled = true;
  bool stripeEnabled = true;
  bool razorPayEnabled = true;
  String? mainColor;
  late String mainDarkColor;
  late String secondColor;
  late String secondDarkColor;
  late String accentColor;
  late String accentDarkColor;
  String? scaffoldDarkColor;
  late String scaffoldColor;
  String? googleMapsKey;
  ValueNotifier<Locale> mobileLanguage = ValueNotifier(const Locale('ja', ''));
  late String appVersion = '2.0.0';
  bool enableVersion = true;
  List<String?> homeSections = [];

  ValueNotifier<Brightness> brightness = ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] as String;
      mainColor = jsonMap['main_color'] as String;
      mainDarkColor = jsonMap['main_dark_color'] as String;
      secondColor = jsonMap['second_color'] as String;
      secondDarkColor = jsonMap['second_dark_color'] as String;
      accentColor = jsonMap['accent_color'] as String;
      accentDarkColor = jsonMap['accent_dark_color'] as String;
      scaffoldDarkColor = jsonMap['scaffold_dark_color'] as String;
      scaffoldColor = jsonMap['scaffold_color'] as String;
      googleMapsKey = jsonMap['google_maps_key'] as String;
      mobileLanguage.value = jsonMap['mobile_language'] == null ? Locale(jsonMap['mobile_language'] as String) : const Locale('ja');
      appVersion = jsonMap['app_version'] as String;
      distanceUnit = jsonMap['distance_unit'] == null ? null : jsonMap['distance_unit'] as String;
      if (jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0') {
        enableVersion = false;
      } else {
        enableVersion = true;
      }
      defaultTax =
          jsonMap['default_tax'] == null ? null : double.tryParse(jsonMap['default_tax'] as String) ?? 0.0; //double.parse(jsonMap['default_tax'].toString());
      defaultCurrency = jsonMap['default_currency'] == null ? null : jsonMap['default_currency'] as String;
      currencyDecimalDigits = (jsonMap['default_currency_decimal_digits'] == null ? null : int.tryParse(jsonMap['default_currency_decimal_digits'] as String))!;
      currencyRight = jsonMap['currency_right'] as bool;
      payPalEnabled = jsonMap['enable_paypal'] as bool;
      stripeEnabled = jsonMap['enable_stripe'] as bool;
      razorPayEnabled = jsonMap['enable_razorpay'] as bool;
      for (int _i = 1; _i <= 12; _i++) {
        homeSections.add(jsonMap['home_section_$_i'] != null ? jsonMap['home_section_$_i'] as String : 'empty');
      }
    } catch (e) {
      debugPrint(e.toString());
      // print(CustomTrace(StackTrace.current, message: e.toString()));
    }
  }

  Map toMap() {
    final map = <String, dynamic>{};
    map["app_name"] = appName;
    map["default_tax"] = defaultTax;
    map["default_currency"] = defaultCurrency;
    map["default_currency_decimal_digits"] = currencyDecimalDigits;
    map["currency_right"] = currencyRight;
    map["enable_paypal"] = payPalEnabled;
    map["enable_stripe"] = stripeEnabled;
    map["enable_razorpay"] = razorPayEnabled;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    return map;
  }
}
