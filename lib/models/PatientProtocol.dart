// To parse this JSON data, do
//
//     final patientProtocol = patientProtocolFromJson(jsonString);

import 'dart:convert';

PatientProtocol patientProtocolFromJson(String str) => PatientProtocol.fromJson(json.decode(str));

String patientProtocolToJson(PatientProtocol data) => json.encode(data.toJson());

class PatientProtocol {
    String operation;
    Data data;

    PatientProtocol({
        required this.operation,
        required this.data,
    });

    factory PatientProtocol.fromJson(Map<String, dynamic> json) => PatientProtocol(
        operation: json["operation"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "operation": operation,
        "data": data.toJson(),
    };
}

class Data {
    int id;
    String patientId;
    String patientName;
    String patientMail;
    String mostRecentLabWork;
    String labWorkDone;
    String startingLithiumDose;
    String dateStarted;
    String dosing;
    String targetLithiumRange;
    String frequencyBloodDraws;
    String changeMedication;
    String nextLabWorkDate;
    String nextFollowUpApointment;
    String providerComments;

    Data({
        required this.id,
        required this.patientId,
        required this.patientName,
        required this.patientMail,
        required this.mostRecentLabWork,
        required this.labWorkDone,
        required this.startingLithiumDose,
        required this.dateStarted,
        required this.dosing,
        required this.targetLithiumRange,
        required this.frequencyBloodDraws,
        required this.changeMedication,
        required this.nextLabWorkDate,
        required this.nextFollowUpApointment,
        required this.providerComments,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        patientId: json["patientID"],
        patientName: json["patientName"],
        patientMail: json["patientMail"],
        mostRecentLabWork: json["mostRecentLabWork"],
        labWorkDone: json["labWorkDone"],
        startingLithiumDose: json["startingLithiumDose"],
        dateStarted: json["dateStarted"],
        dosing: json["dosing"],
        targetLithiumRange: json["targetLithiumRange"],
        frequencyBloodDraws: json["frequencyBloodDraws"],
        changeMedication: json["changeMedication"],
        nextLabWorkDate: json["nextLabWorkDate"],
        nextFollowUpApointment:json["nextFollowUpApointment"],
        providerComments: json["providerComments"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "patientID": patientId,
        "patientName": patientName,
        "patientMail": patientMail,
        "mostRecentLabWork": mostRecentLabWork,
        "labWorkDone": labWorkDone,
        "startingLithiumDose": startingLithiumDose,
        "dateStarted": dateStarted,
        "dosing": dosing,
        "targetLithiumRange": targetLithiumRange,
        "frequencyBloodDraws": frequencyBloodDraws,
        "changeMedication": changeMedication,
        "nextLabWorkDate": nextLabWorkDate,
        "nextFollowUpApointment": nextFollowUpApointment,
        "providerComments": providerComments,
    };
}
