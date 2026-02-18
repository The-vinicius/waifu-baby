import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  final String url;
  const CardImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
      ),
    );
  }
}
