import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  int? status;
  String? message;
  ProfileData? profile;

  ProfileModel({
    this.status,
    this.message,
    this.profile,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    status: json["status"],
    message: json["message"],
    profile:
    json["profile"] == null ? null : ProfileData.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "profile": profile?.toJson(),
  };
}

class ProfileData {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? profilePicture;
  DateTime? dob;
  String? address;
  String? pinCode;

  ProfileData({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.profilePicture,
    this.dob,
    this.address,
    this.pinCode,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    profilePicture: json["profilePicture"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    address: json["address"],
    pinCode: json["pinCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "profilePicture": profilePicture,
    "dob": dob?.toIso8601String(),
    "address": address,
    "pinCode": pinCode,
  };
}