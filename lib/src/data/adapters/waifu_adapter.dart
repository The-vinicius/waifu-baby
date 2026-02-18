import 'package:waifu_baby/src/models/waifu.dart';

Waifu fromMap(Map<String, dynamic> waifu) {
  return Waifu(
    imageId: waifu['id'],
    url: Uri.parse(waifu['url']),
    name: (waifu['tags'] as List).length > 1
        ? waifu['tags'][1]['name']
        : waifu['tags'][0]['name'],
    description: waifu['tags'][0]['description'],
  );
}
