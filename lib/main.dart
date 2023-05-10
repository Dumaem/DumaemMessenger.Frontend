import 'package:flutter/material.dart';
import 'components/hidden_drawer.dart';
import 'localization/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MessengerApp());
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
          primarySwatch:
              buildMaterialColor(const Color.fromARGB(255, 130, 170, 227)),
          primaryColor: const Color.fromARGB(255, 130, 170, 227),
          textTheme: const TextTheme(
            displayLarge: TextStyle(color: Color.fromARGB(255, 154, 216, 228)),
            titleLarge: TextStyle(color: Color.fromARGB(255, 154, 216, 228)),
            bodyMedium: TextStyle(color: Color.fromARGB(255, 14, 18, 19)),
            bodySmall: TextStyle(color: Color.fromARGB(255, 4, 5, 5)),
          ),
          elevatedButtonTheme:
              const ElevatedButtonThemeData(style: ButtonStyle())),
      debugShowCheckedModeBanner: false,
      home: HiddenDrawer(),
/*      routes: {
        '/': (context) => const AuthenticationPage(),
        '/chats': (context) => const ChatsPage(),
        '/chat': (context) => const ChatPage(),
      },*/
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
