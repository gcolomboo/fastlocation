import 'package:mobx/mobx.dart';
import '../model/address_model.dart';
import '../service/address_service.dart';
class HomeController {
  final AddressService service;
  HomeController({AddressService? service}) : service = service ?? AddressService();
  final loading = Observable(false);
  final error = Observable<String?>(null);
  final results = ObservableList<AddressModel>();
  final last = Observable<AddressModel?>(null);
  Future<void> searchCep(String cep) => _run(() => service.searchCep(cep));
  Future<void> searchAddress(String uf, String city, String street) =>
      _run(() => service.searchAddress(uf, city, street));
  Future<void> _run(Future<List<AddressModel>> Function() task) async {
    if (loading.value) return;
    runInAction(() { loading.value = true; error.value = null; results.clear(); });
    try {
      final items = await task();
      runInAction(() {
        results.addAll(items);
        if (items.isNotEmpty) last.value = items.first;
      });
    } catch (e) {
      runInAction(() { error.value = e is FormatException ? e.message :
        'Não foi possível consultar. Verifique a internet e tente novamente.'; });
    } finally { runInAction(() => loading.value = false); }
  }
}
