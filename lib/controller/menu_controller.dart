import 'package:get/get.dart';

class MenuController extends GetxController{
  var isMenuOpen = false.obs;

  void toggleMenu(){
    isMenuOpen.value = !isMenuOpen.value;
  }
  
}