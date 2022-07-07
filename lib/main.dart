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
        ChangeNotifierProvider(create: (_) => SedeService()),
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
      title: 'Gobernacion',
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

// import 'dart:async';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:photo_gallery/photo_gallery.dart';
// import 'package:transparent_image/transparent_image.dart';
// // import 'package:video_player/video_player.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Album>? _albums;
//   bool _loading = false;

//   @override
//   void initState() {
//     super.initState();
//     _loading = true;
//     initAsync();
//   }

//   Future<void> initAsync() async {
//     if (await _promptPermissionSetting()) {
//       List<Album> albums =
//           await PhotoGallery.listAlbums(mediumType: MediumType.image);
//       setState(() {
//         _albums = albums;
//         _loading = false;
//       });
//     }
//     setState(() {
//       _loading = false;
//     });
//   }

//   Future<bool> _promptPermissionSetting() async {
//     if (Platform.isIOS &&
//             await Permission.storage.request().isGranted &&
//             await Permission.photos.request().isGranted ||
//         Platform.isAndroid && await Permission.storage.request().isGranted) {
//       return true;
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Photo gallery example'),
//         ),
//         body: _loading
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : LayoutBuilder(
//                 builder: (context, constraints) {
//                   double gridWidth = (constraints.maxWidth - 20) / 3;
//                   double gridHeight = gridWidth + 33;
//                   double ratio = gridWidth / gridHeight;
//                   return Container(
//                     padding: EdgeInsets.all(5),
//                     child: GridView.count(
//                       childAspectRatio: ratio,
//                       crossAxisCount: 3,
//                       mainAxisSpacing: 5.0,
//                       crossAxisSpacing: 5.0,
//                       children: <Widget>[
//                         ...?_albums?.map(
//                           (album) => GestureDetector(
//                             onTap: () => Navigator.of(context).push(
//                                 MaterialPageRoute(
//                                     builder: (context) => AlbumPage(album))),
//                             child: Column(
//                               children: <Widget>[
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(5.0),
//                                   child: Container(
//                                     color: Colors.grey[300],
//                                     height: gridWidth,
//                                     width: gridWidth,
//                                     child: FadeInImage(
//                                       fit: BoxFit.cover,
//                                       placeholder:
//                                           MemoryImage(kTransparentImage),
//                                       image: AlbumThumbnailProvider(
//                                         albumId: album.id,
//                                         mediumType: album.mediumType,
//                                         highQuality: true,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.topLeft,
//                                   padding: EdgeInsets.only(left: 2.0),
//                                   child: Text(
//                                     album.name ?? "Unnamed Album",
//                                     maxLines: 1,
//                                     textAlign: TextAlign.start,
//                                     style: TextStyle(
//                                       height: 1.2,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   alignment: Alignment.topLeft,
//                                   padding: EdgeInsets.only(left: 2.0),
//                                   child: Text(
//                                     album.count.toString(),
//                                     textAlign: TextAlign.start,
//                                     style: TextStyle(
//                                       height: 1.2,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

// class AlbumPage extends StatefulWidget {
//   final Album album;

//   AlbumPage(Album album) : album = album;

//   @override
//   State<StatefulWidget> createState() => AlbumPageState();
// }

// class AlbumPageState extends State<AlbumPage> {
//   List<Medium>? _media;

//   @override
//   void initState() {
//     super.initState();
//     initAsync();
//   }

//   void initAsync() async {
//     MediaPage mediaPage = await widget.album.listMedia();
//     setState(() {
//       _media = mediaPage.items;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Text(widget.album.name ?? "Unnamed Album"),
//         ),
//         body: GridView.count(
//           crossAxisCount: 3,
//           mainAxisSpacing: 1.0,
//           crossAxisSpacing: 1.0,
//           children: <Widget>[
//             ...?_media?.map(
//               (medium) => GestureDetector(
//                 onTap: () => Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => ViewerPage(medium))),
//                 child: Container(
//                   color: Colors.grey[300],
//                   child: FadeInImage(
//                     fit: BoxFit.cover,
//                     placeholder: MemoryImage(kTransparentImage),
//                     image: ThumbnailProvider(
//                       mediumId: medium.id,
//                       mediumType: medium.mediumType,
//                       highQuality: true,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ViewerPage extends StatelessWidget {
//   final Medium medium;

//   ViewerPage(Medium medium) : medium = medium;

//   @override
//   Widget build(BuildContext context) {
//     DateTime? date = medium.creationDate ?? medium.modifiedDate;
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () => Navigator.of(context).pop(),
//             icon: Icon(Icons.arrow_back_ios),
//           ),
//           title: date != null ? Text(date.toLocal().toString()) : null,
//         ),
//         body: Container(
//             alignment: Alignment.center,
//             child: medium.mediumType == MediumType.image
//                 ? FadeInImage(
//                     fit: BoxFit.cover,
//                     placeholder: MemoryImage(kTransparentImage),
//                     image: PhotoProvider(mediumId: medium.id),
//                   )
//                 : Text('ttt')

//             // VideoProvider(
//             //     mediumId: medium.id,
//             //   ),
//             ),
//       ),
//     );
//   }
// }

// // class VideoProvider extends StatefulWidget {
// //   final String mediumId;

// //   const VideoProvider({
// //     required this.mediumId,
// //   });

// //   @override
// //   _VideoProviderState createState() => _VideoProviderState();
// // }

// // class _VideoProviderState extends State<VideoProvider> {
// //   VideoPlayerController? _controller;
// //   File? _file;

// //   @override
// //   void initState() {
// //     WidgetsBinding.instance?.addPostFrameCallback((_) {
// //       initAsync();
// //     });
// //     super.initState();
// //   }

// //   Future<void> initAsync() async {
// //     try {
// //       _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
// //       _controller = VideoPlayerController.file(_file!);
// //       _controller?.initialize().then((_) {
// //         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
// //         setState(() {});
// //       });
// //     } catch (e) {
// //       print("Failed : $e");
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return _controller == null || !_controller!.value.isInitialized
// //         ? Container()
// //         : Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: <Widget>[
// //               AspectRatio(
// //                 aspectRatio: _controller!.value.aspectRatio,
// //                 child: VideoPlayer(_controller!),
// //               ),
// //               FlatButton(
// //                 onPressed: () {
// //                   setState(() {
// //                     _controller!.value.isPlaying
// //                         ? _controller!.pause()
// //                         : _controller!.play();
// //                   });
// //                 },
// //                 child: Icon(
// //                   _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
// //                 ),
// //               ),
// //             ],
// //           );
// //   }
// // }
