import 'package:avaliacao_2/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DeliveryHubApp());
}

class DeliveryHubApp extends StatelessWidget {
  const DeliveryHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
