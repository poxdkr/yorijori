import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorijori/data/recipe_service.dart';
import 'package:yorijori/model/recipe_model.dart';


class RecipeController extends GetxController{

  var searchKeyword = RxString("");
  var recipeList = <Recipe>[].obs;
  var myList = <Recipe>[].obs;

  void fetchData() async {
    var recipes = await RecipeService.fetchProduct();
    if(recipes != null){
      if(searchKeyword==""){
        recipeList.value = recipes;
      }else {
        List<Recipe> rList = [];
        for (Recipe r in recipes) {
          if (r.RCP_NM.toString().toLowerCase().contains(searchKeyword)) {
            rList.add(r);
          }
        }
        recipeList.value = rList;
      }
      print('recipe cont!!!');
    }
  }

  void fetchMyData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? myRcp_str = pref.getString('myRcp');
    print('myRcp_str : $myRcp_str');

    List<dynamic> myRecipe = json.decode(myRcp_str!);

    var recipes = await RecipeService.fetchProduct();
    if(recipes != null){
        List<Recipe> rList = [];
        for (Recipe r in recipes) {
          for (dynamic d in myRecipe){
            if(d == r.RCP_SEQ){
              print('겹치는거 찾음');
              rList.add(r);
            }
          }
        }
        myList.value = rList;
      }
      print('my recipe cont!!!');
  }


  //firebase에 조회수를 update
  void updateLike(){

  }
  //firebase에 like를 update
  void updateVisit(){

  }


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

}