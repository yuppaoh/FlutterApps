import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  CircleImage({required this.imageUrl});
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover
              ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(3, 0), // changes position of shadow
              ),
            ],
          ),
        );
      },
      placeholder: (context, url) {
        return Center(child: CircularProgressIndicator(),);
      },
      errorWidget: (context, url, error) {
        return Icon(Icons.error);
      },
    );
  }
}

