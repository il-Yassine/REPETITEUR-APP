import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:repetiteur_mobile_app_definitive/core/MODEL/PARENTS/models/classes/child_models.dart';

class ChildController extends GetxController{
    List<Child> childrenInfoList = [];

  Future<List<Child>> getChildInfo(String user_id) async{
    try{
    final String apiUrl = "http://apirepetiteur.wadounnou.com/api/enfants?user_id=$user_id";
    Map<String, String> params = {'user_id': user_id};
    final response = await http.get(Uri.parse(apiUrl),
    headers: params);
    if(response.statusCode == 200 || response.statusCode == 201){
      List<dynamic> dataList = json.decode(response.body)['data'];
      childrenInfoList.clear();
      for(var childData in dataList){
         Child child = Child(
          id: childData['id'],
          nom: childData['lname'],
          prenom: childData['fname'], 
          phone: childData['phone']
           );
           childrenInfoList.add(child);
           debugPrint("$childrenInfoList");
      }
      return childrenInfoList;
    }else{
      return[];
    }
    }catch(error){
      throw Exception('Error to load');
    }
  }

}