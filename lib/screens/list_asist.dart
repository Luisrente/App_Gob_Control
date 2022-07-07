import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/dd/login_form_provider.dart';
import 'package:flutter_application_2/models/models.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_application_2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ListAssitScreen extends StatelessWidget {
  const ListAssitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tam = MediaQuery.of(context).size.height * 0.17;
    final carnetservice = CarnetService();
    final jornadaServices = Provider.of<JornadaServices>(context);

    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    final loginForm = Provider.of<LoginFormProvider>(context);

    print('${date}');
    int mon = now.month;
    String monthstring = mon.toString();
    String month = '';
    if (monthstring.length == 1) {
      month = '0${monthstring}';
      print(month);
    }

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
                          transitionDuration: const Duration(milliseconds: 0)));
                })),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              offset: const Offset(0, 5),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: DropdownButtonFormField<String>(
                          value: month,
                          items: const [
                            DropdownMenuItem(value: '01', child: Text('Enero')),
                            DropdownMenuItem(
                                value: '02', child: Text('Febrero')),
                            DropdownMenuItem(value: '03', child: Text('Marzo')),
                            DropdownMenuItem(value: '04', child: Text('Abril')),
                            DropdownMenuItem(value: '05', child: Text('Mayo')),
                            DropdownMenuItem(value: '06', child: Text('Junio')),
                            DropdownMenuItem(value: '07', child: Text('Julio')),
                            DropdownMenuItem(
                                value: '08', child: Text('Agosto')),
                            DropdownMenuItem(
                                value: '09', child: Text('Septiembre')),
                            DropdownMenuItem(
                                value: '10', child: Text('Octubre')),
                            DropdownMenuItem(
                                value: '11', child: Text('Noviembre')),
                            DropdownMenuItem(
                                value: '12', child: Text('Diciembre')),
                          ],
                          onChanged: (value) {
                            print(value);
                            month = value!;
                          }),
                    )),
              ),

              SizedBox(
                height: 50,
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
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      )),
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                ListScreen(month: month),
                            transitionDuration: const Duration(seconds: 0)));
                  }),
              // TextButton.icon(
              //     onPressed: () {
              //       Navigator.pushReplacement(
              //           context,
              //           PageRouteBuilder(
              //               pageBuilder: (_, __, ___) =>
              //                   ListScreen(month: month),
              //               transitionDuration: const Duration(seconds: 0)));
              //     },
              //     icon: Icon(Icons.construction),
              //     label: Text("CONSULTAR"))
            ],
          ),
        ));
  }
}

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   String dropdownValue = 'Central';

//   List<String> datos = ['Central', 'Sur', 'Cerete', 'Norte'];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: DropdownButton<String>(
//         value: dropdownValue,
//         icon: const Icon(Icons.arrow_downward),
//         elevation: 16,
//         style: const TextStyle(color: Colors.deepPurple),
//         underline: Container(
//           height: 2,
//           color: Colors.deepPurpleAccent,
//         ),
//         onChanged: (String? newValue) {
//           log('------>${newValue}');
//           setState(() {
//             dropdownValue = newValue!;
//           });
//         },
//         items: datos
//             // items: <String>['Central', 'Sur', 'Cerete', 'Norte']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
