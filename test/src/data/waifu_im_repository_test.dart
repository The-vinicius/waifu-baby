import 'package:flutter_test/flutter_test.dart';
import 'package:waifu_baby/src/data/waifu_im_repostory.dart';
import 'package:waifu_baby/src/data/wiafu_datasource.dart';
import 'package:waifu_baby/src/models/waifu.dart';

void main() {
  final datasource = WaifuDatasource();
  test('return list waifu', () async {
    final repository = WaifuImRepostory(datasource);
    final waifus = await repository.fetch();
    expect(waifus, isA<List<Waifu>>());
  });
}
