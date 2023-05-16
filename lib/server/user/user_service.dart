import '../../models/user_model.dart';
import '../dio_http_client.dart';
import '../global_variables.dart';

class UserService {
  Future<UserModel> getUserView() async {
    UserModel data;

    int userId = int.parse(await storage.read(key: userKey) as String);
    Map<String, int> queryParameters = {"id": userId};

    var response = await DioHttpClient.dio
        .get('User/user-by-id', queryParameters: queryParameters);

    data = (UserModel.fromJson(response.data));

    return data;
  }

  Future<List<UserModel>> getAllUsersView() async {
    List<UserModel> data = List.empty(growable: true);

    var response = await DioHttpClient.dio.get('User/users');

    for (var jsonData in response.data) {
      data.add(UserModel.fromJson(jsonData));
    }
    return data;
  }
}
