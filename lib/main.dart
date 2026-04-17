import 'package:cine_vault/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:cine_vault/theme/theme.dart';

void main() {
  runApp(const CineVault());
}

class CineVault extends StatelessWidget {
  const CineVault({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineVault',
      home: HomeScreen(),
      theme: CineTheme.darkTheme,
    );
  }
}
