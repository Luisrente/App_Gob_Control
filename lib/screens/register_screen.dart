import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/helpers/show_alert.dart';
import 'package:flutter_application_2/models/user.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';

import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../dd/login_form_provider.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              // height: MediaQuery.of(context).size.height,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // const Logo(titulo: 'Registro de visitantes '),
                  _Form(),
                  SizedBox(height: 40),
                  const Labels(
                    ruta: 'login',
                    titulo: '¿Ya tienes una cuenta?',
                    subTitulo: 'Ingresa ahora!',
                  ),
                  SizedBox(height: 40),

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
  final name1Ctrl = TextEditingController();
  final name2Ctrl = TextEditingController();
  final apell1Ctrl = TextEditingController();
  final apell2Ctrl = TextEditingController();
  final dumentoCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          const Logo(titulo: 'Ingresa datos personales'),
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Primer Nombre',
            keyboardType: TextInputType.text,
            textController: name1Ctrl,
          ),
          // const SizedBox(height: 5),

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Segundo Nombre',
            keyboardType: TextInputType.text,
            textController: name2Ctrl,
          ),
          const SizedBox(height: 5),

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: ' Primer Apellido',
            keyboardType: TextInputType.text,
            textController: apell1Ctrl,
          ),
          const SizedBox(height: 5),

          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Segundo Apellido',
            keyboardType: TextInputType.text,
            textController: apell2Ctrl,
          ),
          const SizedBox(height: 5),
          CustomInput(
            icon: Icons.numbers_outlined,
            placeholder: 'Documento ',
            keyboardType: TextInputType.text,
            textController: dumentoCtrl,
          ),
          const SizedBox(height: 5),

          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.text,
            textController: emailCtrl,
          ),
          const SizedBox(height: 5),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.text,
            textController: passCtrl,
            isPassword: true,
          ),
          const SizedBox(height: 5),

          Form(
            // key: loginForm.formKey,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Color.fromARGB(255, 2, 116, 208),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        loginForm.isLoading ? 'Espere...' : 'Ingresar',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        final authService =
                            Provider.of<AuthService>(context, listen: false);
                        if (name1Ctrl.text.isNotEmpty &&
                            apell1Ctrl.text.isNotEmpty &&
                            apell2Ctrl.text.isNotEmpty &&
                            dumentoCtrl.text.isNotEmpty &&
                            emailCtrl.text.isNotEmpty &&
                            passCtrl.text.isNotEmpty) {
                          if (passCtrl.text.length < 8) {
                            return mostrarAlerta(context, 'Contraseña',
                                'La contraseña debe tener mas de 8 caracteres');
                          } else {
                            loginForm.isLoading = true;

                            final dato = {
                              "nombre1": name1Ctrl.text,
                              "nombre2": name2Ctrl.text,
                              "apellido2": apell1Ctrl.text,
                              "apellido1": apell2Ctrl.text,
                              "cargo": 'Visitante',
                              "documento": dumentoCtrl.text,
                              "dependencia": 'Visitante',
                              "correo": emailCtrl.text,
                              "password": passCtrl.text,
                              "sede": 'Visitante',
                              "img": '',
                              "rol": 'USER_ROLE',
                              "estado": 'false',
                              "verfi": 'false'
                            };
                            final registerOk = await authService.register(dato);
                            log('$registerOk');
                            if (registerOk) {
                              // TODO: Conectar a nuestro socket server
                              loginForm.isLoading = false;

                              Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (_, __, ___) =>
                                          PhotoScreen(),
                                      transitionDuration:
                                          Duration(milliseconds: 0)));
                              // log('$registerOk');
                            } else {
                              loginForm.isLoading = false;
                              // Mostara alerta
                              return mostrarAlerta(context, 'Login incorrecto',
                                  'Revise sus credenciales nuevamente');
                            }
                          }
                        } else {
                          return mostrarAlerta(
                              context, '!Por favor !', 'Verificar los campos');
                        }
                      }),
          ),
          // Boton(
          //   text: 'Continuar ',
          //   onPressed: () async {
          //     FocusScope.of(context).unfocus();
          //     if (name1Ctrl.text.isNotEmpty &&
          //         apell1Ctrl.text.isNotEmpty &&
          //         apell2Ctrl.text.isNotEmpty &&
          //         dumentoCtrl.text.isNotEmpty &&
          //         emailCtrl.text.isNotEmpty &&
          //         passCtrl.text.isNotEmpty) {
          //       if (passCtrl.text.length < 8) {
          //         return mostrarAlerta(context, 'Contraseña',
          //             'La contraseña debe tener mas de 8 caracteres');
          //       } else {
          //         final dato = {
          //           "nombre1": name1Ctrl.text,
          //           "nombre2": name2Ctrl.text,
          //           "apellido2": apell1Ctrl.text,
          //           "apellido1": apell2Ctrl.text,
          //           "cargo": 'Visitante',
          //           "documento": dumentoCtrl.text,
          //           "dependencia": 'Visitante',
          //           "correo": emailCtrl.text,
          //           "password": passCtrl.text,
          //           "sede": 'Visitante',
          //           "img": '',
          //           "rol": 'USER_ROLE',
          //           "estado": 'false',
          //           "verfi": 'false'
          //         };
          //         final registerOk = await authService.register(dato);
          //         log('$registerOk');
          //         if (registerOk) {
          //           // TODO: Conectar a nuestro socket server
          //           Navigator.pushReplacement(
          //               context,
          //               PageRouteBuilder(
          //                   pageBuilder: (_, __, ___) => PhotoScreen(),
          //                   transitionDuration: Duration(milliseconds: 0)));
          //           // log('$registerOk');
          //         } else {
          //           // Mostara alerta
          //           return mostrarAlerta(context, 'Login incorrecto',
          //               'Revise sus credenciales nuevamente');
          //         }
          //       }
          //     } else {
          //       return mostrarAlerta(
          //           context, '!Por favor !', 'Verificar los campos');
          //     }
          //   },
          // )
        ],
      ),
    );
  }
}
