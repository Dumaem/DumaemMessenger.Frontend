import 'dart:io';

import 'package:dumaem_messenger/pages/authorization.dart';
import 'package:dumaem_messenger/pages/create_chat_page.dart';
import 'package:dumaem_messenger/pages/personal_data_page.dart';
import 'package:dumaem_messenger/pages/select_users_for_existing_chat.dart';
import 'package:dumaem_messenger/pages/select_users_for_new_chat_page.dart';
import 'package:dumaem_messenger/pages/landing.dart';
import 'package:dumaem_messenger/pages/registration.dart';
import 'package:dumaem_messenger/properties/config.dart';
import 'package:dumaem_messenger/server/dio_http_client.dart';
import 'package:dumaem_messenger/class_builder.dart';
import 'package:dumaem_messenger/pages/settings_page.dart';
import 'package:dumaem_messenger/server/global_variables.dart';
import 'package:flutter/material.dart';
import 'components/home_page.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'pages/chat.dart';
import 'pages/chat_info_page.dart';
import 'pages/chats_page.dart';

Future main() async {
  ClassBuilder.registerClasses();
  HttpOverrides.global = MyHttpOverrides();
  DioHttpClient.initializeStaticDio();
  WidgetsFlutterBinding.ensureInitialized();

  String? isDarkTheme = await storage.read(key: "isDarkTheme");
  var themeMode = isDarkTheme == null
      ? ThemeMode.light
      : isDarkTheme == "false"
          ? ThemeMode.light
          : ThemeMode.dark;
  isLightTheme = themeMode == ThemeMode.light;
  runApp(Messenger(
    themeMode: themeMode,
  ));
}

class Messenger extends StatefulWidget {
  Messenger({super.key, this.themeMode = ThemeMode.system});
  ThemeMode themeMode;

  @override
  MessengerApp createState() => MessengerApp();

  static MessengerApp of(BuildContext context) =>
      context.findAncestorStateOfType<MessengerApp>()!;
}

class MessengerApp extends State<Messenger> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      themeMode: widget.themeMode,
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
        '/selectUsersForNewChat': (context) =>
            const SelectUsersForNewChatPage(),
        'selectUsersForExistingChat': (context) =>
            const SelectUsersForExistingChatPage(),
        'createChat': (context) => const CreateChatPage(),
        '/registration': (context) => const RegistrationPage(),
        '/personalData': (context) => const PersonalDataPage()
      },
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      widget.themeMode = themeMode;
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
