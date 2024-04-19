import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:waifu_baby/src/repositoreis/images_repository.dart';

class SaveImageRepository implements ImagesRepositoy {
  @override
  Future<void> downloadImage(String url) async {
    final name = url.split('/').last;
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data),
        quality: 100, name: name);
  }
}
