import 'package:http_interceptor/http_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var accessToken = prefs.getString('accessToken');
      var uid = prefs.getString('uid');
      var client = prefs.getString('client');
      data.headers["access-token"] = accessToken ?? "";
      data.headers["uid"] = uid ?? "";
      data.headers["client"] = client ?? "";
      data.headers["token-type"] = 'Bearer';
      data.headers["Content-Type"] = "application/json";
    } catch (e) {
      print(e);
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accessToken', data.headers?['access-token'] ?? "");
      await prefs.setString('client', data.headers?['client'] ?? "");
    }
    return data;
  }
}
