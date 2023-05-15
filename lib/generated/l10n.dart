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

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dumaem Messenger`
  String get app_bar_title {
    return Intl.message(
      'Dumaem Messenger',
      name: 'app_bar_title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop_title {
    return Intl.message(
      'Shop',
      name: 'shop_title',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info_title {
    return Intl.message(
      'Info',
      name: 'info_title',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email_title {
    return Intl.message(
      'Email',
      name: 'email_title',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password_title {
    return Intl.message(
      'Password',
      name: 'password_title',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username_title {
    return Intl.message(
      'Username',
      name: 'username_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name_tile {
    return Intl.message(
      'Name',
      name: 'name_tile',
      desc: '',
      args: [],
    );
  }

  /// `Participants`
  String get participants_title {
    return Intl.message(
      'Participants',
      name: 'participants_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in_title {
    return Intl.message(
      'Sign in',
      name: 'sign_in_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up_title {
    return Intl.message(
      'Sign up',
      name: 'sign_up_title',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get chat_name_title {
    return Intl.message(
      'Name',
      name: 'chat_name_title',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout_title {
    return Intl.message(
      'Logout',
      name: 'logout_title',
      desc: '',
      args: [],
    );
  }

  /// `Riaz`
  String get account_name_test {
    return Intl.message(
      'Riaz',
      name: 'account_name_test',
      desc: '',
      args: [],
    );
  }

  /// `riaz@mail.com`
  String get account_email_test {
    return Intl.message(
      'riaz@mail.com',
      name: 'account_email_test',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message_name_title {
    return Intl.message(
      'Message',
      name: 'message_name_title',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
