import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  String operation;
  List<Datum>? data;
  String? responses;

  NotificationsModel({
    required this.operation,
    this.data,
    this.responses,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        operation: json["operation"] ?? "",
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
        responses: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "operation": operation,
        "data": data?.map((x) => x.toJson()).toList(),
        "responses": responses,
      };
}

class Datum {
  int id;
  String patientName;
  String patientEmail;
  String notificationDate;
  String notificationDetails;
  String? responses;

  Datum({
    required this.id,
    required this.patientName,
    required this.patientEmail,
    required this.notificationDate,
    required this.notificationDetails,
    this.responses,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? 0,
        patientName: json["patientName"] ?? "",
        patientEmail: json["patientEmail"] ?? "",
        notificationDate: json["notificationDate"] ?? "",
        notificationDetails: json["notificationDetails"] ?? "",
        responses: json['response'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientName": patientName,
        "patientEmail": patientEmail,
        "notificationDate": notificationDate,
        "notificationDetails": notificationDetails,
        "responses": responses,
      };
}
