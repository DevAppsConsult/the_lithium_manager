import 'dart:math';
import 'package:flutter/material.dart';
import 'package:the_lithium_management/models/EditPatient.dart';
import 'package:the_lithium_management/models/NotificationsModel.dart';
import 'package:the_lithium_management/models/PatientProtocol.dart';
import '../models/Login.dart';
import '../models/NotificationsModel.dart';
import 'package:http/http.dart' as http;

class RemoteCalls{
  Future<Login?> getLogin(String email,String password) async{
    var api = Uri.parse("http://192.168.3.8:5000/api/Login?Email=${email}&Password=${password}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return loginFromJson(json);
    }
  }

  Future<NotificationsModel?> getNotifications(String Email) async{
    //http://localhost:5000/api/Notifications?Email=nivanpee%40gmail.com
    var api = Uri.parse("http://192.168.3.8:5000/api/Notifications?Email=${Email}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return notificationsModelFromJson(json);
    }
  }

  Future<PatientProtocol?> getProtocols(String pID) async{
    var api = Uri.parse("http://192.168.3.8:5000/api/PatientProtocol?PatientID=${pID}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return patientProtocolFromJson(json);
    }
  }

  Future<EditPatient?> editPatient(dynamic payLoad) async{
    var api = Uri.parse("http://192.168.3.8:5000/api/editPatients?pData=${payLoad.Data}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return editedData(json);
    }
    
  }

}