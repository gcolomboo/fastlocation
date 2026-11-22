import 'package:mobx/mobx.dart';
import '../../home/model/address_model.dart';
import '../../home/repositories/history_repository.dart';
class HistoryController {
  final HistoryRepository repository;
  HistoryController({HistoryRepository? repository}) : repository = repository ?? HistoryRepository();
  final items = ObservableList<AddressModel>();
  final loading = Observable(false);
  void load() {
    runInAction(() {
      loading.value = true;
      try { items..clear()..addAll(repository.all()); }
      finally { loading.value = false; }
    });
  }
  Future<void> clear() async { await repository.clear(); load(); }
}
