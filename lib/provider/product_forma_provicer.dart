import 'package:flutter/material.dart';

import '../models/models.dart';

class PhoneProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Usuario product;

  PhoneProvider(this.product);
  updateAvailability(bool value) {
    print(value);
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
