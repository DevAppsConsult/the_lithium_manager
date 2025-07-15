// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) => json.encode(data.toJson());

class NotificationsModel {
    String operation;
    List<Datum> data;

    NotificationsModel({
        required this.operation,
        required this.data,
    });

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        operation: json["operation"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "operation": operation,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String patientName;
    String patientEmail;
    String notificationDate;
    String notificationDetails;

    Datum({
        required this.id,
        required this.patientName,
        required this.patientEmail,
        required this.notificationDate,
        required this.notificationDetails,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        patientName: json["patientName"],
        patientEmail: json["patientEmail"],
        notificationDate: json["notificationDate"],
        notificationDetails: json["notificationDetails"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "patientName": patientName,
        "patientEmail": patientEmail,
        "notificationDate": notificationDate,
        "notificationDetails": notificationDetails,
    };
}
