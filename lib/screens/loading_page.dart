import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';

class LoadingScreenLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    // final authService = Provider.of<AuthService>(context, listen: false);
    // final socketService = Provider.of<SocketService>( context, listen: false );
    // final prefe = UserPrefe();
    final prefe = Provider.of<UserPrefe>(context, listen: false);

    final bool autenticado = await prefe.loggin();

    Usuario dato = Usuario();
    log('-- autenticado-->${autenticado}');
    print('kdkdkkdkd');
    print(autenticado);
    print('mxmxmxmmxm');

    if (autenticado == false) {
      // socketService.connect();
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (_, __, ___) => LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      dato = await prefe.getUserInfo();
      log('--->${dato.estado}');

      if (dato.estado == 'false') {
        log('---fffkgkgk>${dato.estado}');
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (_, __, ___) => PasswordScreen(),
                transitionDuration: const Duration(milliseconds: 0)));
      } else {
        // // if (dato.rol == 'USER_ROLE') {
        // //   log('-uuuuuuuu-->${dato.rol}');
        // //   // socketService.connect();
        // //   Navigator.pushReplacement(
        // //       context,
        // //       PageRouteBuilder(
        // //           pageBuilder: (_, __, ___) => const HomeScreen(),
        // //           transitionDuration: const Duration(milliseconds: 0)));
        // // }

        // if (dato.img == 1) {
        //   // if (dato.rol == 'USER_ROLE' || dato.img == '') {
        //   log('-uuuuuuuu-->${dato.img}');

        //   log('entro');
        //   // socketService.connect();
        //   // Navigator.pushReplacement(
        //   //     context,
        //   //     PageRouteBuilder(
        //   //         pageBuilder: (_, __, ___) => const HomeScreen(),
        //   //         transitionDuration: const Duration(milliseconds: 0)));
        // } else {
        //   Navigator.pushReplacement(
        //       context,
        //       PageRouteBuilder(
        //           pageBuilder: (_, __, ___) => const PhotoScreen(),
        //           transitionDuration: const Duration(milliseconds: 0)));
        // }

        // if (dato.rol == 'ADMIN_ROLE') {
        //   // socketService.connect();
        //   log('--rrrrrrrrrrrr->${dato.rol}');
        //   Navigator.pushReplacement(
        //       context,
        //       PageRouteBuilder(
        //           pageBuilder: (_, __, ___) => const ControlScreen(),
        //           transitionDuration: const Duration(milliseconds: 0)));
        // }

        if (dato.img == 'null' && dato.rol == 'USER_ROLE') {
          log('-uuuuuuuu-->${dato.rol}');
          // socketService.connect();
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const PhotoScreen(),
                  transitionDuration: const Duration(milliseconds: 0)));
        } else {
          if (dato.rol == 'USER_ROLE') {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => const HomeScreen(),
                    transitionDuration: const Duration(milliseconds: 0)));
          }
        }

        if (dato.rol == 'ADMIN_ROLE') {
          // socketService.connect();
          log('--rrrrrrrrrrrr->${dato.rol}');
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const ControlScreen(),
                  transitionDuration: const Duration(milliseconds: 0)));
        }
      }

      // if (dato.rol == 'USER_ROLE') {
      //   log('--->${dato.rol}');
      //   // socketService.connect();
      //   Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //           pageBuilder: (_, __, ___) => const HomeScreen(),
      //           transitionDuration: const Duration(milliseconds: 0)));
      // }
      // if (dato.rol == 'ADMIN_ROLE') {
      //   // socketService.connect();
      //   log('--->${dato.rol}');
      //   Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //           pageBuilder: (_, __, ___) => const ControlScreen(),
      //           transitionDuration: const Duration(milliseconds: 0)));
      // }
    }
  }
}
