import 'package:dio/dio.dart';

import '../../../../../core/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();
  var apiKey = Constants.baseUrl;

  /// current weather api call
  Future<dynamic> callGetData() async {
    var response = await _dio.get(
      '${Constants.baseUrl}/posts',
    );
    return response;
  }
}
