import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

import 'package:codebeamer_documentation_engine/src/relation.dart';

Future<List<WorkItem>> fetchWorkItems(int trackerID) async {
  Configuration config = Configuration();
  List<WorkItemPage> pages = <WorkItemPage>[];
  List<WorkItem> items = <WorkItem>[];
  WorkItemPage stats;

  final int maxPageSize = config.maxPageSize;

  int maxPages;

  var response = await http.get(
      Uri.https(
          config.baseURLs['homeServer'] as String,
          '${config.REST_URL_Prefix}/trackers/$trackerID/items',
          {'page': '1', 'pageSize': maxPageSize.toString()}),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonRaw = jsonDecode(response.body);
    stats = WorkItemPage.fromJson(jsonRaw);
    maxPages = (stats.total / maxPageSize).ceil();
  } else {
    return [];
  }
  for (int pageNr = 1; pageNr <= maxPages; pageNr++) {
    response = await http.get(
        Uri.https(
            config.baseURLs['homeServer'] as String,
            '${config.REST_URL_Prefix}/trackers/$trackerID/items',
            {'page': pageNr.toString(), 'pageSize': maxPageSize.toString()}),
        headers: httpHeader());

    if (response.statusCode == 200) {
      WorkItemPage pageItem = WorkItemPage.fromJson(jsonDecode(response.body));
      pages.add(pageItem);
    } else {
      print("Error fetching workitems ${response.statusCode}");
      return [];
    }
  }

  for (var page in pages) {
    items.addAll(page.workItems);
  }
  return items;
}

Future<WorkItemDetail> fetchWorkItemDetail(int workItemID) async {
  List<Relation> relations = <Relation>[];

  Configuration config = Configuration();

  final response = await http.get(
      Uri.https(config.baseURLs['homeServer']!, '/api/v3/items/$workItemID'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return WorkItemDetail.fromJson(json);
  } else {
    print("Error fetching work item detail: ${response.statusCode}");
    return WorkItemDetail();
  }
}

class WorkItem {
  int id = 0;
  String name = '';
  String type = '';
  String description = '';
  bool hasRelation = false;

  WorkItem(
      {this.id = 0,
      this.name = '',
      this.type = '',
      this.description = '',
      this.hasRelation = false});

  factory WorkItem.fromJson(Map<String, dynamic> json) {
    return WorkItem(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return '$id: $name, $description';
  }
}

class WorkItemPage {
  int page = 0;
  int pageSize = 0;
  int total = 0;
  List<WorkItem> workItems = <WorkItem>[];

  WorkItemPage(
      {this.page = 0,
      this.pageSize = 0,
      this.total = 0,
      this.workItems = const <WorkItem>[]});

  WorkItemPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    total = json['total'];

    if (json['itemRefs'] != null) {
      json['itemRefs'].forEach((workItem) {
        workItems.add(WorkItem.fromJson(workItem));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['total'] = total;
    data['itemRefs'] = workItems.map((workItem) => workItem.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return 'Page $page, Size: $pageSize, Total Items: $total';
  }
}

class WorkItemDetail {
  int id = 0;
  String name = '';
  String description = '';
  bool hasRelation = false;

  WorkItemDetail({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.hasRelation = false,
  });

  WorkItemDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return '$id: $name, $description';
  }
}
