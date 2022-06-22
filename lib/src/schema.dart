import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<Schema>> fetchSchema(int trackerID, [int? fieldID]) async {
  List<Schema> schemata;
  Configuration config = Configuration();

  http.Response response = await http.get(
      Uri.https(
          config.baseURLs['homeServer']!,
          '${config.REST_URL_Prefix}/trackers/$trackerID/schema'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);
    schemata = jsonRaw.map((item) => Schema.fromJson(item)).toList();
  } else {
    print("Error fetching schema: ${response.statusCode}");
    return [];
  }
  return schemata;
}

class Schema {
  int? id;
  String? name;
  String? type;
  bool? hidden;
  String? valueModel;
  String? title;
  bool? multipleValues;
  List<Options>? options;
  String? legacyRestName;
  String? trackerItemField;
  String? referenceType;

  Schema(
      {this.id,
      this.name,
      this.type,
      this.hidden,
      this.valueModel,
      this.title,
      this.multipleValues,
      this.options,
      this.legacyRestName,
      this.trackerItemField,
      this.referenceType});

  Schema.fromJson(Map<String, dynamic> json) {
    String _type = json['type'];
    _type = _type.substring(0, (_type.length - 'Field'.length));

    id = json['id'];
    name = json['name'];
    type = _type;
    hidden = json['hidden'];
    valueModel = json['valueModel'];
    title = json['title'] ?? '';
    multipleValues = json['multipleValues'];

    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(Options.fromJson(v));
      });
    }
    legacyRestName = json['legacyRestName'] ?? '';
    trackerItemField = json['trackerItemField'] ?? '';
    referenceType = json['referenceType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['hidden'] = hidden;
    data['valueModel'] = valueModel;
    data['title'] = title;
    data['multipleValues'] = multipleValues;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    data['legacyRestName'] = legacyRestName;
    data['trackerItemField'] = trackerItemField;
    data['referenceType'] = referenceType;
    return data;
  }
}

class Options {
  int? id;
  String? name;
  String? type;

  Options({this.id, this.name, this.type});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
