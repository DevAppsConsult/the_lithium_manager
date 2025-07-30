import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String operation;
  PatientData? patientData;
  String? responses;

  Login({
    required this.operation,
    this.patientData,
    this.responses,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        operation: json["operation"] ?? "",
        patientData: json["patientData"] != null
            ? PatientData.fromJson(json["patientData"])
            : null,
        responses: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "operation": operation,
        "patientData": patientData?.toJson(),
        "responses": responses,
      };
}

class PatientData {
  int id;
  String firstName;
  String lastName;
  dynamic phone;
  String email;
  String dob;
  String gender;
  dynamic ageRange;
  String age;
  dynamic avatar;
  String address;
  String patientId;
  dynamic clinicalIndication;

  PatientData({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.phone,
    required this.email,
    required this.dob,
    required this.gender,
    this.ageRange,
    required this.age,
    this.avatar,
    required this.address,
    required this.patientId,
    this.clinicalIndication,
  });

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
        id: json["id"] ?? 0,
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        phone: json["phone"],
        email: json["email"] ?? "",
        dob: json["dob"] ?? "",
        gender: json["gender"] ?? "",
        ageRange: json["ageRange"],
        age: json["age"] ?? "",
        avatar: json["avatar"],
        address: json["address"] ?? "",
        patientId: json["patientID"] ?? "",
        clinicalIndication: json["clinicalIndication"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "dob": dob,
        "gender": gender,
        "ageRange": ageRange,
        "age": age,
        "avatar": avatar,
        "address": address,
        "patientID": patientId,
        "clinicalIndication": clinicalIndication,
      };
}
