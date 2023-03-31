import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorijori/controller/recipe_controller.dart';
import 'package:get/get.dart';
import 'package:yorijori/model/recipe_model.dart';
import 'package:yorijori/view/recipe_detail.dart';



class RecipeView extends StatelessWidget {
  //조회수 update필요함.

  var controller = Get.put(RecipeController());

  final Recipe recipe;
  RecipeView({required this.recipe});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        //포커스 해제
        FocusScope.of(context).unfocus();

        //페이지 이동
        Get.to(RecipeDetail(recipe: recipe));
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(2),
                height : 90,
                width : 100,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(),
                  imageUrl : recipe.ATT_FILE_NO_MAIN,
                  //placeholder: (context, url) => const LinearProgressIndicator(color: Colors.redAccent,),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fadeOutDuration: const Duration(seconds: 1),
                  fadeInDuration: const Duration(seconds: 2),
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                  recipe.RCP_NM.length > 12
                  ? '${recipe.RCP_NM.substring(0,12)}...'
                  : recipe.RCP_NM,
                style: TextStyle(color:Colors.black54),
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.space_dashboard, size: 12,color: Colors.green),
                      SizedBox(width:5),
                      Text(recipe.RCP_WAY2, style: TextStyle(color: Colors.black87,fontSize: 12),)
                    ],
                  ),
                  SizedBox(width: 15,),
                  Row(
                    children: [
                      Icon(Icons.emoji_food_beverage, size: 12,color: Colors.black38),
                      SizedBox(width:5),
                      Text(recipe.RCP_PAT2, style: TextStyle(color: Colors.black87,fontSize: 12),)
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
