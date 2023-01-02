import 'dart:convert';

import 'package:equatable/equatable.dart';

class Definition extends Equatable {
  final String? definition;
  final List<dynamic>? synonyms;
  final List<dynamic>? antonyms;

  const Definition({this.definition, this.synonyms, this.antonyms});

  factory Definition.fromMap(Map<String, dynamic> data) => Definition(
        definition: data['definition'] as String?,
        synonyms: data['synonyms'] as List<dynamic>?,
        antonyms: data['antonyms'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'definition': definition,
        'synonyms': synonyms,
        'antonyms': antonyms,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Definition].
  factory Definition.fromJson(String data) {
    return Definition.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Definition] to a JSON string.
  String toJson() => json.encode(toMap());

  Definition copyWith({
    String? definition,
    List<dynamic>? synonyms,
    List<dynamic>? antonyms,
  }) {
    return Definition(
      definition: definition ?? this.definition,
      synonyms: synonyms ?? this.synonyms,
      antonyms: antonyms ?? this.antonyms,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [definition, synonyms, antonyms];
}
