import '../../models/user.dart';
import '../dio_http_client.dart';

class UserService {
  Future<User> getUser(int id) async {
    Map<String, int> queryParameters = {"id": id};
    var response = await DioHttpClient.dio
        .get('User/user-by-id', queryParameters: queryParameters);
    return User.fromJson(response.data);
  }
}
