import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralNotifier extends ChangeNotifier {
  bool loggedIn= true;

}


class LoggedInNotifier extends ChangeNotifier{
  Color loggedInColor = Colors.red ;
  bool loggedIn = false;


  flip(){
    loggedIn = !loggedIn;
    notifyListeners();
  }
}


