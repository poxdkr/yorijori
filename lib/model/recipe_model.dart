import 'dart:convert';
import 'package:get/get.dart';

class Recipe {

  final String 	RCP_SEQ;	//일련번호
  final String 	RCP_NM;	//메뉴명
  final String 	RCP_WAY2;	//조리방법
  final String 	RCP_PAT2;	//요리종류
  final String 	INFO_WGT;	//중량(1인분)
  final String 	INFO_ENG;	//열량
  final String 	INFO_CAR;	//탄수화물
  final String 	INFO_PRO;	//단백질
  final String 	INFO_FAT;	//지방
  final String 	INFO_NA;	//나트륨
  final String 	HASH_TAG;	//해쉬태그
  final String 	ATT_FILE_NO_MAIN;	//이미지경로(소)
  final String 	ATT_FILE_NO_MK;	//이미지경로(대)
  final String 	RCP_PARTS_DTLS;	//재료정보
  final String 	MANUAL01;	//만드는법_01
  final String 	MANUAL_IMG01;	//만드는법_이미지_01
  final String 	MANUAL02;	//만드는법_02
  final String 	MANUAL_IMG02;	//만드는법_이미지_02
  final String 	MANUAL03;	//만드는법_03
  final String 	MANUAL_IMG03;	//만드는법_이미지_03
  final String 	MANUAL04;	//만드는법_04
  final String 	MANUAL_IMG04;	//만드는법_이미지_04
  final String 	MANUAL05;	//만드는법_05
  final String 	MANUAL_IMG05;	//만드는법_이미지_05
  final String 	MANUAL06;	//만드는법_06
  final String 	MANUAL_IMG06;	//만드는법_이미지_06
  final String 	MANUAL07;	//만드는법_07
  final String 	MANUAL_IMG07;	//만드는법_이미지_07
  final String 	MANUAL08;	//만드는법_08
  final String 	MANUAL_IMG08;	//만드는법_이미지_08
  final String 	MANUAL09;	//만드는법_09
  final String 	MANUAL_IMG09;	//만드는법_이미지_09
  final String 	MANUAL10;	//만드는법_10
  final String 	MANUAL_IMG10;	//만드는법_이미지_10
  final String 	MANUAL11;	//만드는법_11
  final String 	MANUAL_IMG11;	//만드는법_이미지_11
  final String 	MANUAL12;	//만드는법_12
  final String 	MANUAL_IMG12;	//만드는법_이미지_12
  final String 	MANUAL13;	//만드는법_13
  final String 	MANUAL_IMG13;	//만드는법_이미지_13
  final String 	MANUAL14;	//만드는법_14
  final String 	MANUAL_IMG14;	//만드는법_이미지_14
  final String 	MANUAL15;	//만드는법_15
  final String 	MANUAL_IMG15;	//만드는법_이미지_15
  final String 	MANUAL16;	//만드는법_16
  final String 	MANUAL_IMG16;	//만드는법_이미지_16
  final String 	MANUAL17;	//만드는법_17
  final String 	MANUAL_IMG17;	//만드는법_이미지_17
  final String 	MANUAL18;	//만드는법_18
  final String 	MANUAL_IMG18;	//만드는법_이미지_18
  final String 	MANUAL19;	//만드는법_19
  final String 	MANUAL_IMG19;	//만드는법_이미지_19
  final String 	MANUAL20;	//만드는법_20
  final String MANUAL_IMG20;//만드는법_이미지_20
  var like =false.obs;

  Recipe({
    required this.RCP_SEQ,
    required this.RCP_NM,
    required this.RCP_WAY2,
    required this.RCP_PAT2,
    required this.INFO_WGT,
    required this.INFO_ENG,
    required this.INFO_CAR,
    required this.INFO_PRO,
    required  this.INFO_FAT,
    required  this.INFO_NA,
    required  this.HASH_TAG,
    required  this.ATT_FILE_NO_MAIN,
    required this.ATT_FILE_NO_MK,
    required  this.RCP_PARTS_DTLS,
    required this.MANUAL01,
    required this.MANUAL_IMG01,
    required this.MANUAL02,
    required this.MANUAL_IMG02,
    required this.MANUAL03,
    required this.MANUAL_IMG03,
    required this.MANUAL04,
    required this.MANUAL_IMG04,
    required this.MANUAL05,
    required this.MANUAL_IMG05,
    required  this.MANUAL06,
    required  this.MANUAL_IMG06,
    required  this.MANUAL07,
    required  this.MANUAL_IMG07,
    required  this.MANUAL08,
    required  this.MANUAL_IMG08,
    required  this.MANUAL09,
    required  this.MANUAL_IMG09,
    required  this.MANUAL10,
    required  this.MANUAL_IMG10,
    required  this.MANUAL11,
    required  this.MANUAL_IMG11,
    required  this.MANUAL12,
    required  this.MANUAL_IMG12,
    required  this.MANUAL13,
    required  this.MANUAL_IMG13,
    required  this.MANUAL14,
    required  this.MANUAL_IMG14,
    required  this.MANUAL15,
    required  this.MANUAL_IMG15,
    required  this.MANUAL16,
    required  this.MANUAL_IMG16,
    required  this.MANUAL17,
    required  this.MANUAL_IMG17,
    required  this.MANUAL18,
    required  this.MANUAL_IMG18,
    required  this.MANUAL19,
    required  this.MANUAL_IMG19,
    required this.MANUAL20,
    required this.MANUAL_IMG20
});

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    RCP_SEQ: json["RCP_SEQ"],
    RCP_NM: json["RCP_NM"],
    RCP_WAY2: json["RCP_WAY2"],
    RCP_PAT2: json["RCP_PAT2"],
    INFO_WGT: json["INFO_WGT"],
    INFO_ENG: json["INFO_ENG"],
    INFO_CAR: json["INFO_CAR"],
    INFO_PRO: json["INFO_PRO"],
    INFO_FAT: json["INFO_FAT"],
    INFO_NA: json["INFO_NA"],
    HASH_TAG: json["HASH_TAG"],
    ATT_FILE_NO_MAIN: json["ATT_FILE_NO_MAIN"],
    ATT_FILE_NO_MK: json["ATT_FILE_NO_MK"],
    RCP_PARTS_DTLS: json["RCP_PARTS_DTLS"],
    MANUAL01: json["MANUAL01"],
    MANUAL_IMG01: json["MANUAL_IMG01"],
    MANUAL02: json["MANUAL02"],
    MANUAL_IMG02: json["MANUAL_IMG02"],
    MANUAL03: json["MANUAL03"],
    MANUAL_IMG03: json["MANUAL_IMG03"],
    MANUAL04: json["MANUAL04"],
    MANUAL_IMG04: json["MANUAL_IMG04"],
    MANUAL05: json["MANUAL05"],
    MANUAL_IMG05: json["MANUAL_IMG05"],
    MANUAL06: json["MANUAL06"],
    MANUAL_IMG06: json["MANUAL_IMG06"],
    MANUAL07: json["MANUAL07"],
    MANUAL_IMG07: json["MANUAL_IMG07"],
    MANUAL08: json["MANUAL08"],
    MANUAL_IMG08: json["MANUAL_IMG08"],
    MANUAL09: json["MANUAL09"],
    MANUAL_IMG09: json["MANUAL_IMG09"],
    MANUAL10: json["MANUAL10"],
    MANUAL_IMG10: json["MANUAL_IMG10"],
    MANUAL11: json["MANUAL11"],
    MANUAL_IMG11: json["MANUAL_IMG11"],
    MANUAL12: json["MANUAL12"],
    MANUAL_IMG12: json["MANUAL_IMG12"],
    MANUAL13: json["MANUAL13"],
    MANUAL_IMG13: json["MANUAL_IMG13"],
    MANUAL14: json["MANUAL14"],
    MANUAL_IMG14: json["MANUAL_IMG14"],
    MANUAL15: json["MANUAL15"],
    MANUAL_IMG15: json["MANUAL_IMG15"],
    MANUAL16: json["MANUAL16"],
    MANUAL_IMG16: json["MANUAL_IMG16"],
    MANUAL17: json["MANUAL17"],
    MANUAL_IMG17: json["MANUAL_IMG17"],
    MANUAL18: json["MANUAL18"],
    MANUAL_IMG18: json["MANUAL_IMG18"],
    MANUAL19: json["MANUAL19"],
    MANUAL_IMG19: json["MANUAL_IMG19"],
    MANUAL20: json["MANUAL20"],
    MANUAL_IMG20: json["MANUAL_IMG20"],
  );



}