import 'package:dio/dio.dart';
import 'package:waifu_baby/src/data/adapters/waifu_adapter.dart';
import 'package:waifu_baby/src/models/waifu.dart';

class WaifuDatasource {
  Future<List<Waifu>> getWaifus() async {
    final response = await Dio().get("https://api.waifu.im/search");
    final json = response.data as Map<String, dynamic>;
    final waifus =
        (json['images'] as List<dynamic>).map((e) => fromMap(e)).toList();
    return waifus;
  }

  Future<List<Waifu>> getWaifusTags(Map<String, dynamic> tags) async {
    final response =
        await Dio().get("https://api.waifu.im/search", queryParameters: tags);
    final json = response.data as Map<String, dynamic>;
    final waifus =
        (json['images'] as List<dynamic>).map((e) => fromMap(e)).toList();
    return waifus;
  }
}
