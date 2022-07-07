import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/provider/provider.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:photo_gallery/photo_gallery.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PhotoScreen extends StatelessWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double tam = MediaQuery.of(context).size.height * 0.17;
    final carnetservice = Provider.of<CarnetService>(context);
    double padding = MediaQuery.of(context).size.width * 0.07;
    double height = MediaQuery.of(context).size.height * 0.60;

    return Scaffold(
      // appBar: AppBar(
      //     actions: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Image.asset('assets/logo.png',
      //             fit: BoxFit.cover, alignment: Alignment.center),
      //       ),
      //       SizedBox(width: tam)
      //     ],
      //     leading: IconButton(
      //         icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
      //         onPressed: () async {
      //           Navigator.pushReplacement(
      //               context,
      //               PageRouteBuilder(
      //                   pageBuilder: (_, __, ___) => LoginPage(),
      //                   transitionDuration: const Duration(milliseconds: 0)));
      //         }),
      //     backgroundColor: Colors.white,
      //     elevation: 1),
      appBar: AppBar(
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10),
          //     child: IconButton(
          //         icon: const Icon(Icons.menu, color: Colors.black),
          //         onPressed: () async {
          //           // Usuario local = Usuario();
          //           // local = await prefe.getUserInfo();
          //           // _scaffoldKey.currentState?.openDrawer();
          //         }),
          //   ),
          // ],
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: SizedBox(
                height: kToolbarHeight - 15,
                child: Image.asset('assets/logo.png'),
              ),
            ),
          ),
          toolbarHeight: kToolbarHeight,
          // leading: Row(
          //   children: [
          //     TextButton.icon(
          //         icon: const Icon(Icons.menu, color: Colors.black),
          //         label: Text('Omitir'),
          //         onPressed: () {}
          //         // onPressed: () async {
          //         //   final picker = new ImagePicker();
          //         //   final PickedFile? pickedFile = await picker.getImage(
          //         //       source: ImageSource.gallery, imageQuality: 100);
          //         //   if (pickedFile == null) {
          //         //     print('No selecciono nada');
          //         //     return;
          //         //   }
          //         //   displayDialog(context, pickedFile.path);
          //         //   //  ShowImg(model: pickedFile.path);
          //         //   print('Tenemos imagen ${pickedFile.path}');
          //         //   //  carnetservice.uploadImage(pickedFile.path);
          //         // },
          //         ),
          //   ],
          // ),
          backgroundColor: Colors.white,
          elevation: 1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 30),
        child: Container(
          height: height,
          margin: EdgeInsets.only(top: 30),
          decoration: cardBordes(),
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          ChangeNotifierProvider(
                              create: (_) =>
                                  PhoneProvider(carnetservice.selectedProduct),
                              child: ProductImage(url: '')),
                          Positioned(
                              right: 50,
                              bottom: 0,
                              child: IconButton(
                                  iconSize: 35,
                                  icon: const Icon(Icons.camera_alt_rounded),
                                  onPressed: () async {
                                    // final ImagePicker _picker = ImagePicker();
                                    // final XFile? image = await _picker
                                    //     .pickImage(source: ImageSource.gallery);
                                    // log('$image');
                                  })),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Boton(
                  text: 'Ingrerse',
                  onPressed: () async {
                    final picker = new ImagePicker();
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);

                    // if (pickedFile == null) {
                    //   print('No selecciono nada');
                    //   return;
                    // }
                    // final Medium medium = await PhotoGallery.getMedium(
                    //     mediumId: "10", mediumType: MediumType.image);
                  },
                ),
              ),
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const HomeScreen(),
                            transitionDuration:
                                const Duration(milliseconds: 0)));
                  },
                  icon: Icon(
                    Icons.flaky,
                    color: Colors.black12,
                  ),
                  label:
                      Text('Omitir', style: TextStyle(color: Colors.black38)))
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration cardBordes() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 3), blurRadius: 10)
          ]);
}
