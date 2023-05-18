import 'dart:io';

import 'package:dumaem_messenger/pages/authorization.dart';
import 'package:dumaem_messenger/pages/create_chat_page.dart';
import 'package:dumaem_messenger/pages/landing.dart';
import 'package:dumaem_messenger/pages/registration.dart';
import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:dumaem_messenger/class_builder.dart';
import 'package:dumaem_messenger/pages/settings_page.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'components/home_page.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/chat.dart';
import 'pages/chat_info_page.dart';
import 'pages/chats_page.dart';

void main() {
  ClassBuilder.registerClasses();
  HttpOverrides.global = MyHttpOverrides();
  DioHttpClient.initializeStaticDio();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Messenger());
}

class Messenger extends StatefulWidget {
  const Messenger({super.key});

  @override
  MessengerApp createState() => MessengerApp();

  static MessengerApp of(BuildContext context) =>
      context.findAncestorStateOfType<MessengerApp>()!;
}

class MessengerApp extends State<Messenger> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return EasyDynamicThemeWidget(
      child: MaterialApp(
        initialRoute: '/landing',
        navigatorKey: navigatorKey,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: _themeMode,
        debugShowCheckedModeBanner: false,
        home: const AuthorizationPage(),
        routes: {
          '/landing': (context) => const LandingPage(),
          '/home': (context) => const HomePage(),
          '/settings': (context) => const SettingsPage(),
          '/authorization': (context) => const AuthorizationPage(),
          '/chats': (context) => ChatsPage(),
          '/chatInfo': (context) => const ChatInfoPage(),
          '/chat': (context) => const ChatPage(),
          '/createChat': (context) => const CreateChatPage(),
          '/registration': (context) => const RegistrationPage()
        },
      ),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
