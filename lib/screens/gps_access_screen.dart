import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: BlocBuilder<GpsBloc, GpsState>(
        builder: (context, state) {
          return !state.isGpsEnabled
              ? const _EnableGpsMessage()
              : const _AccessButton();
        },
      )
          //  _AccessButton(),
          //  child: _EnableGpsMessage()
          ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size.height * 0.17;

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
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(milliseconds: 0)));
              })),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Es necesario el acceso a GPS'),
            MaterialButton(
                child: const Text('Solicitar Acceso',
                    style: TextStyle(color: Colors.white)),
                color: Colors.black,
                shape: const StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                onPressed: () {
                  print("rkktktkktktkt");
                  final gpsBloc = BlocProvider.of<GpsBloc>(context);
                  gpsBloc.askGpsAccess();
                })
          ],
        ),
      ),
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size.height * 0.17;
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
                // _scaffoldKey.currentState?.openDrawer();
                Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomeScreen(),
                        transitionDuration: Duration(milliseconds: 0)));
              })),
      body: Center(
        child: Text(
          'Debe de habilitar el GPS',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
