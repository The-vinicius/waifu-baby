import 'package:waifu_baby/src/data/waifu_datasource.dart';
import 'package:waifu_baby/src/models/waifu.dart';
import 'package:waifu_baby/src/repositoreis/waifu_repostory.dart';

class WaifuImRepostory implements WaifuRepository {
  final WaifuDatasource datasource;

  WaifuImRepostory(this.datasource);

  @override
  Future<List<Waifu>> fetch() async {
    final waifus = await datasource.getWaifus();
    return waifus;
  }

  @override
  Future<List<Waifu>> fetchTags(Map<String, dynamic> tags) async {
    final waifus = await datasource.getWaifusTags(tags);
    return waifus;
  }
}
