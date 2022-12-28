import 'package:flutter/material.dart';

class PhotoItem extends StatelessWidget {
  final String imgUrl;
  const PhotoItem({
    super.key,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.only(right: 16),
      decoration:  BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imgUrl),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(18.0),
        ),
      ),
    );
  }
}
