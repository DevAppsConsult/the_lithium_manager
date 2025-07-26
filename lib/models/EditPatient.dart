import 'dart:convert';

EditPatient editedData(String str) => EditPatient.fromJson(json.decode(str));
String operationVal(EditPatient data) => json.encode(data.toJson());

class EditPatient {
    dynamic data;
    String? operationState;

    EditPatient({
        required this.data,
        required this.operationState,
    });

    factory EditPatient.fromJson(Map<String, dynamic> json) => EditPatient(
        operationState: json["operation"], 
        data: json["data"], 
       
    );

    Map<String, dynamic> toJson() => {
        "operation": operationState,
        "data": data.toJson(),
    };

}

class Data {
    dynamic data;
    
    Data({
        required this.data
    });

factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: json["data"]
    );

     Map<String, dynamic> toJson() => {
        "data": data,
        
    };

}