import 'package:flutter/material.dart';
class EmptyAddress extends StatelessWidget {
  final String message;
  const EmptyAddress({super.key, this.message = 'Nenhum endereço encontrado.'});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 28),
    child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.search_off, size: 48, color: Colors.grey),
      const SizedBox(height: 10), Text(message, textAlign: TextAlign.center),
    ])),
  );
}
