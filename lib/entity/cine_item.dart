import 'package:cine_vault/enum/cine_type.dart';

class CineItem {
  const CineItem({required this.id, required this.title, required this.type});

  final String id;
  final String title;
  final CineType type;
}
