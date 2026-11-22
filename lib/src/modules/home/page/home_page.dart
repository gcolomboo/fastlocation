import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:mobx/mobx.dart';
import '../../../routes/app_routes.dart';
import '../controller/home_controller.dart';
import '../model/address_model.dart';
import '../components/address_tile.dart';
import '../components/empty_address.dart';
import '../components/last_address_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final cep = TextEditingController(), uf = TextEditingController(),
      city = TextEditingController(), street = TextEditingController();
  late final ReactionDisposer errorReaction;
  bool byCep = true;
  bool searched = false;
  @override void initState() {
    super.initState();
    controller.loadLast();
    errorReaction = reaction<String?>((_) => controller.error.value, (message) {
      if (message != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      }
    });
  }
  @override void dispose() {
    errorReaction(); cep.dispose(); uf.dispose(); city.dispose(); street.dispose();
    super.dispose();
  }
  Future<void> _search() async {
    FocusScope.of(context).unfocus();
    setState(() => searched = true);
    if (byCep) { await controller.searchCep(cep.text); }
    else { await controller.searchAddress(uf.text, city.text, street.text); }
  }
  Future<void> _route(AddressModel item) async {
    try {
      final target = [item.logradouro, item.bairro, item.localidade, item.uf, 'Brasil']
          .where((part) => part.trim().isNotEmpty).join(', ');
      final matches = await locationFromAddress(target);
      if (matches.isEmpty) throw StateError('Sem coordenadas');
      final maps = await MapLauncher.installedMaps;
      if (maps.isEmpty) throw StateError('Sem aplicativos de mapas');
      final location = matches.first;
      if (!mounted) return;
      await showModalBottomSheet<void>(context: context, builder: (context) =>
        SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [
          const ListTile(title: Text('Escolha um aplicativo de mapas')),
          ...maps.map((map) => ListTile(
            leading: const Icon(Icons.map_outlined), title: Text(map.mapName),
            onTap: () async {
              Navigator.pop(context);
              await map.showDirections(destination: Coords(location.latitude, location.longitude),
                destinationTitle: item.fullAddress);
            })),
        ])));
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Não foi possível abrir a rota. Confira a conexão e os aplicativos de mapas.')));
    }
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('FastLocation'), actions: [
      IconButton(tooltip: 'Histórico', onPressed: () =>
        Navigator.pushNamed(context, AppRoutes.history), icon: const Icon(Icons.history)),
    ]),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Text('Encontre o endereço da sua entrega',
        style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 14),
      SegmentedButton<bool>(segments: const [
        ButtonSegment(value: true, label: Text('Por CEP'), icon: Icon(Icons.pin_drop_outlined)),
        ButtonSegment(value: false, label: Text('Por endereço'), icon: Icon(Icons.search)),
      ], selected: {byCep}, onSelectionChanged: (selection) => setState(() {
        byCep = selection.first; searched = false; controller.clearResults();
      })),
      const SizedBox(height: 16),
      if (byCep) TextField(controller: cep, keyboardType: TextInputType.number,
        maxLength: 9, decoration: const InputDecoration(labelText: 'CEP',
          hintText: 'Ex.: 01001000', prefixIcon: Icon(Icons.location_on_outlined)))
      else ...[
        TextField(controller: uf, textCapitalization: TextCapitalization.characters,
          maxLength: 2, decoration: const InputDecoration(labelText: 'UF (ex.: SP)')),
        const SizedBox(height: 10),
        TextField(controller: city, decoration: const InputDecoration(labelText: 'Cidade')),
        const SizedBox(height: 10),
        TextField(controller: street, decoration: const InputDecoration(
          labelText: 'Logradouro (rua, avenida...)')),
      ],
      const SizedBox(height: 12),
      Observer(builder: (_) => FilledButton.icon(
        onPressed: controller.loading.value ? null : _search,
        icon: const Icon(Icons.search), label: const Text('Consultar endereço'))),
      const SizedBox(height: 16),
      Observer(builder: (_) {
        if (controller.loading.value) return const Padding(
          padding: EdgeInsets.all(24), child: Center(child: CircularProgressIndicator()));
        final items = controller.results.toList();
        if (items.isEmpty && searched && controller.error.value == null) {
          return const EmptyAddress();
        }
        return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          if (items.isNotEmpty) Text('Resultados (${items.length})',
            style: Theme.of(context).textTheme.titleMedium),
          ...items.map((item) => AddressTile(address: item, onRoute: () => _route(item))),
        ]);
      }),
      Observer(builder: (_) => controller.last.value == null ? const SizedBox.shrink() :
        LastAddressCard(address: controller.last.value!,
          onRoute: () => _route(controller.last.value!))),
    ]),
  );
}
