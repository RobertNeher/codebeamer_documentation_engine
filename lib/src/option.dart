import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/utils/utils.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';

Future<List<Option>> fetchOptions(int id) async {
  int trackerID = id ~/ 1000;
  int fieldID = id % 1000;
  List<Option> options = <Option>[];
  Configuration config = Configuration();
  int optionID = 0;

  try {
    do {
      var response = await http.get(
          Uri.https(config.baseURLs['homeServer'] as String,
              '${config.REST_URL_Prefix}/trackers/$trackerID/fields/$fieldID/options/$optionID'),
          headers: httpHeader());

      if (response.statusCode == 200) {
        Option option;
        Map<String, dynamic> jsonRaw = jsonDecode(response.body);
        option = Option.fromJson(jsonRaw);
        options.add(option);
        optionID++;
      } else {
        break;
      }
    } while (true);
    return options;
  } catch (e) {
    print(e);
    return <Option>[];
  }
}

class Option {
  int id;
  String name;
  String type;

  Option({this.id = 0, this.name = '', this.type = ''});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(id: json['id'], name: json['name'], type: json['type']);
  }

  @override
  String toString() {
    return '$id: $name\n';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
