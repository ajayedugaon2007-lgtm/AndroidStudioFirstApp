import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  UserModel? _user;
  bool _isLoading = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    UserCredential? cred = await _authService.signIn(email, password);
    if (cred != null) {
      _user = await _authService.getUserData(cred.user!.uid);
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> register(String email, String password, UserModel userModel) async {
    _isLoading = true;
    notifyListeners();
    UserCredential? cred = await _authService.signUp(email, password, userModel);
    if (cred != null) {
      _user = userModel;
      _isLoading = false;
      notifyListeners();
      return true;
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
