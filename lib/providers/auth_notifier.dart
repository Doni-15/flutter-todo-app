import 'package:belajar_firebase_auth/services/auth/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthNotifier with ChangeNotifier {
  final AuthServices _authServices = AuthServices();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  // Untuk sign up
  Future<bool> signUp(
    String email,
    String password,
  ) async{
    _setLoading(true);

    try {
      User? user = await _authServices.signUp(email, password);
      return user != null;
    }
    finally {
      _setLoading(false);
    }
  }

  // Untuk sign up
  Future<bool> signIn(
    String email,
    String password,
  ) async{
    _setLoading(true);

    try {
      User? user = await _authServices.signIn(email, password);
      return user != null;
    }
    finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async{
    await _authServices.signOut();
  }
}












