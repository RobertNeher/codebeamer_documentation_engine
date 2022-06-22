import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

import 'package:codebeamer_documentation_engine/src/work_item.dart';

Future<Tracker> lookupTrackerName(String name) async {
  Configuration config = Configuration();
  http.Response response;

  String docServer = config.baseURLs['documentationServer']!;
  String path = '/api/v3/items/query';

  try {
    response = await http.get(
        Uri.https(docServer, path, {
          'page': '1',
          'pageSize': '25',
          'queryString':
              'tracker.id in (${config.docTrackers["Tracker"]}) AND summary=\'$name\'',
        }),
        headers: httpHeader());
  } catch (e) {
    return Tracker();
  }
  if (response.statusCode == 200) {
    Map<String, dynamic> result = jsonDecode(response.body);

    if (result.length == 4 && result['total'] >= 1) {
      Tracker value = Tracker.fromJson(result['items'][0]);
      value.trackerID = result['items'][0]['customFields'][0]['value'];
      return value;
    } else {
      return Tracker();
    }
  }
  return Tracker();
}

Future<List<Tracker>> fetchTrackers(int projectID) async {
  List<Tracker> trackers;
  TrackerDetail td;
  Configuration config = Configuration();

  http.Response response = await http.get(
      Uri.https(config.baseURLs['homeServer']!,
          '/api/v3/projects/$projectID/trackers'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);
    trackers = jsonRaw.map((item) => Tracker.fromJson(item)).toList();
  } else {
    print("Error fetching trackers: ${response.statusCode}");
    return [];
  }
  for (Tracker tracker in trackers) {
    td = await fetchTrackerDetail(tracker.id);
    tracker.description = td.description;
    tracker.keyName = td.keyName;
    tracker.itemCount = await fetchTrackerItemCount(tracker.id);
  }
  return trackers;
}

Future<TrackerDetail> fetchTrackerDetail(int trackerID) async {
  Configuration config = Configuration();

  final response = await http.get(
      Uri.https(config.baseURLs['homeServer']!, '/api/v3/trackers/$trackerID'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return TrackerDetail.fromJson(json);
  } else {
    print("Error fetching tracker detail: ${response.statusCode}");
    return TrackerDetail();
  }
}

Future<int> fetchTrackerItemCount(int trackerID) async {
  Configuration config = Configuration();
  WorkItemPage wip = WorkItemPage();

  final response = await http.get(
      Uri.https(
          config.baseURLs['homeServer'] as String,
          '/api/v3/trackers/$trackerID/items',
          {'page': '1', 'pageSize': "500"}),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonRaw = jsonDecode(response.body);
    wip = WorkItemPage.fromJson(jsonRaw);
    return wip.total;
  } else {
    return -1;
  }
  return 0;
}

class Tracker {
  int id = 0;
  int trackerID = 0;
  String name = '';
  String description = '';
  String keyName = '';
  int itemCount = 0;

  Tracker({
    this.id = 0,
    this.trackerID = 0,
    this.name = '',
    this.description = '',
    this.keyName = '',
    this.itemCount = 0,
  });

  Tracker.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }

  @override
  String toString() {
    return '$id: "$name", "$description"';
  }
}

class TrackerDetail {
  String description = '';
  String keyName = '';
  String createdAt = '';

  TrackerDetail({
    this.description = '',
    this.keyName = '',
  });

  TrackerDetail.fromJson(Map<String, dynamic> json) {
    description = json['description'] ?? '';
    keyName = json['keyName'] ?? '';
  }

  TrackerDetail.toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['keyName'] = keyName;
  }
}
