import 'pages/chats_page.dart';

typedef Constructor<T> = T Function();

final Map<String, Constructor<Object>> _constructors = <String, Constructor<Object>>{};

void register<T>(Constructor<T> constructor) {
  _constructors[T.toString()] = constructor as Constructor<Object>;
}

class ClassBuilder {
  static void registerClasses() {
    register<ChatsPage>(() => ChatsPage());
  }

  static dynamic fromString(String type) {
    return _constructors[type]!();
  }
}