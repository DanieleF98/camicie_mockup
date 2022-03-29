import 'package:cached_network_image/cached_network_image.dart';
import 'package:camicie_mockup/utils/constants.dart';
import 'package:flutter/material.dart';

class FabricImage extends StatelessWidget {
  const FabricImage({required this.imageUrl, required this.fabricId, Key? key})
      : super(key: key);

  final String fabricId;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: InteractiveViewer(
        maxScale: maxFabricImageScale,
        minScale: minFabricImageScale,
        child: Hero(
          transitionOnUserGestures: true,
          tag: fabricId,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
          ),
        ),
      ),
    );
  }
}
