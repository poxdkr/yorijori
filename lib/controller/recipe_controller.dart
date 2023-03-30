import 'package:get/get.dart';
import 'package:yorijori/data/recipe_service.dart';
import 'package:yorijori/model/recipe_model.dart';

class RecipeController extends GetxController{

  var searchKeyword = RxString("");
  var recipeList = <Recipe>[].obs;

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


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

}