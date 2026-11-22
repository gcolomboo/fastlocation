import 'package:flutter/material.dart';
class SectionCard extends StatelessWidget {
  final Widget child;
  const SectionCard({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(vertical: 7),
    child: Padding(padding: const EdgeInsets.all(16), child: child),
  );
}
