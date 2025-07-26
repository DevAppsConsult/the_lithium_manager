import 'dart:math';
import 'package:flutter/material.dart';
import 'package:the_lithium_management/models/EditPatient.dart';
import 'package:the_lithium_management/models/NotificationsModel.dart';
import 'package:the_lithium_management/models/PatientProtocol.dart';
import '../models/AppointmentsModel.dart';
import '../models/Login.dart';
import '../models/NotificationsModel.dart';
import 'package:http/http.dart' as http;

class RemoteCalls{
  Future<Login?> getLogin(String email,String password) async{
    var api = Uri.parse("http://44.223.87.21:4356/api/Login?Email=${email}&Password=${password}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return loginFromJson(json);
    }
  }

  Future<NotificationsModel?> getNotifications(String pId) async{
    //http://localhost:5000/api/Notifications?Email=nivanpee%40gmail.com
    var api = Uri.parse("http://44.223.87.21:4356/api/Notifications?pID=${pId}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return notificationsModelFromJson(json);
    }
  }

  Future<PatientProtocol?> getProtocols(String pID) async{
    var api = Uri.parse("http://44.223.87.21:4356/api/PatientProtocol?PatientID=${pID}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return patientProtocolFromJson(json);
    }
  }

  Future<Appointments?> getPatientAppointments(String pID) async{
    var api = Uri.parse("http://44.223.87.21:4356/api/Appointments?pID=${pID}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
      var json = response.body;
      return patientAppointmentsFromJson(json);
    }
  }

  Future<EditPatient?> editPatient(String fieldName,String val,String pId) async{
    var api = Uri.parse("http://44.223.87.21:4356/api/EditProfile?field=${fieldName}&vals=${val}&pId=${pId}");
    var response  = await http.get(api);
    if(response.statusCode == 200){
       var json = response.body;
       return editedData(json);
    }
    
  }

}