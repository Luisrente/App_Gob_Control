import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String email = '';
  String password = '';
  String documento = '';
  String name = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isLoadingPhoto = true;
  bool get isLoadingPhoto => _isLoadingPhoto;

  set isLoadingPhoto(bool value) {
    _isLoadingPhoto = value;
    notifyListeners();
  }

  String _isList = 'Central';
  String get isList => _isList;

  set isList(String value) {
    _isList = value;
    notifyListeners();
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());
    return formKey.currentState?.validate() ?? false;
  }
}
