import 'package:dio/dio.dart';
import '../../../http/http_client.dart';
import '../model/address_model.dart';
class AddressRepository {
  final Dio dio;
  AddressRepository({Dio? dio}) : dio = dio ?? HttpClient.dio;
  Future<AddressModel?> byCep(String cep) async {
    final clean = cep.replaceAll(RegExp(r'\D'), '');
    if (!RegExp(r'^\d{8}$').hasMatch(clean)) throw const FormatException('Informe um CEP com 8 números.');
    final response = await dio.get('$clean/json/');
    final data = Map<String, dynamic>.from(response.data as Map);
    if (data['erro'] == true) return null;
    return AddressModel.fromJson(data);
  }
  Future<List<AddressModel>> byAddress(String uf, String city, String street) async {
    if (!RegExp(r'^[A-Za-z]{2}$').hasMatch(uf.trim()) ||
        city.trim().length < 3 || street.trim().length < 3) {
      throw const FormatException('Informe UF (2 letras), cidade e logradouro (mínimo 3 caracteres).');
    }
    final path = '${Uri.encodeComponent(uf.trim())}/${Uri.encodeComponent(city.trim())}/${Uri.encodeComponent(street.trim())}/json/';
    final response = await dio.get(path);
    if (response.data is Map) {
      final data = Map<String, dynamic>.from(response.data as Map);
      if (data['erro'] == true) return [];
      throw const FormatException('Resposta inesperada da API.');
    }
    return (response.data as List).map((e) => AddressModel.fromJson(Map<String, dynamic>.from(e as Map))).toList();
  }
}
