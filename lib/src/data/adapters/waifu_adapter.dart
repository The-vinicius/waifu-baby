import 'package:waifu_baby/src/models/waifu.dart';

Waifu fromMap(Map<String, dynamic> waifu) {
  
  return Waifu(
    imageId: waifu['image_id'],
    url: Uri.parse(waifu['url']),
    name: waifu['tags'][0]['name'],
    description: waifu['tags'][0]['description'],
  );
}
