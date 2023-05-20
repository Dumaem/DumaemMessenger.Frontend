import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String accessTokenKey = 'accessToken';
const String userKey = 'userId';
const String refreshTokenKey = 'refreshToken';
FlutterSecureStorage storage = const FlutterSecureStorage();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final List<dynamic> savedRequestList = List.empty(growable: true);
bool logoutRequested = false;
