import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
class InitialPage extends StatefulWidget {
  const InitialPage({super.key});
  @override State<InitialPage> createState() => _InitialPageState();
}
class _InitialPageState extends State<InitialPage> with SingleTickerProviderStateMixin {
  late final AnimationController animation;
  @override void initState() {
    super.initState();
    animation = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100))..forward();
    Future.delayed(const Duration(milliseconds: 1700), () {
      if (mounted) Navigator.pushReplacementNamed(context, AppRoutes.home);
    });
  }
  @override void dispose() { animation.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFF175CD3),
    body: Center(child: FadeTransition(opacity: animation,
      child: ScaleTransition(scale: Tween<double>(begin: .7, end: 1).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOutBack)),
        child: const Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.local_shipping_outlined, color: Colors.white, size: 86),
          SizedBox(height: 18), Text('FastLocation', style: TextStyle(
            color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          Text('FastDelivery • Endereços sem complicação',
            style: TextStyle(color: Colors.white70)),
        ])))),
  );
}
