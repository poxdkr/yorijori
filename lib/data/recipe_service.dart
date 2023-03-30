import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yorijori/model/recipe_model.dart';

class RecipeService{

  static Future<List<Recipe>?> fetchProduct() async {

    var response = await rootBundle.loadString('assets/data/data.json');

    if(response != null){
      List<dynamic> jsonList = json.decode(response);
      List<Recipe> rList= [];
      for(dynamic d in jsonList){
        var jsonData = Recipe.fromJson(d);
        //print(jsonData.runtimeType);
        rList.add(jsonData);
      }
      print('recipe service!!!');
      //print(rList);
      return rList;
    }else{
      return null;
    }
  }
}