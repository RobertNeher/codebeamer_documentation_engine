import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<Field>> fetchFields(int trackerID) async {
  FieldDetail fd;
  List<Field> fields;
  Configuration config = Configuration();
  http.Response response = await http.get(
      Uri.https(config.baseURLs['homeServer']!,
          '${config.REST_URL_Prefix}/trackers/$trackerID/fields'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);
    fields = jsonRaw.map((item) => Field.fromJson(item)).toList();
  } else {
    print("Error fetching fields: ${response.statusCode}");
    return [];
  }
  for (Field field in fields) {
    fd = await fetchFieldDetail(trackerID, field.id);
    field.type = fd.type.substring(0, (fd.type.length - 'Field'.length));
    field.description = fd.description;
    field.title = fd.title;
    field.valueModel = fd.valueModel.endsWith('Value')
        ? fd.valueModel.truncateTo(fd.valueModel.length - 'Value'.length)
        : fd.valueModel;
    field.trackerItemField = fd.trackerItemField;
  }
  return fields;
}

Future<FieldDetail> fetchFieldDetail(int trackerID, int fieldID) async {
  Configuration config = Configuration();

  final response = await http.get(
      Uri.https(config.baseURLs['homeServer']!,
          '${config.REST_URL_Prefix}/trackers/$trackerID/fields/$fieldID'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return FieldDetail.fromJson(json);
  } else {
    print("Error fetching field detail: ${response.statusCode}");
    return FieldDetail();
  }
}

class Field {
  int id = 0;
  String name = '';
  String type = '';
  int trackerID = 0;
  String description = '';
  String valueModel = '';
  String title = '';
  String trackerItemField = '';

  Field({
    this.id = 0,
    this.name = '',
    this.type = '',
    this.trackerID = 0,
    this.description = '',
    this.title = '',
    this.valueModel = '',
    this.trackerItemField = '',
  });

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    trackerID = json['trackerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['type'] = type;
    data['trackerId'] = trackerID;
    return data;
  }

  @override
  String toString() {
    return '$id ($trackerID/$trackerItemField): $name as $type", "$valueModel", "$title"';
  }
}

class FieldDetail {
  int id = 0;
  String description = '';
  String type = '';
  String valueModel = '';
  String title = '';
  String trackerItemField = '';

  FieldDetail({
    id = 0,
    description = '',
    type = '',
    valueModel = '',
    title = '',
    trackerItemField = '',
  });

  FieldDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'] ?? '';
    type = json['type'] ?? '';
    valueModel = json['valueModel'] ?? '';
    title = json['title'] ?? '';
    trackerItemField = json['trackerItemField'] ?? '';
  }

  FieldDetail.toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['type'] = type;
    data['valueModel'] = valueModel;
    data['title'] = title;
    data['trackerItemField'] = trackerItemField;
  }

  @override
  String toString() {
    return '$id: Type $type: $description';
  }
}
