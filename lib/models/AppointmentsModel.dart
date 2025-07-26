import 'dart:convert';
Appointments patientAppointmentsFromJson(String str) => Appointments.fromJson(json.decode(str));

String patientAppointmentsToJson(Appointments data) => json.encode(data.toJson());

class Appointments {
  String operation;
  List<dynamic> data;

  Appointments({
    required this.operation,
    required this.data,
  });

    factory Appointments.fromJson(Map<String, dynamic> json) => Appointments(
    operation: json["operation"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "operation": operation,
    "data": data,
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

  factory Data.fromJson(Map<String,dynamic> json)=>Data(
  id: json["id"],
  stickerName: json["stickerName"],
  email:json["email"] ,
  appointmentDates:json["appointmentDates"],
  patientId:json["patientId"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stickerName": stickerName,
    "email":email,
    "appointmentDates":appointmentDates,
    "patientId":patientId
  };
}
