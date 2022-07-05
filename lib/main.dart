import 'package:flutter/material.dart';
import 'package:flutter_application_2/blocs/blocs.dart';
import 'package:flutter_application_2/dd/login_form_provider.dart';
import 'package:flutter_application_2/screens/loading_screen.dart';
import 'package:flutter_application_2/screens/prueba.dart';
import 'package:flutter_application_2/screens/screenCamara.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_application_2/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => GpsBloc()),
      BlocProvider(create: (context) => LocationBloc()),
      BlocProvider(create: (context) => MapBloc()),
    ],
    child: const AppState(),
  ));
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CarnetService()),
        ChangeNotifierProvider(create: (_) => ControlService()),
        ChangeNotifierProvider(create: (_) => UserPrefe()),
        // ChangeNotifierProvider(create: (_) => UserPrefe()),
        // ChangeNotifierProvider(create: (_) => InputsDocumentForms()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),

        ChangeNotifierProvider(create: (_) => JornadaServices()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MapsApp',
      // home: LoadingScreen()
      initialRoute: 'check',
      routes: {
        // 'login': (_) => LoginPage(),
        // 'register': (_) => RegisterScreen(),
        'home': (_) => const HomeScreen(),
        'check': (_) => LoadingScreenLogin(),
        'control': (_) => const ControlScreen(),
        // 'password': (_) => PasswordScreen(),
        'gps': (_) => LoadingScreen(),
        // 'jordana': (_) => JornadaScreen(camera: cameras),
        //  'jord': (_) => TakePictureScreen(camera: firstCamera),
        'login': (_) => LoginPage(),
        'register': (_) => RegisterScreen(),
        'camera': (_) => Home(),
        'qw': (_) => LoginScreenqq(),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
    );
  }
}

// import 'dart:developer';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// Future<void> main() async {
//   runApp(MyApp());
// }



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<CameraDescription>? cameras; //list out the camera available
//   CameraController? controller; //controller for camera
//   XFile? image; //for captured image

//   @override
//   void initState() {
//     loadCamera();
//     super.initState();
//   }

//   loadCamera() async {
//     cameras = await availableCameras();
//     if (cameras != null) {
//       controller = CameraController(cameras![0], ResolutionPreset.max);
//       //cameras[0] = first camera, change to 1 to another camera

//       controller!.initialize().then((_) {
//         if (!mounted) {
//           return;
//         }
//         setState(() {});
//       });
//     } else {
//       print("NO any camera found");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Capture Image from Camera"),
//         backgroundColor: Colors.redAccent,
//       ),
//       body: Container(
//           child: Column(children: [
//         Container(
//             height: 300,
//             width: 400,
//             child: controller == null
//                 ? Center(child: Text("Loading Camera..."))
//                 : !controller!.value.isInitialized
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : CameraPreview(controller!)),
//         ElevatedButton.icon(
//           //image capture button
//           onPressed: () async {
//             try {
//               if (controller != null) {
//                 //check if contrller is not null
//                 if (controller!.value.isInitialized) {
//                   //check if controller is initialized
//                   image = await controller!.takePicture();
//                   log('${image?.path}'); //capture image
//                   setState(() {
//                     //update UI
//                   });
//                 }
//               }
//             } catch (e) {
//               print(e); //show error
//             }
//           },
//           icon: Icon(Icons.camera),
//           label: Text("Capture"),
//         ),
//         Container(
//           //show captured image
//           padding: EdgeInsets.all(30),
//           child: image == null
//               ? Text("No image captured")
//               : Image.file(
//                   File(image!.path),
//                   height: 300,
//                 ),
//           //display captured image
//         )
//       ])),
//     );
//   }
// }
