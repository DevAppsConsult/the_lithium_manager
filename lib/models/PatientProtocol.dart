import 'dart:convert';

PatientProtocol patientProtocolFromJson(String str) =>
    PatientProtocol.fromJson(json.decode(str));

String patientProtocolToJson(PatientProtocol data) =>
    json.encode(data.toJson());

class PatientProtocol {
  String operation;
  Data? data;
  String? responses;

  PatientProtocol({
    required this.operation,
    this.data,
    this.responses,
  });

  factory PatientProtocol.fromJson(Map<String, dynamic> json) => PatientProtocol(
        operation: json["operation"] ?? "",
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        responses: json["response"],
      );

  Map<String, dynamic> toJson() => {
        "operation": operation,
        "data": data?.toJson(),
        "responses": responses,
      };
}

class Data {
  int id;
  dynamic patientId;
  dynamic patientName;
  dynamic patientMail;
  dynamic lithiumDrug;
  dynamic lithiumDose;
  dynamic dosingFreq;
  dynamic lithiumLevel;
  dynamic lithiumLevelDate;
  dynamic gfrLevel;
  dynamic gfrDate;
  dynamic tshLevel;
  dynamic tshDate;
  dynamic tshTargetRange;
  dynamic nextFollowUpApointment;
  dynamic providerName;
  dynamic providerComments;
  dynamic targetLithiumRange;
  dynamic frequencyBloodDraws;
  dynamic frequencyBloodDrawsTsh;
  dynamic frequencyBloodDrawsGfr;
  dynamic patientDiagnosis;
  dynamic allergies;
  dynamic potentialDrugIndication;
  dynamic selectedItems;

  Data({
    required this.id,
    this.patientId,
    this.patientName,
    this.patientMail,
    this.lithiumDrug,
    this.lithiumDose,
    this.dosingFreq,
    this.lithiumLevel,
    this.lithiumLevelDate,
    this.gfrLevel,
    this.gfrDate,
    this.tshLevel,
    this.tshDate,
    this.tshTargetRange,
    this.nextFollowUpApointment,
    this.providerName,
    this.providerComments,
    this.targetLithiumRange,
    this.frequencyBloodDraws,
    this.frequencyBloodDrawsTsh,
    this.frequencyBloodDrawsGfr,
    this.patientDiagnosis,
    this.allergies,
    this.potentialDrugIndication,
    this.selectedItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? 0,
        patientId: json["patientID"],
        patientName: json["patientName"],
        patientMail: json["patientMail"],
        lithiumDrug: json["lithiumDrug"],
        lithiumDose: json["lithiumDose"],
        dosingFreq: json["dosingFreq"],
        lithiumLevel: json["lithiumLevel"],
        lithiumLevelDate: json["lithiumLevelDate"],
        targetLithiumRange: json["targetLithiumRange"],
        frequencyBloodDraws: json["frequencyBloodDraws"],
        gfrLevel: json["gfrLevel"],
        gfrDate: json["gfrDate"],
        tshLevel: json["tshLevel"],
        tshDate: json["tshDate"],
        tshTargetRange: json["tshTargetRange"],
        providerComments: json["providerComments"],
        nextFollowUpApointment: json["nextFollowUpApointment"],
        providerName: json["providerName"],
        frequencyBloodDrawsTsh: json["frequencyBloodDrawsTsh"],
        frequencyBloodDrawsGfr: json["frequencyBloodDrawsGfr"],
        patientDiagnosis: json["patientDiagnosis"],
        allergies: json["allergies"],
        potentialDrugIndication: json["potential_Drug_Indication"],
        selectedItems: json["selectedItems"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientId": patientId,
        "patientName": patientName,
        "patientMail": patientMail,
        "lithiumDrug": lithiumDrug,
        "lithiumDose": lithiumDose,
        "dosingFreq": dosingFreq,
        "lithiumLevel": lithiumLevel,
        "lithiumLevelDate": lithiumLevelDate,
        "targetLithiumRange": targetLithiumRange,
        "frequencyBloodDraws": frequencyBloodDraws,
        "gfrLevel": gfrLevel,
        "gfrDate": gfrDate,
        "tshLevel": tshLevel,
        "tshDate": tshDate,
        "tshTargetRange": tshTargetRange,
        "providerComments": providerComments,
        "nextFollowUpApointment": nextFollowUpApointment,
        "providerName": providerName,
        "frequencyBloodDrawsTsh": frequencyBloodDrawsTsh,
        "frequencyBloodDrawsGfr": frequencyBloodDrawsGfr,
        "patientDiagnosis": patientDiagnosis,
        "allergies": allergies,
        "potentialDrugIndication": potentialDrugIndication,
        "selectedItems": selectedItems,
      };
}
