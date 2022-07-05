import 'package:flutter/material.dart';

import '../blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertMap extends StatelessWidget {
  const AlertMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
            print('state: ${state}');
            return !state.isGpsEnabled ? _EnableGpsMessage() : _AccessButton();
          }),
        ),
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Debe de habilitar el GPS',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
          ),
          TextButton.icon(
            onPressed: () {
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              gpsBloc.askGpsAccess();
            },
            icon: const Icon(
              // <-- Icon
              Icons.gps_fixed,
              size: 24.0,
              color: Colors.blue,
            ),
            label: const Text(
              'Permiso  Gps',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Es necesario el habilitar a GPS'),
        TextButton.icon(
          onPressed: () {
            final gpsBloc = BlocProvider.of<GpsBloc>(context);
            gpsBloc.askGpsAccess();
          },
          icon: const Icon(
            // <-- Icon
            Icons.gps_fixed,
            size: 24.0,
            color: Colors.red,
          ),
          label: const Text(
            'Habilitar  GPS',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }
}
