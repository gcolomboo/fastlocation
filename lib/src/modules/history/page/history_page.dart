import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../home/components/address_tile.dart';
import '../../home/components/empty_address.dart';
import '../controller/history_controller.dart';
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});
  @override State<HistoryPage> createState() => _HistoryPageState();
}
class _HistoryPageState extends State<HistoryPage> {
  final controller = HistoryController();
  @override void initState() { super.initState(); controller.load(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Histórico de consultas'), actions: [
      IconButton(tooltip: 'Limpar histórico', icon: const Icon(Icons.delete_outline),
        onPressed: () async {
          final confirm = await showDialog<bool>(context: context,
            builder: (context) => AlertDialog(title: const Text('Limpar histórico?'),
              content: const Text('Todas as consultas salvas serão removidas.'), actions: [
                TextButton(onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancelar')),
                FilledButton(onPressed: () => Navigator.pop(context, true),
                  child: const Text('Limpar')),
              ]));
          if (confirm == true) await controller.clear();
        }),
    ]),
    body: Observer(builder: (_) {
      if (controller.loading.value) return const Center(child: CircularProgressIndicator());
      if (controller.items.isEmpty) return const EmptyAddress(
        message: 'Seu histórico ainda está vazio.');
      return ListView.builder(padding: const EdgeInsets.all(12),
        itemCount: controller.items.length,
        itemBuilder: (_, i) => AddressTile(address: controller.items[i]));
    }),
  );
}
