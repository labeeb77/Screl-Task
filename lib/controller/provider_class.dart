import 'package:flutter/material.dart';

class UserController with ChangeNotifier{
  List<bool> _isStarred = List.generate(10, (index) => false); 

  List<bool> get isStarred => _isStarred;

  void toggleStar(int index) {
    _isStarred[index] = !_isStarred[index];
    notifyListeners();
  }

}