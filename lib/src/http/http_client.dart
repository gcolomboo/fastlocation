import 'package:dio/dio.dart';
class HttpClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: 'https://viacep.com.br/ws/',
    connectTimeout: const Duration(seconds: 12),
    receiveTimeout: const Duration(seconds: 12),
    responseType: ResponseType.json,
  ));
}
