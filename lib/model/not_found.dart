// To parse this JSON data, do
//
//     final wordNotFound = wordNotFoundFromMap(jsonString);

import 'dart:convert';

class WordNotFound {
  WordNotFound({
    this.title,
    this.message,
    this.resolution,
  });

  final String? title;
  final String? message;
  final String? resolution;

  factory WordNotFound.fromJson(String str) =>
      WordNotFound.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WordNotFound.fromMap(Map<String, dynamic> json) => WordNotFound(
        title: json["title"],
        message: json["message"],
        resolution: json["resolution"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "message": message,
        "resolution": resolution,
      };
}
