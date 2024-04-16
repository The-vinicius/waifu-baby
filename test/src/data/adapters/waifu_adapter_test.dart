import 'package:flutter_test/flutter_test.dart';
import 'package:waifu_baby/src/data/adapters/waifu_adapter.dart';
import 'package:waifu_baby/src/models/waifu.dart';

void main() {
  test('adapter waifu', () {
    final waifu = fromMap(waifus);
    expect(waifu, isA<Waifu>());
  });
}

final waifus = {
  "signature": "36d3d47d1e35d770",
  "extension": ".jpeg",
  "image_id": 6621,
  "favorites": 8,
  "dominant_color": "#bb928a",
  "source": "https://reddit.com/lvl73s/",
  "artist": null,
  "uploaded_at": "2021-11-02T12:16:19.048684+01:00",
  "liked_at": null,
  "is_nsfw": false,
  "width": 2504,
  "height": 4096,
  "byte_size": 710440,
  "url": "https://cdn.waifu.im/6621.jpeg",
  "preview_url": "https://www.waifu.im/preview/6621/",
  "tags": [
    {
      "tag_id": 12,
      "name": "waifu",
      "description": "A female anime/manga character.",
      "is_nsfw": false
    },
    {
      "tag_id": 13,
      "name": "maid",
      "description":
          "Cute womans or girl employed to do domestic work in their working uniform.",
      "is_nsfw": false
    }
  ]
};
