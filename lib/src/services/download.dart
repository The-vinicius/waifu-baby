import 'package:waifu_baby/src/data/save_image_repository.dart';

class Download {
  final _repository = SaveImageRepository();
  Future<void> save(String url) async {
    await _repository.downloadImage(url);
  }
}
