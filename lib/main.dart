import 'package:dumaem_messenger/class_builder.dart';
import 'package:flutter/material.dart';
import 'components/home_page.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kf_drawer/kf_drawer.dart';

import 'pages/authentication.dart';

void main() {
  ClassBuilder.registerClasses();
  runApp(MessengerApp());
}

class MessengerApp extends StatelessWidget {
  const MessengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 234, 253, 252),
          cardColor: Colors.white,
          primarySwatch:
              buildMaterialColor(const Color.fromARGB(255, 130, 170, 227)),
          primaryColor: const Color.fromARGB(255, 130, 170, 227),
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Colors.black),
            titleLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black, fontSize: 18),
            bodySmall: TextStyle(color: Colors.black),
          ),
          elevatedButtonTheme:
              const ElevatedButtonThemeData(style: ButtonStyle())),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/auth': (context) => const AuthenticationPage(),
        '/home': (context) => const HomePage(),
      },
    );
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
