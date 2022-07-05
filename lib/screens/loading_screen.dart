import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/blocs.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        return state.isAllGranted
            ? const CameraScreen()
            : const GpsAccessScreen();
      },
    ));
  }
}
