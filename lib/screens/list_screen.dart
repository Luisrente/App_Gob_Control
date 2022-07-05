import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  final String month;
  const ListScreen({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size.height * 0.17;
    final jornadaServices = Provider.of<JornadaServices>(context);

    return Scaffold(
      appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo.png',
                  fit: BoxFit.cover, alignment: Alignment.center),
            ),
            SizedBox(width: tam)
          ],
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () async {
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => ListAssitScreen(),
                        transitionDuration: const Duration(milliseconds: 0)));
              })),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),

        //     Container(
        //       child: ListView.builder(
        //   itemCount: jornadaServices.asistenciaMes(month).length,
        //   itemBuilder: ( BuildContext context, int index ) => GestureDetector(
        //     onTap: () {
        //       // productsService.selectedProduct = productsService.products[index].copy();
        //       // Navigator.pushNamed(context, 'product');
        //     },
        //     child: ProductCard(
        //       product: productsService.products[index],
        //     ),
        //   )
        // )
        child: FutureBuilder<List<Asistencia>>(
            future: jornadaServices.asistenciaMes(month),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Asistencia> listasistencia = snapshot.data!;
                return Container(
                    child: ListView.builder(
                        // itemCount: snapshot.data.length,
                        itemCount: listasistencia.length,
                        itemBuilder: (BuildContext context, int index) =>
                            GestureDetector(
                                onTap: () {
                                  // productsService.selectedProduct = productsService.products[index].copy();
                                  // Navigator.pushNamed(context, 'product');
                                },
                                child: ListTile(
                                  title: Text(listasistencia[index].nombre!),
                                  subtitle: Text(
                                      '${listasistencia[index].horaInsert}'),
                                  leading: CircleAvatar(
                                    child: getImage(listasistencia[index].img!),
                                    backgroundColor: Colors.white,
                                  ),
                                  trailing: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                  onTap: () {
                                    // final chatService = Provider.of<ChatService>(context, listen: false);
                                    // chatService.usuarioPara = usuario;
                                    // Navigator.pushNamed(context, 'chat');
                                  },
                                ))));
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black12),
                );
              }
            }),
      ),
    );
  }
}

// class _photoWidget extends StatelessWidget {
//   final String img;
//   const _photoWidget({
//     Key? key,  required this.img,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Text(''));
//   }
// }

Widget getImage(String picture) {
  if (picture == '')
    return const Image(
        image: AssetImage('assets/persona.jpeg'), fit: BoxFit.cover);
  if (picture.startsWith('http')) {
    try {
      return FadeInImage(
        image: NetworkImage(picture),
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
