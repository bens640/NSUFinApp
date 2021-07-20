import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralNotifier extends ChangeNotifier {
  bool loggedIn= true;

}


class LoggedInNotifier extends StateNotifier<bool>{
  LoggedInNotifier([bool loggedIn = false]) : super(loggedIn = false);

  bool get loggedIn => false;

  flip(){
    state = !loggedIn;
  }
}