import 'package:flutter_starter/app/responses/users_reponse.dart';
import 'package:flutter_starter/app/networking/api_base_helper.dart';

class UserRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future signIn(body) async {
    final response = await _helper.signIn("auth/sign_in", body);
    return UserAuthResponse.fromJson(response).data;
  }

  Future signUp(body) async {
    final response = await _helper.signUp("auth", body);
    return UserAuthResponse.fromJson(response).data;
  }

  Future signOut() async {
    final response = await _helper.signOut("auth/sign_out");
    return UserSignOutResponse.fromJson(response).data;
  }

  Future update(id, body) async {
    final response = await _helper.put("users/$id", body);
    return UserAuthResponse.fromJson(response).data;
  }

  Future delete(id) async {
    final response = await _helper.delete("users/$id");
  }

  Future index(typeOf, pageNumber) async {
    final response =
        await _helper.get("users?type_of=$typeOf&page=$pageNumber");
    return UsersIndexResponse.fromJson(response).data;
  }
}
