import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drug/config/resource_mananger.dart';

class BannerImage extends StatelessWidget {
  final String image;
  final BoxFit fit;

  BannerImage(this.image, {this.fit: BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => Image.asset(ImageHelper.wrapAssets('banner_erro.png')),
        errorWidget: (context, url, error) => Image.asset(ImageHelper.wrapAssets('banner_erro.png')),
        fit: fit
    );
  }
}
