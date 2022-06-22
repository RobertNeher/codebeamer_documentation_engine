import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:codebeamer_documentation_engine/utils/utils.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';

Future<List<Baseline>> fetchBaselines(int trackerID) async {
  Configuration config = Configuration();
  List<BaselinePage> pages = <BaselinePage>[];
  List<Baseline> data = <Baseline>[];
  BaselinePage stats;

  final int maxPageSize = config.maxPageSize;

  int maxPages = 0;

  var response = await http.get(
      Uri.https(
          config.baseURLs['homeServer'] as String,
          '/api/v3/trackers/$trackerID/baselines',
          {'page': '1', 'pageSize': maxPageSize.toString()}),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonRaw = jsonDecode(response.body);
    stats = BaselinePage.fromJson(jsonRaw);
    maxPages = (stats.total! / config.maxPageSize).ceil();
  } else {
    return [];
  }
  for (int pageNr = 1; pageNr <= maxPages; pageNr++) {
    response = await http.get(
        Uri.https(config.baseURLs['homeServer'] as String,
            '/api/v3/trackers/$trackerID/baselines', {
          'page': pageNr.toString(),
          'pageSize': config.maxPageSize.toString()
        }),
        headers: httpHeader());

    if (response.statusCode == 200) {
      BaselinePage pageItem = BaselinePage.fromJson(jsonDecode(response.body));
      pages.add(pageItem);
    } else {
      print("Error fetching baseline data: ${response.statusCode}");
      return [];
    }
  }

  for (var page in pages) {
    data.addAll(page.references!.toList());
  }
  return data;
}

class BaselinePage {
  int? page;
  int? pageSize;
  int? total;
  List<Baseline>? references;

  BaselinePage({this.page, this.pageSize, this.total, this.references});

  BaselinePage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    total = json['total'];
    if (json['references'] != null) {
      references = <Baseline>[];
      json['references'].forEach((v) {
        references!.add(Baseline.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['total'] = total;
    if (references != null) {
      data['references'] = references!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Baseline {
  int? id;
  String? name;
  String? type;

  Baseline({this.id, this.name, this.type});

  Baseline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
