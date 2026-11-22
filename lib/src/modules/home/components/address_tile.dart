import 'package:flutter/material.dart';
import '../model/address_model.dart';
class AddressTile extends StatelessWidget {
  final AddressModel address;
  final VoidCallback? onRoute;
  const AddressTile({super.key, required this.address, this.onRoute});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: const Icon(Icons.location_on_outlined),
      title: Text(address.logradouro.isEmpty ? address.localidade : address.logradouro),
      subtitle: Text('${address.bairro.isEmpty ? '' : '${address.bairro} • '}${address.localidade}/${address.uf}\nCEP: ${address.cep}'),
      isThreeLine: true,
      trailing: onRoute == null ? null : IconButton(
        tooltip: 'Traçar rota', icon: const Icon(Icons.directions), onPressed: onRoute),
    ),
  );
}
