import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/m_settings.dart';

ValueNotifier<Setting> setting = ValueNotifier(Setting());
final navigatorKey = GlobalKey<NavigatorState>();

Future<Setting> initSettings() async {
  Setting _setting;
  String appSetting = await rootBundle.loadString("assets/cfg/app-settings.json");
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('settings', json.encode(json.decode(appSetting)));
  _setting = Setting.fromJSON(json.decode(appSetting) as Map<String, dynamic>);
  // print(prefs.getString("settings"));
  // if (json.decode(appSetting)["language"]!=null) {
  //   _setting.mobileLanguage.value = Locale(json.decode(appSetting)["language"] as String, '');
  // }
  _setting.brightness.value = prefs.getBool('isDark') ?? false ? Brightness.dark : Brightness.light;
  setting.value = _setting;
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  setting.notifyListeners();
  return setting.value;
}

// Future<Setting> initSettings() async {
//   Setting _setting;
//   final String url = '${GlobalConfiguration().getValue('api_base_url')}settings';

//   try {
//     final response = await http.get(url, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
//     if (response.statusCode == 200 && response.headers.containsValue('application/json')) {
//       if (json.decode(response.body)['data'] != null) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('settings', json.encode(json.decode(response.body)['data']));
//         _setting = Setting.fromJSON(json.decode(response.body)['data']);
//         if (prefs.containsKey('language')) {
//           _setting.mobileLanguage.value = Locale(prefs.get('language'), '');
//         }
//         _setting.brightness.value = prefs.getBool('isDark') ?? false ? Brightness.dark : Brightness.light;
//         setting.value = _setting;
//         // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
//         setting.notifyListeners();
//       }
//     } else {
//       print(CustomTrace(StackTrace.current, message: response.body).toString());
//     }
//   } catch (e) {
//     print(CustomTrace(StackTrace.current, message: url).toString());
//     return Setting.fromJSON({});
//   }
//   return setting.value;
// }

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (brightness == Brightness.dark) {
    prefs.setBool("isDark", true);
    brightness = Brightness.dark;
  } else {
    prefs.setBool("isDark", false);
    brightness = Brightness.light;
  }
}

Future<void> setDefaultLanguage(String? language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String?> getDefaultLanguage(String? defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = await (prefs.get('language') as FutureOr<String?>);
  }
  return defaultLanguage;
}

Future<void> saveMessageId(String? messageId) async {
  if (messageId != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('google.message_id', messageId);
  }
}

Future<String?> getMessageId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await (prefs.get('google.message_id') as FutureOr<String?>);
}
