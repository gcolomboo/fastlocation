import '../../../shared/storage/local_storage.dart';
import '../model/address_model.dart';
class HistoryRepository {
  final LocalStorage storage;
  HistoryRepository({LocalStorage? storage}) : storage = storage ?? LocalStorage();
  List<AddressModel> all() => storage.getAll();
  Future<void> save(AddressModel address) => storage.save(address);
  Future<void> clear() => storage.clear();
}
