import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yorijori/controller/recipe_controller.dart';
import 'package:yorijori/view/recipe_veiw.dart';

class MyRecipe extends StatefulWidget {
  const MyRecipe({Key? key}) : super(key: key);

  @override
  State<MyRecipe> createState() => _MyRecipeState();
}

class _MyRecipeState extends State<MyRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내가 저장한 레시피',style:TextStyle(color: Colors.white,fontSize: 15)),
      ),
      body: GetX<RecipeController>(
          builder: (controller) {
            return Scaffold(
              body: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 16 , 5  , 16),
                        child:GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                          ),
                          itemCount: controller.myList.length,
                          itemBuilder: (context, index) {
                            return RecipeView(
                              recipe: controller.myList[index],
                            );
                          },
                        ),
                      ),
                    ),
                  ]
              ),
            );
          }
      ),

      bottomNavigationBar: BottomAppBar(
        padding: EdgeInsets.all(5),
        color: Colors.amber.withOpacity(0.1),
        elevation: 0,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                  onPressed: (){
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.list, color: Colors.white,size:25,),
                      SizedBox(width: 20,),
                      Text('전체보기',style : TextStyle(color : Colors.white)),
                    ],
                  )
              ),
            /*ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              child: Text('내가 저장한 레시피'),
            ),*/
          ],
        ),
      ),
    );
  }
}
