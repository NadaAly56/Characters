import 'package:bloc_state_management/utilities/strings.dart';
import 'package:dio/dio.dart';

class CharactersServices {
  late Dio dio;

  CharactersServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 30 * 1000),
      receiveTimeout: Duration(milliseconds: 30 * 1000),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getCharacters() async {
    Response response = await dio.get('character');
    return response.data;
  }
}
