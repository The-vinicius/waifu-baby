import 'package:flutter_test/flutter_test.dart';
import 'package:waifu_baby/src/data/waifu_datasource.dart';
import 'package:waifu_baby/src/data/waifu_im_repostory.dart';

void main() {
  final datasource = WaifuDatasource();
  test('return list waifu', () async {
    final repository = WaifuImRepostory(datasource);
    final waifus = await repository.fetch();
    expect(waifus.isNotEmpty, equals(true));
  });

  test('return list waifu with tags', () async {
    final repository = WaifuImRepostory(datasource);

    final waifus = await repository.fetchTags({'is_nsfw': true});

    expect(waifus.isNotEmpty, equals(true));
  });

  test('count waifus', () async {
    final repository = WaifuImRepostory(datasource);

    final waifus = await repository.fetchTags({'is_nsfw': true, 'limit': 10});

    expect(waifus.length, 10);
  });
}
