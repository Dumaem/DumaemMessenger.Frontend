// lib/env/env.dart
import 'envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'KEY1')
  static const serverUrl = _Env.serverUrl;
}
