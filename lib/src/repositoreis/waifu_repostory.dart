import 'package:waifu_baby/src/models/waifu.dart';

abstract class WaifuRepository {
  Future<List<Waifu>> fetch();
  Future<List<Waifu>> fetchTags(Map<String, dynamic> tags);
}
