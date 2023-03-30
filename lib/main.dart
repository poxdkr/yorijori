import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yorijori/controller/recipe_controller.dart';
import 'package:yorijori/model/recipe_model.dart';
import 'package:yorijori/view/recipe_veiw.dart';

String _searchText = "";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textEditingController = TextEditingController();
    final RecipeController controller = Get.put(RecipeController());
    List<Recipe> originList = controller.recipeList;

    return GetMaterialApp(
      title: '모두의 레시피',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('모두의 레시피',style:TextStyle(color: Colors.white,fontSize: 15)),
          /*actions: [
            ElevatedButton(
                onPressed: (){},
                child: Icon(Icons.add)
            )
          ],*/
        ),
        body: GetX<RecipeController>(
          builder: (controller) {
            return Scaffold(
                body: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: '만들고 싶은 음식을 검색!',
                        ),
                        onChanged: (text) {
                          _searchText = text;
                          controller.searchKeyword.value = text;
                          print('control??${controller.searchKeyword().toString()}');
                          controller.fetchData();
                          print('onchage');
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 16 , 5  , 16),
                      child:GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 3,
                              ),
                              itemCount: controller.recipeList.length,
                              itemBuilder: (context, index) {
                                return RecipeView(
                                    recipe: controller.recipeList[index],
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
              /*ElevatedButton(
                  onPressed: (){},
                  child: Text('전체보기'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
              ),*/
              ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                child: Text('내가 저장한 레시피'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
