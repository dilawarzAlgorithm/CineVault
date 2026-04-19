import 'package:cine_vault/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:cine_vault/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: CineVault()));
}

class CineVault extends StatelessWidget {
  const CineVault({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineVault',
      home: MainScreen(),
      theme: CineTheme.darkTheme,
    );
  }
}
