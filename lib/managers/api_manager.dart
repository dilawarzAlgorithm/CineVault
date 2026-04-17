import 'package:cine_vault/entity/cine_item.dart';
import 'package:cine_vault/strategy/i_remote_data_source.dart';

class ApiManager extends IRemoteDataSource {
  @override
  Future<List<CineItem>> fetchData(String query) async {
    return <CineItem>[];
  }
}
