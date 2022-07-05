import 'package:flutter/material.dart';
import 'package:flutter_application_2/dd/login_form_provider.dart';
import 'package:flutter_application_2/helpers/show_alert.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import '../dd/login_form_provider.dart';

import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // const Logo(titulo: 'Control Acceso'),
                  _Form(),
                  const Labels(
                    ruta: 'register',
                    titulo: '¿Eres visitante ? ¿No tienes cuenta?',
                    subTitulo: 'Crea una ahora!',
                  ),
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
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final authService = AuthService();
    final authService = Provider.of<AuthService>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            const Logo(
                titulo:
                    'Bienvenido a la aplicacion de control de la gobernacion de cordoba'),
            CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'Correo',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
            ),
            CustomInput(
              icon: Icons.lock_outline,
              placeholder: 'Contraseña',
              textController: passCtrl,
              isPassword: true,
            ),

            MaterialButton(
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
                        // final carnetservice= Provider.of<CarnetService>(context,listen:false);

                        if (!loginForm.isValidForm()) return;
                        // loginForm.isLoading = true;
                        print(emailCtrl.text.trim());
                        print(passCtrl..text.trim());
                        if (emailCtrl.text == '' || passCtrl.text == '') {
                          return mostrarAlerta(context, 'Login incorrecto',
                              'Por favor complete los campos');
                        } else {}
                        loginForm.isLoading = true;

                        final loginOk = await authService.login(
                            emailCtrl.text.trim(), passCtrl.text.trim());

                        if (loginOk) {
                          // TODO: Conectar a nuestro socket server
                          Navigator.pushReplacementNamed(context, 'check');
                          loginForm.isLoading = false;
                        } else {
                          // Mostara alerta
                          loginForm.isLoading = false;
                          return mostrarAlerta(context, 'Login incorrecto',
                              'Revise sus credenciales nuevamente');
                        }
                        // loginForm.isLoading = false;
                      })

            // Boton(
            //   text: 'Ingrerse',
            //   onPressed: authService.autenticando
            //       ? () => {}
            //       : () async {
            //           FocusScope.of(context).unfocus();
            //           print(emailCtrl.text.trim());
            //           print(passCtrl..text.trim());
            //           if (emailCtrl.text == '' && emailCtrl.text == '') {
            //           } else {}
            //           final loginOk = await authService.login(
            //               emailCtrl.text.trim(), passCtrl.text.trim());
            //           if (loginOk) {
            //             // TODO: Conectar a nuestro socket server
            //             Navigator.pushReplacementNamed(context, 'check');
            //           } else {
            //             // Mostara alerta
            //             return mostrarAlerta(context, 'Login incorrecto',
            //                 'Revise sus credenciales nuevamente');
            //           }
            //         },
            // )

            // Container(
            //   padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
            //   // margin: const EdgeInsets.only(bottom: ),
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(30),
            //       boxShadow: <BoxShadow>[
            //         BoxShadow(
            //             color: Colors.black.withOpacity(0.05),
            //             offset: const Offset(0, 5),
            //             blurRadius: 5)
            //       ]),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
            //     child: TextFormField(
            //       autocorrect: false,
            //       showCursor: false,
            //       style: TextStyle(color: Colors.black),
            //       keyboardType: TextInputType.emailAddress,
            //       decoration: InputDecorations.authInputDecoration(
            //           hinText: 'jon.do@gmail.com',
            //           labelText: 'Correo',
            //           prefixIcon: Icons.mail_outline),
            //       onChanged: (value) {},
            //       // onChanged: (value) => loginForm.email= value,
            //       validator: (value) {
            //         String pattern =
            //             r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            //         RegExp regExp = new RegExp(pattern);
            //         return regExp.hasMatch(value ?? '')
            //             ? null
            //             : 'El valor ingredao no luce como un correo';
            //       },
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // Container(
            //   padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
            //   // margin: const EdgeInsets.only(bottom: ),
            //   decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(30),
            //       boxShadow: <BoxShadow>[
            //         BoxShadow(
            //             color: Colors.black.withOpacity(0.05),
            //             offset: const Offset(0, 5),
            //             blurRadius: 5)
            //       ]),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 15, bottom: 5, right: 15),
            //     child: TextFormField(
            //       autocorrect: false,
            //       obscureText: true,
            //       keyboardType: TextInputType.emailAddress,
            //       decoration: InputDecorations.authInputDecoration(
            //         hinText: '*****',
            //         labelText: 'Contraseña',
            //         prefixIcon: Icons.lock_outline,
            //       ),
            //       // onChanged: (value) => loginForm.password= value,
            //       onChanged: (value) {},
            //       validator: (value) {
            //         return (value != null && value.length >= 6)
            //             ? null
            //             : 'La constraseña debede ser de 6 caracteres';
            //       },
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),

            // Boton(
            //   text: 'Ingrerse',
            //   onPressed: authService.autenticando
            //       ? () => {}
            //       : () async {
            //           FocusScope.of(context).unfocus();
            //           print(emailCtrl.text.trim());
            //           print(passCtrl..text.trim());

            //           final loginOk = await authService.login(
            //               emailCtrl.text.trim(), passCtrl.text.trim());
            //           if (loginOk) {
            //             // TODO: Conectar a nuestro socket server
            //             Navigator.pushReplacementNamed(context, 'check');
            //           } else {
            //             // Mostara alerta
            //             return mostrarAlerta(context, 'Login incorrecto',
            //                 'Revise sus credenciales nuevamente');
            //           }
            //         },
            // )
          ],
        ),
      ),
    );
  }
}
