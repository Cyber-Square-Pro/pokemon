// To parse this JSON data, do
//
//     final dailyCheckinData = dailyCheckinDataFromJson(jsonString);

import 'dart:convert';

DailyCheckinData dailyCheckinDataFromJson(String str) =>
    DailyCheckinData.fromJson(json.decode(str));

String dailyCheckinDataToJson(DailyCheckinData data) =>
    json.encode(data.toJson());

class DailyCheckinData {
  DateTime joinDate;
  List<History> history;

  DailyCheckinData({
    required this.joinDate,
    required this.history,
  });

  factory DailyCheckinData.fromJson(Map<String, dynamic> json) =>
      DailyCheckinData(
        joinDate: DateTime.parse(json["joinDate"]),
        history:
            List<History>.from(json["history"].map((x) => History.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "joinDate": joinDate.toIso8601String(),
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
      };
}

class History {
  String id;
  String user;
  bool isCheckedIn;
  bool isCreatedByCron;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  History({
    required this.id,
    required this.user,
    required this.isCheckedIn,
    required this.isCreatedByCron,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["_id"],
        user: json["user"],
        isCheckedIn: json["isCheckedIn"],
        isCreatedByCron: json["isCreatedByCron"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "isCheckedIn": isCheckedIn,
        "isCreatedByCron": isCreatedByCron,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
