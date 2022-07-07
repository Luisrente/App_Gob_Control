import 'package:flutter/material.dart';
import 'package:flutter_application_2/dd/login_form_provider.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:provider/provider.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  // late String dropdownValue;
  String dropdownValue = 'Central';

  @override
  Widget build(BuildContext context) {
    final sedeService = Provider.of<SedeService>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<String>>(
            future: sedeService.listsede(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                late List<String> nombre;
                nombre = snapshot.data!;
                // String dropdownValue = nombre[0];
                return DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    loginForm.isList = newValue!;
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: nombre
                      // items: <String>['One', 'Two', 'Free', 'Four']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.black12),
                );
              }
            }));
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
//     final sedeService = Provider.of<SedeService>(context);
//     final loginForm = Provider.of<LoginFormProvider>(context);

//     return Container(
//         padding: const EdgeInsets.all(8.0),
//         child: FutureBuilder<List<String>>(
//             future: sedeService.listsede(),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return DropdownButton<String>(
//                   value: dropdownValue,
//                   icon: const Icon(Icons.arrow_downward),
//                   elevation: 16,
//                   style: const TextStyle(color: Colors.deepPurple),
//                   underline: Container(
//                     height: 2,
//                     color: Colors.deepPurpleAccent,
//                   ),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       dropdownValue = newValue!;
//                     });
//                   },
//                   items: <String>['One', 'Two', 'Free', 'Four']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 );
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(color: Colors.black12),
//                 );
//               }
//             }));
//   }
// }


