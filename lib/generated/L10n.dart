// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Trans {
  Trans();

  static Trans? _current;

  static Trans get current {
    assert(_current != null,
        'No instance of Trans was loaded. Try to initialize the Trans delegate before accessing Trans.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Trans> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Trans();
      Trans._current = instance;

      return instance;
    });
  }

  static Trans of(BuildContext context) {
    final instance = Trans.maybeOf(context);
    assert(instance != null,
        'No instance of Trans present in the widget tree. Did you add Trans.delegate in localizationsDelegates?');
    return instance!;
  }

  static Trans? maybeOf(BuildContext context) {
    return Localizations.of<Trans>(context, Trans);
  }
  /// `OFF`
  String get offer_off {
    return Intl.message(
      'オフ',
      name: 'offer_off',
      desc: '',
      args: [],
    );
  }
  String get tapAgainToLeave {
    return Intl.message(
      'もう一度タップして終了します',
      name: 'tapAgainToLeave',
      desc: '',
      args: [],
    );
  }
  String get login_content {
    return Intl.message(
      'LAXIAEログイン\n',
      name: 'login_content',
      desc: '',
      args: [],
    );
  }
  String get lets_start_with_login {
    return Intl.message(
      '日記、投稿や、通知やコメント、クリニックの予約などができるようになります。',
      name: 'lets_start_with_login',
      desc: '',
      args: [],
    );
  }
  String get email {
    return Intl.message(
      'メールアドレスで始める',
      name: 'email',
      desc: '',
      args: [],
    );
  }
  String get continues {
    return Intl.message(
      'で続ける',
      name: 'continues',
      desc: '',
      args: [],
    );
  }
  String get i_forgot_password {
    return Intl.message(
      'パスワードを忘れましたか？',
      name: 'i_forgot_password',
      desc: '',
      args: [],
    );
  }
  String get register {
    return Intl.message(
      '登録',
      name: 'register',
      desc: '',
      args: [],
    );
  }
  String get signup_contents {
    return Intl.message(
      'LAXIAに登録する\n',
      name: 'signup_contents',
      desc: '',
      args: [],
    );
  }
  String get lets_start_with_signup {
    return Intl.message(
      'プロフィールを作って、ほかのユーザーを\nフォローしたり自分の体験日記を作ってみよう!',
      name: 'lets_start_with_signup',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Trans> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Trans> load(Locale locale) => Trans.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
