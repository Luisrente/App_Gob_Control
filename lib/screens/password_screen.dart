import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';

import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../helpers/show_alert.dart';

class PasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // const Logo(titulo: 'Cambio de contraseña '),
                  _Form(),
                  // const Labels(
                  //   ruta: 'login',
                  //   titulo: '¿Ya tienes una cuenta?',
                  //   subTitulo: 'Ingresa ahora!',
                  // ),
                  const Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameCtrl = TextEditingController();
  final pass1Ctrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final prefe = Provider.of<UserPrefe>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const Logo(titulo: 'Cambio de contraseña '),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: pass1Ctrl,
            isPassword: true,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          Boton(
              text: 'Ingrese',
              onPressed: () async {
                if ((pass1Ctrl.text) != (passCtrl.text)) {
                  return mostrarAlerta(context, 'Contraseña incorrecto',
                      'Contraseña no coinciden');
                } else {
                  if ((passCtrl.text).length < 8) {
                    return mostrarAlerta(context, 'Contraseña incorrecto',
                        'Contraseña debe tener 8 caracteres');
                  } else {
                    final passwordOk =
                        await authService.password(passCtrl.text.trim());
                    Usuario dato = await prefe.getUserInfo();

                    log('------->${passwordOk}');
                    if (passwordOk) {
                      //  Navigator.pushReplacementNamed(context, 'control');
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => const PhotoScreen(),
                              transitionDuration:
                                  const Duration(milliseconds: 0)));

                      // if (dato.rol == 'ADMIN_ROLE') {
                      //   Navigator.pushReplacementNamed(context, 'control');
                      // } else {
                      //   Navigator.pushReplacementNamed(context, 'home');
                      // }

                    } else {
                      // Mostara alerta
                      return mostrarAlerta(context, 'Error contraseña',
                          'Puedo volver a intentar');
                    }
                  }
                }
              }),
        ],
      ),
    );
  }
}
