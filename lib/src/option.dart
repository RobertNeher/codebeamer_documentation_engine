import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/utils/utils.dart';

import 'package:codebeamer_documentation_engine/src/schema.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';

Future<List<Option>> fetchOptions(Schema field) async {
  List<Option> data = <Option>[];

  // TODO: Remove print
  print(field.toString());
  for (var option in field.options!) {
    data.add(Option(id: option.id!, name: option.name!));
  }
  return data;

// Future<List<Option>> fetchOptions(int id) async {
  // int trackerID = id ~/ 100;
  // int fieldID = id % 100;

  // List<Option> options = <Option>[];
  // Configuration config = Configuration();
  // List<OptionPage> pages = <OptionPage>[];
  // OptionPage stats;

  // final int maxPageSize = config.maxPageSize;

  // int maxPages;

  // var response = await http.get(
  //     Uri.https(config.baseURLs['homeServer'] as String,
  //         '${config.REST_URL_Prefix}/trackers/$trackerID/fields/$fieldID/options'),
  //     // {'page': '1', 'pageSize': maxPageSize.toString()}),
  //     headers: httpHeader());

  // if (response.statusCode == 200) {
  //   Map<String, dynamic> jsonRaw = jsonDecode(response.body);
  //   stats = OptionPage.fromJson(jsonRaw);
  //   maxPages = (stats.total / maxPageSize).ceil();
  // } else {
  //   return [];
  // }
  // for (int pageNr = 1; pageNr <= maxPages; pageNr++) {
  //   response = await http.get(
  //       Uri.https(config.baseURLs['homeServer'] as String,
  //           '${config.REST_URL_Prefix}/trackers/$trackerID/fields/$fieldID/options'),
  //       // {'page': pageNr.toString(), 'pageSize': maxPageSize.toString()}),
  //       headers: httpHeader());

  //   if (response.statusCode == 200) {
  //     OptionPage pageItem = OptionPage.fromJson(jsonDecode(response.body));
  //     pages.add(pageItem);
  //   } else {
  //     print("Error fetching options ${response.statusCode}");
  //     return [];
  //   }
  // }

  // for (var page in pages) {
  //   options.addAll(page.options);
  // }
  // return options;
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
    return '$id: $name of type $type';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}

class OptionPage {
  int page = 0;
  int pageSize = 0;
  int total = 0;
  List<Option> options = <Option>[];

  OptionPage(
      {this.page = 0,
      this.pageSize = 0,
      this.total = 0,
      this.options = const <Option>[]});

  OptionPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    total = json['total'];

    if (json['options'] != null) {
      json['options'].forEach((workItem) {
        options.add(Option.fromJson(workItem));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['total'] = total;
    data['users'] = options.map((option) => option.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return 'Page $page, Size: $pageSize, Total Users: $total';
  }
}
