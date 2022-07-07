import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dd/auth_background.dart';
import 'package:flutter_application_2/dd/input_decorations.dart';
import 'package:flutter_application_2/screens/card_container.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/dropdownButton.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
// import 'package:gob_cordoba/services/auth_service.dart';
// import 'package:gob_cordoba/services/carnet_services.dart';
// import 'package:gob_cordoba/services/notications_service.dart';
// import 'package:gob_cordoba/ui/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../dd/login_form_provider.dart';

class LoginScreenqq extends StatelessWidget {
  const LoginScreenqq({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Scaffold(
      body: AuthBackGround(
          child: SingleChildScrollView(
              child: Column(children: [
        const SizedBox(height: 250),
        CardContainer(
            child: Column(children: [
          const SizedBox(height: 10),
          Text('Login', style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 30),
          ChangeNotifierProvider(
              create: (_) => LoginFormProvider(), child: _Login_Form()),
        ])),
        const SizedBox(height: 50),

        MyStatefulWidget(),
        //  TextButton(
        //   onPressed: () => Navigator.pushReplacementNamed(context, 'register'),
        //   style: ButtonStyle(
        //     overlayColor: MaterialStateProperty.all(Color.fromARGB(255, 6, 151, 235)),
        //     shape: MaterialStateProperty.all( const StadiumBorder())
        //   ),
        //   child: const Text('Create new account ', style: TextStyle( fontSize: 18, color: Colors.black87)),
        // ),
        const SizedBox(height: 50),

        TextButton(
            onPressed: () {
              String r = loginForm.isList;
              log('----wwwwww---->$r');
            },
            child: Text('gjgjjgjgjg'))
      ]))),
    );
  }
}

class _Login_Form extends StatelessWidget {
  const _Login_Form({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
        child: Form(
            key: loginForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(children: [
              // TextFormField(
              //   autocorrect: false,
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecorations.authInputDecoration(
              //       hinText: 'jon.do@gmail.com',
              //       labelText: 'Correo electronico',
              //       prefixIcon: Icons.alternate_email_rounded),
              //   onChanged: (value) => loginForm.email = value,
              //   validator: (value) {
              //     String pattern =
              //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              //     RegExp regExp = new RegExp(pattern);
              //     return regExp.hasMatch(value ?? '')
              //         ? null
              //         : 'El valor ingredao no luce como un correo';
              //   },
              // ),
              // const SizedBox(height: 30),
              // TextFormField(
              //   autocorrect: false,
              //   obscureText: true,
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecorations.authInputDecoration(
              //       hinText: '*****',
              //       labelText: 'Contraseña',
              //       prefixIcon: Icons.lock_outline),
              //   onChanged: (value) => loginForm.password = value,
              //   validator: (value) {
              //     return (value != null && value.length >= 6)
              //         ? null
              //         : 'La constraseña debede ser de 6 caracteres';
              //   },
              // ),
              // const SizedBox(height: 30),
              // MaterialButton(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10)),
              //     disabledColor: Colors.grey,
              //     elevation: 0,
              //     color: Color.fromARGB(255, 2, 116, 208),
              //     child: Container(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 80, vertical: 15),
              //         child: Text(
              //           loginForm.isLoading ? 'Espere...' : 'Ingresar',
              //           style: const TextStyle(color: Colors.white),
              //         )),
              //     onPressed: loginForm.isLoading
              //         ? null
              //         : () async {
              //             FocusScope.of(context).unfocus();
              //             final authService =
              //                 Provider.of<AuthService>(context, listen: false);
              //             // final carnetservice= Provider.of<CarnetService>(context,listen:false);

              //             if (!loginForm.isValidForm()) return;
              //             loginForm.isLoading = true;
              //             final errorMessag = await authService.login(
              //                 loginForm.email, loginForm.password);
              //             print('------------------------------');
              //             print(errorMessag);
              //             print('------------------------------');
              //             if (errorMessag == '1') {
              //               Navigator.pushReplacementNamed(context, 'register');
              //             }
              //             if (errorMessag == '4') {
              //               // NotificationsService.showSnackbar("Loading Database ");
              //               // await carnetservice.datosbase();
              //               Navigator.pushReplacementNamed(context, 'register');
              //             }
              //             if (errorMessag == '2') {
              //               // NotificationsService.showSnackbar("Loading Database ");
              //               // await carnetservice.datosbase();
              //               Navigator.pushReplacementNamed(context, 'control');
              //             }
              //             if (errorMessag == '3') {
              //               Navigator.pushReplacementNamed(context, 'home');
              //             }
              //             if (errorMessag == '') {
              //               loginForm.isLoading = false;
              //             }
              //           })
            ])));
  }
}

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   String dropdownValue = 'One';

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: dropdownValue,
//       icon: const Icon(Icons.arrow_downward),
//       elevation: 16,
//       style: const TextStyle(color: Colors.deepPurple),
//       underline: Container(
//         height: 2,
//         color: Colors.deepPurpleAccent,
//       ),
//       onChanged: (String? newValue) {
//         setState(() {
//           dropdownValue = newValue!;
//         });
//       },
//       items: <String>['One', 'Two', 'Free', 'Four']
//           .map<DropdownMenuItem<String>>((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }
