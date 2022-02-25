import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlideScreenController extends ChangeNotifier {
  bool playerOpen = false;
  bool fullScreen = false;

  openPlayer() {
    playerOpen = true;
    fullScreen = true;
    notifyListeners();
  }

  minimisePlayer() {
    fullScreen = false;
    notifyListeners();
  }

  closePlayer() {
    playerOpen = false;
    notifyListeners();
  }

  Future<bool> onWillPop() async {
    bool willpop = false;
    if (!playerOpen) {
      willpop = true;
    } else if (fullScreen) {
      minimisePlayer();
    } else {
      closePlayer();
    }
    return willpop;
  }
}
