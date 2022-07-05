import 'dart:io';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ProductImage extends StatelessWidget {
  final String? url;

  const ProductImage({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tamano = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Container(
            decoration: _buildBoxDecoration(),
            height: tamano.height * 0.2,
            width: tamano.width * 0.35,
            child: getImage('')),
        // child: getImage(url!)),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 19,
                offset: Offset(0, 5))
          ]);

  Widget getImage(String picture) {
    if (picture == '')
      return const Image(
          image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
    if (picture.startsWith('http')) {
      try {
        return FadeInImage(
          image: NetworkImage(this.url!),
          placeholder: const AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        );

        // return CachedNetworkImage(
        //     // placeholder: CircularProgressIndicator(),
        //     imageUrl: this.url!,
        //     fit: BoxFit.cover);
      } catch (e) {
        return const Image(
            image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
      }
    }

    return Image.file(File(picture), fit: BoxFit.cover);
  }
}
