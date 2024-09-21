// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  bool succeeded;
  int statusCode;
  dynamic status;
  String message;
 // dynamic error;
  List<CityModell> data;

  CityModel({
    required this.succeeded,
    required this.statusCode,
    required this.status,
    required this.message,
   // required this.error,
    required this.data,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        succeeded: json["succeeded"],
        statusCode: json["statusCode"],
        status: json["status"],
        message: json["message"],
       // error: json["error"],
        data: List<CityModell>.from(
            json["data"].map((x) => CityModell.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "succeeded": succeeded,
        "statusCode": statusCode,
        "status": status,
        "message": message,
        //"error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CityModell {
  final int id;
  final String cityName;
  final int stateId;

  CityModell({
    required this.id,
    required this.cityName, // Use city1 as cityName
    required this.stateId,
  });

  factory CityModell.fromJson(Map<String, dynamic> json) {
    return CityModell(
      id: json['id'],
      cityName: json['city1'], // Ensure you're using city1 as the correct key
      stateId: json['stateId'],
    );
  }


  Map<String, dynamic> toJson() => {
        "id": id,
        "cityName": cityName,
        "stateId": stateId,
      };
}
