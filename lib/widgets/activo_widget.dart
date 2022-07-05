import 'package:flutter/material.dart';

class Activo extends StatelessWidget {
  const Activo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            // <-- Icon
            Icons.gps_fixed,
            size: 24.0,
            color: Colors.green,
          ),
          label: const Text(
            'GPS Activo',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    );
  }
}
