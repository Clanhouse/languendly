import 'package:dio/dio.dart';
import 'package:frontend/models/models.dart';
import 'package:frontend/utilities/utilities.dart';
import 'package:frontend/widgets/custom_flash_bar.dart';

class AuthRepository {
  Future<Auth?> signUp(String email, String password) async {
    try {
      var dio = Dio();
      var response = await dio.post('http://localhost:8000/api/token/', data: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        Auth(access: response.data['access'], refresh: response.data['refresh']);
      }
    } catch (e) {
      customFlashBar(Strings.something_went_wrong());
    }
  }

  Future<Auth?> signIn(String email, String password) async {
    try {
      var dio = Dio();
      var response = await dio.post('http://localhost:8000/api/token/', data: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        return Auth(access: response.data['access'], refresh: response.data['refresh']);
      }
    } catch (e) {
      customFlashBar(Strings.something_went_wrong());
    }
  }

  Future<String?> refreshToken(Auth auth) async {
    try {
      var dio = Dio();
      dio.options.headers['content-Type'] = 'application/json';
      var response = await dio.post('http://localhost:8000/api/token/refresh/', data: {'refresh': auth.refresh});
      return response.data['access'];
    } catch (e) {
      Logger().e(e);
    }
  }

  resetPassword() async {
    try {
      var response = await Dio().get('http://www.google.com');
    } catch (e) {
      print(e);
    }
  }
}
