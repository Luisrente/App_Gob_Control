import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
// import 'package:gobernacion/services/services.dart';
// import 'package:gobernacion/ui/widgets/widgets.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// import 'package:shared_preferences/shared_preferences.dart';

import '../../models/models.dart';

// import 'package:gob_cordoba/ui/widgets/widgets.dart';
// import 'package:gob_cordoba/ui/screen/screens.dart';
// import 'package:gob_cordoba/provider/provider.dart';
// import 'package:gob_cordoba/models/models.dart';
// import 'package:gob_cordoba/services/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size.height * 0.17;
    // final carnetservice = Provider.of<CarnetService>(context);

    final carnetservice = CarnetService();

    final dato = carnetservice.loadCartUser();
    final prefe = UserPrefe();
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
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
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () async {
                  _scaffoldKey.currentState?.openDrawer();
                })),
        body: FutureBuilder<Usuario>(
            future: carnetservice.loadCartUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return CardWidget(dato: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black12),
                );
              }
            }),
        drawer: DrawerWidget()
        // bottomNavigationBar: const CustomNavigatonBar (),
        );
  }
}
