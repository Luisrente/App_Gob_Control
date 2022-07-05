import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const SizedBox(height: 100),
            const Image(image: AssetImage('assets/logo.png')),
            const SizedBox(height: 30),
            Text(
              titulo,
              style: const TextStyle(
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
