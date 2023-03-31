import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yorijori/model/recipe_model.dart';
import 'dart:convert';

//리스트에 추가가 되어있는지 아닌지 확인
var added = false;

void checkAdded(String RCP_SEQ) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? myRcp_str = pref.getString('myRcp');
  List<dynamic> myRecipe = json.decode(myRcp_str!);
  if(myRecipe.contains(RCP_SEQ)){
    added = true;
  }else{
    added = false;
  }
}


void updateMyrecipe(String RCP_SEQ) async {
  //uid확인
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? myRcp_str = pref.getString('myRcp');

  if(myRcp_str == null){
    //리스트에 처음으로 추가됨.
    List<String> myRecipe = [RCP_SEQ];
    String jsonRecipe = json.encode(myRecipe);
    pref.setString('myRcp', jsonRecipe);
    print('myRcp::::>${pref.getString('myRcp')}');
    checkAdded(RCP_SEQ);
  }else{
    String? jsonRecipe = pref.getString('myRcp');
    List<dynamic> myRecipe = json.decode(jsonRecipe!);
    if(myRecipe.contains(RCP_SEQ)){
      //이미 등록되어 있음.
      checkAdded(RCP_SEQ);
    }else{
      //리스트에 추가하기
      myRecipe.add(RCP_SEQ);
      pref.setString('myRcp', jsonEncode(myRecipe));
      checkAdded(RCP_SEQ);
    }
  }
}

class RecipeDetail extends StatefulWidget {

  final Recipe recipe;

  RecipeDetail({
    required this.recipe
  });

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  //조회수 업데이트 하기



  @override
  Widget build(BuildContext context) {

    //추가가 이미 되어 있는지 확인
    checkAdded(widget.recipe.RCP_SEQ);
    print("seq :::??? ${widget.recipe.RCP_SEQ}");
    print("added :::??? ${added}");

    List<Widget> detailWidgetList = [];

    //모든 내용을 컨테이너에 담아서 페이지화 해야함.
    //1. 요리 개요
    //이미지 경로 ATT_FILE_NO_MK
    //메뉴명 RCP_NM (조리방법 RCP_WAY2, 요리종류 RCP_PAT2)
    //중량 INFO_WGT, 열량 INFO_ENG
    //탄수화물 INFO_CAR, 단백질 INFO_PRO, 지방 INFO_FAT, 나트륨 INFO_NA
    //해시태그 HASH_TAG
    //필요 재료 RCP_PARTS_DTLS
    detailWidgetList.add(
      Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            CachedNetworkImage(
              progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(),
              imageUrl : widget.recipe.ATT_FILE_NO_MAIN,
              //placeholder: (context, url) => const LinearProgressIndicator(color: Colors.redAccent,),
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fadeOutDuration: const Duration(seconds: 1),
              fadeInDuration: const Duration(seconds: 2),
              fit: BoxFit.fill,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent
              ),
              child : Text(widget.recipe.RCP_NM,
                  style:TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87,

                  ),textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('( 조리타입 : ${widget.recipe.RCP_WAY2}  /  ', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                Text('분류 : ${widget.recipe.RCP_PAT2} )', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
              ],
            ),
            SizedBox(height:10),
            Container(
              padding : EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: Colors.amber)
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('열량 : ${widget.recipe.INFO_ENG} Kcal', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('탄수화물 : ${widget.recipe.INFO_CAR}g  ', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                        Text('단백질 : ${widget.recipe.INFO_PRO}g ', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('지방 : ${widget.recipe.INFO_FAT}g ', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                        Text('나트륨 : ${widget.recipe.INFO_NA}g ', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                      ]
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );

    //2. 만드는 방법
    //방법 1~20까지 있음
    //만약 자료가 비어있으면 제작하지 않아야 함.
    //for를 이용할 것
    detailWidgetList.add(
      Container(
        padding : EdgeInsets.fromLTRB(0, 5, 0, 10),
        child : Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin : EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.all(10),
              color: Colors.amber.shade400,
              child: Text('준비물',style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Text('필요재료 : ${widget.recipe.RCP_PARTS_DTLS} ', style:TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                )
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin : EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.all(10),
              color: Colors.amber.shade400,
              child: Text('조리방법',style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),),
            ),
            if(widget.recipe.MANUAL01.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL01, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG01,progressIndicatorBuilder: (context, url, progress) {
                return CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL01.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL02.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL02, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG02,progressIndicatorBuilder: (context, url, progress) {
                return CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL02.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL03.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL03, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG03,progressIndicatorBuilder: (context, url, progress) {
                return CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL03.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL04.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL04, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG04,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL04.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL05.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL05, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG05,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL05.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL06.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL06, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG06,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL06.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL07.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL07, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG07,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL07.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL08.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL08, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG08,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL08.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL09.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL09, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG09,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL09.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL10.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL10, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG10,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL10.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL11.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL11, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG11,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL11.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL12.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL12, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG12,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL12.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL13.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL13, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG13,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL13.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL14.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL14, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG14,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL14.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL15.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL15, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG15,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL15.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL16.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL16, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG16,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL16.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL17.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL17, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG17,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL17.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL18.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL18, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG18,progressIndicatorBuilder: (context, url, progress) {
                return   CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL18.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL19.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL19, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG19,progressIndicatorBuilder: (context, url, progress) {
                return  CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL19.isNotEmpty) SizedBox(height:10),
            if(widget.recipe.MANUAL20.isNotEmpty) ListTile(
              title: Text(widget.recipe.MANUAL20, style : TextStyle(color: Colors.black87,fontSize: 13)),
              leading: CachedNetworkImage(imageUrl:widget.recipe.MANUAL_IMG20,progressIndicatorBuilder: (context, url, progress) {
                return   CircularProgressIndicator();
              },),
            ),
            if(widget.recipe.MANUAL20.isNotEmpty) SizedBox(height:10),
          ],
        )
      )
    );

    //내 리시피에 저장하기 위젯
    detailWidgetList.add(
      Container(
        padding : EdgeInsets.all(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: added == false ? Colors.amber : Colors.grey
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                  added == false ? Icons.add : Icons.check,
                  size: 20, color : Colors.white),
              SizedBox(width: 10,),
              Text(
                added == false ? '내 레시피에 저장하기' : '저장완료!',
                style: TextStyle(fontSize: 14, color: Colors.white),)
            ],
          ),
          onPressed: (){
            setState(() {
              updateMyrecipe(widget.recipe.RCP_SEQ);
            });

          },
        ),
      )
    );

    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: detailWidgetList,
      ),
     /* floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),*/
    );
  }
}
