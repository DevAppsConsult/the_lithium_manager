import 'dart:convert';

Appointments patientAppointmentsFromJson(String str) =>
    Appointments.fromJson(json.decode(str));

String patientAppointmentsToJson(Appointments data) =>
    json.encode(data.toJson());

class Appointments {
  String operation;
  List<Data>? data;
  String? responses;

  Appointments({
    required this.operation,
    this.data,
    this.responses,
  });

  factory Appointments.fromJson(Map<String, dynamic> json) => Appointments(
        operation: json["operation"] ?? "",
        data: json["data"] != null
            ? List<Data>.from(json["data"].map((x) => Data.fromJson(x)))
            : null,
        responses: json['response'],
      );

  Map<String, dynamic> toJson() => {
        "operation": operation,
        "data": data?.map((x) => x.toJson()).toList(),
        "responses": responses,
      };
}

class Data {
  int id;
  String stickerName;
  String email;
  DateTime appointmentDates;
  String patientId;

  Data({
    required this.id,
    required this.stickerName,
    required this.email,
    required this.appointmentDates,
    required this.patientId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        stickerName: json["stickerName"] ?? "",
        email: json["email"] ?? "",
        appointmentDates: DateTime.tryParse(json["appointmentDates"] ?? "") ??
            DateTime.fromMillisecondsSinceEpoch(0), // fallback
        patientId: json["patientId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stickerName": stickerName,
        "email": email,
        "appointmentDates": appointmentDates.toIso8601String(),
        "patientId": patientId,
      };
}
