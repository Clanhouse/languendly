import 'package:dio/dio.dart';
import 'package:frontend/utilities/utilities.dart';
import 'package:frontend/widgets/custom_flash_bar.dart';

class AuthRepository {
  Future<Map<dynamic, String>?> signUp(String email, String password) async {
    try {
      var dio = Dio();
      var response = await dio.post('http://localhost:8000/api/token/', data: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        Map<dynamic, String> map = new Map();
        map['access'] = response.data['access'];
        map['refresh'] = response.data['refresh'];
      }
    } catch (e) {
      customFlashBar(Strings.something_went_wrong());
    }
  }

  Future<Map<dynamic, String>?> signIn(String email, String password) async {
    try {
      var dio = Dio();
      var response = await dio.post('http://localhost:8000/api/token/', data: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        Map<dynamic, String> map = new Map();
        map['access'] = response.data['access'];
        map['refresh'] = response.data['refresh'];

        return map;

        // dio.options.headers['content-Type'] = 'application/json';
        //
        // dio.options.headers["Authorization"] = "Bearer ${response.data['access']}";
        //
        // var test = await dio.post('http://localhost:8000/words/', data: {
        //   'word': 'test3',
        //   'translation': 'test3',
        //   'language': 'ENG',
        //   'level': 'A1',
        // });
        // Logger().i(test);
      }
    } catch (e) {
      customFlashBar(Strings.something_went_wrong());
    }
  }

  refreshToken(String refresh) async {
    try {
      var dio = Dio();
      var a = await dio.post('http://localhost:8000/api/token/refresh', data: {"refresh": refresh});
    } catch (e) {}
  }

  resetPassword() async {
    try {
      var response = await Dio().get('http://www.google.com');
    } catch (e) {
      print(e);
    }
  }
}
