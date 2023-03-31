import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yorijori/controller/recipe_controller.dart';
import 'package:yorijori/model/recipe_model.dart';
import 'package:yorijori/view/my_recipe.dart';
import 'package:yorijori/view/recipe_veiw.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String _searchText = "";

//유저의 방문 기록 확인
void checkUser() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? uid = pref.getString("uid");
  if(uid == null){
    print('first Come in');
    Uuid uuid = Uuid();
    pref.setString("uid",uuid.v4());
  }else{
    print('already Come in');
    print('uuid : $uid');
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  //Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //유저확인
    checkUser();
    //willpopscope용 시간
    DateTime? currentBackPressTime;

    final TextEditingController _textEditingController = TextEditingController();
    final RecipeController controller = Get.put(RecipeController());
    List<Recipe> originList = controller.recipeList;

    return GetMaterialApp(
      title: '모두의 레시피',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        fontFamily: 'NotoSansKR',
      ),
      home: AnimatedSplashScreen(
        splash: Container(
            color: Colors.black,
            child: Image.asset(
                'assets/images/ep_icon.png',
              fit: BoxFit.fill,
            )
        ),
        splashIconSize: 200,
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
        nextScreen : Scaffold(
          appBar: AppBar(
            title: Text('모두의 레시피',style:TextStyle(color: Colors.white,fontSize: 15)),
          ),
          body: GetX<RecipeController>(
            builder: (controller) {
              return Scaffold(
                  body: WillPopScope(
                  onWillPop: () async {
                final backButtonPressTime = DateTime.now();

                if (currentBackPressTime == null ||
                    backButtonPressTime.difference(currentBackPressTime!) >
                        Duration(seconds: 2)) {
                  currentBackPressTime = backButtonPressTime;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.redAccent.withOpacity(0.5),
                      content: Text('한 번 더 누르면 앱이 종료됩니다.',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                  return false;
                }
                return true;
              },
              child:
                  Column(
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
                  onPressed: (){
                    controller.fetchMyData();
                    Get.to(()=>MyRecipe());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  child:Row(
                    children: [
                      Icon(Icons.list, color: Colors.white,size:25,),
                      SizedBox(width: 20,),
                      Text('나의 레시피',style : TextStyle(color : Colors.white)),
                    ],
                  )

                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
