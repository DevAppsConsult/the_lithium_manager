import 'dart:convert';

EditPatient editedData(String str) => EditPatient.fromJson(json.decode(str));
String operationVal(EditPatient data) => json.encode(data.toJson());

class EditPatient {
    int patientId;
    PatientData patientData;
    String? operationState;

    EditPatient({
        required this.patientId,
        required this.patientData,
         this.operationState,
    });

    factory EditPatient.fromJson(Map<String, dynamic> json) => EditPatient(
        operationState: json["operationState"], 
        patientId: json["pID"], 
        patientData: PatientData.fromJson(json["patientData"])
    );

    Map<String, dynamic> toJson() => {
        "operation": operationState,
        "patientData": patientData.toJson(),
    };

}

class PatientData {
    String patientName;
    String patientEmail;
    String patientPhone;
    String patientAddress;
    String patientPassword;
    int? pID;
    PatientData({
        required this.patientName,
        required this.patientEmail,
        required this.patientPhone,
        required this.patientAddress,
        required this.patientPassword,
        this.pID
    });

factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
        pID: json["pID"],
        patientName: json["patientName"],
        patientEmail: json["patientEmail"],
        patientPhone: json["patientPhone"],
        patientAddress: json["patientAddress"],
        patientPassword: json["patientPassword"]
    );

     Map<String, dynamic> toJson() => {
        "patientName": patientName,
        "patientEmail": patientEmail,
        "patientPhone": patientPhone,
        "patientAddress": patientAddress,
        "patientPassword": patientPassword
    };

}