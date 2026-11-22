import 'package:flutter/material.dart';
import '../model/address_model.dart';
import '../../../shared/components/section_card.dart';
class LastAddressCard extends StatelessWidget {
  final AddressModel address;
  final VoidCallback onRoute;
  const LastAddressCard({super.key, required this.address, required this.onRoute});
  @override
  Widget build(BuildContext context) => SectionCard(child: Column(
    crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Último endereço consultado', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8), Text(address.fullAddress),
      const SizedBox(height: 8), FilledButton.icon(onPressed: onRoute,
        icon: const Icon(Icons.route), label: const Text('Traçar rota')),
    ]));
}
