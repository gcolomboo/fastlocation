import '../model/address_model.dart';
import '../repositories/address_repository.dart';
import '../repositories/history_repository.dart';
class AddressService {
  final AddressRepository addresses;
  final HistoryRepository history;
  AddressService({AddressRepository? addresses, HistoryRepository? history})
      : addresses = addresses ?? AddressRepository(), history = history ?? HistoryRepository();
  Future<List<AddressModel>> searchCep(String cep) async {
    final item = await addresses.byCep(cep);
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
