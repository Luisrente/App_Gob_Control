import 'package:flutter/material.dart';
import 'package:flutter_application_2/data/encryption.dart';
// import 'package:gobernacion/data/encryption.dart';
// import 'package:gobernacion/models/models.dart';
// import 'package:gobernacion/provider/provider.dart';

import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/models.dart';
import '../provider/provider.dart';

// import 'package:gob_cordoba/data/encryption_service.dart';
// import 'package:gob_cordoba/provider/product_forma_provicer.dart';
// import 'package:gob_cordoba/services/services.dart';
// import 'package:gob_cordoba/ui/widgets/widgets.dart';
// import 'package:provider/provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';

class CardWidget extends StatelessWidget {
  final Usuario dato;
  const CardWidget({Key? key, required this.dato}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final carnetservice = Provider.of<CarnetService>(context);
    final carnetservice = CarnetService();

    final EncryptionService encryptionService = new EncryptionService();
    // String documentId = dato.document!;
    // print(documentId);
    double height = MediaQuery.of(context).size.height * 0.75;
    double padding = MediaQuery.of(context).size.width * 0.07;
    print(dato.img);
    return Padding(
      // padding:  EdgeInsets.all(0.1),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 30),
      child: Container(
        margin: EdgeInsets.only(top: 30),
        height: height,
        width: double.infinity,
        decoration: cardBordes(),
        child: Stack(children: [
          Positioned(left: 0, child: Cargo(dato: dato)),
          Positioned(
              top: 5,
              right: 1,
              bottom: 1,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  width: MediaQuery.of(context).size.width * 0.69,
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 25, left: 25, top: 30, bottom: 20),
                        child: Image.asset('assets/logo.png',
                            alignment: Alignment.center),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: Container(
                              width: 180,
                              child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ChangeNotifierProvider(
                                        create: (_) => PhoneProvider(
                                            carnetservice.selectedProduct),
                                        child: ProductImage(url: dato.img)),
                                    // ProductImage(url:''),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 10),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              '${dato.nombre1} ${dato.apellido1} ',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            child: Text('${dato.cargo}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blueAccent),
                                                softWrap: true,
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                    _CodigoQR(documento: dato.documento),
                                    Text(
                                      'CC:${dato.documento}',
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ])),
                        ),
                      ),
                      const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: const Text('www.cordoba.gov.co',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(115, 9, 46, 83)))),
                      )
                    ],
                  ))),
          Positioned(
            right: 0,
            bottom: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                color: Colors.blue,
                height: 5,
                width: MediaQuery.of(context).size.width * 0.65,
              ),
            ),
          ),
        ]),
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

class _Encabezado extends StatelessWidget {
  // final Usuario usuario;

  const _Encabezado({
    Key? key,
    // required this.usuario,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30, bottom: 30),
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'usuario.name!',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                'CC: ' + 'usuario.document!',
                style: TextStyle(fontSize: 18, color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ));
  }
}

class _CodigoQR extends StatelessWidget {
  final documento;

  const _CodigoQR({
    Key? key,
    this.documento,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tamano = MediaQuery.of(context).size;
    final EncryptionService encryptionService = new EncryptionService();
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Container(
          height: tamano.height * 0.2,
          width: tamano.width * 0.5,
          child: QrImage(data: '')),
      // child: QrImage(data: encryptionService.encryptData(documento))),
    );
  }
}

class _Foto extends StatelessWidget {
  final foto;

  const _Foto({
    Key? key,
    required this.foto,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final tamano = MediaQuery.of(context).size;
    String url =
        'https://thumbs.dreamstime.com/z/retrato-de-hombre-mirando-la-c%C3%A1mara-sobre-el-fondo-blanco-158750254.jpg';
    final url1 = null;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Container(
            height: tamano.height * 0.2,
            width: tamano.width * 0.5,
            child: ProductImage(url: foto)),
        //   child: url == null
        // ? Image(image: const AssetImage('assets/persona.jpeg'),
        //   fit: BoxFit.cover
        // )
        // : FadeInImage(
        //   placeholder: const AssetImage('assets/loading.gif'),
        //   image: NetworkImage(url),
        //   fit: BoxFit.cover
        // )
        // ),
      ),
    );
  }
}

class Cargo extends StatelessWidget {
  final Usuario dato;

  const Cargo({
    Key? key,
    required this.dato,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.16,
        decoration: _buildBoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 25),
          child: Align(
            alignment: Alignment.topCenter,
            child: RotatedBox(
              quarterTurns: 3,
              child: Text(
                '${dato.dependencia}',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), topLeft: Radius.circular(25)));
}
