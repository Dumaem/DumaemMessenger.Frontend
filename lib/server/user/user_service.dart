import '../../models/user.dart';
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
    UserModel currentUser = await getUserView();
    var dataWithoutCurrentUser =
        data.where((element) => element.id != currentUser.id).toList();
    return dataWithoutCurrentUser;
  }

  Future<List<UserModel>> getChatMembers(String chatGuid) async {
    List<UserModel> data = List.empty(growable: true);
    Map<String, String> queryParameters = {"name": chatGuid};

    var response = await DioHttpClient.dio
        .get('Chat/get-chat-members-by-name', queryParameters: queryParameters);

    for (var jsonData in response.data) {
      data.add(UserModel.fromJson(jsonData));
    }

    return data;
  }

  Future<void> putUserData(
      String newName, String newUsername, String newEmail) async {
    int userId = int.parse(await storage.read(key: userKey) as String);

    Map<String, dynamic> queryNameParameters = {"id": userId, "name": newName};
    Map<String, dynamic> queryUsernameParameters = {
      "id": userId,
      "username": newUsername
    };
    Map<String, dynamic> queryEmailParameters = {
      "id": userId,
      "email": newEmail
    };

    try {
      await DioHttpClient.dio
          .put('User/changeName', queryParameters: queryNameParameters);
      await DioHttpClient.dio
          .put('User/changeUsername', queryParameters: queryUsernameParameters);
      await DioHttpClient.dio
          .put('User/changeEmail', queryParameters: queryEmailParameters);
    } catch (exception) {
      throw Exception('Изменение данных невозможно');
    }
  }
}
