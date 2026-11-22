import '../model/address_model.dart';
import '../repositories/address_repository.dart';
import '../repositories/history_repository.dart';
class AddressService {
  final AddressRepository addresses;
  final HistoryRepository history;
  AddressService({AddressRepository? addresses, HistoryRepository? history})
      : addresses = addresses ?? AddressRepository(), history = history ?? HistoryRepository();
  Future<List<AddressModel>> searchCep(String cep) async {
    final normalized = cep.replaceAll(RegExp(r'\D'), '');
    if (!RegExp(r'^\d{8}$').hasMatch(normalized)) {
      throw const FormatException('Informe um CEP com 8 números.');
    }
    final cached = history.all().where((e) =>
      e.cep.replaceAll(RegExp(r'\D'), '') == normalized).toList();
    if (cached.isNotEmpty) {
      await history.save(cached.first);
      return [cached.first];
    }
    final item = await addresses.byCep(normalized);
    if (item == null) return [];
    await history.save(item);
    return [item];
  }
  Future<List<AddressModel>> searchAddress(String uf, String city, String street) async {
    final items = await addresses.byAddress(uf, city, street);
    for (final item in items) { await history.save(item); }
    return items;
  }
}
