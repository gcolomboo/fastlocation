import 'dart:convert';
import 'package:hive/hive.dart';
import '../../modules/home/model/address_model.dart';
class LocalStorage {
  static const boxName = 'fastlocation_history';
  Box<String> get _box => Hive.box<String>(boxName);
  List<AddressModel> getAll() {
    final values = _box.values.toList().reversed;
    final result = <AddressModel>[];
    for (final raw in values) {
      try { result.add(AddressModel.fromJson(Map<String, dynamic>.from(jsonDecode(raw) as Map))); }
      catch (_) { /* Ignora registros locais inválidos. */ }
    }
    return result;
  }
  Future<void> save(AddressModel address) async {
    final key = address.cep.replaceAll(RegExp(r'\D'), '');
    if (key.isEmpty) return;
    await _box.delete(key);
    await _box.put(key, jsonEncode(address.toJson()));
  }
  Future<void> clear() => _box.clear();
}
