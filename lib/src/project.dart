import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<Project> lookupProjectName(int projectID) async {
  Configuration config = Configuration();
  http.Response response;

  String docServer = config.baseURLs['documentationServer']!;
  String path = '/api/v3/items/query';

  try {
    String query =
        'project.id in (${config.documentationProjectID}) AND tracker.id in (${config.docTrackers["Project"]}) and \'${config.docTrackers["Project"]}.customField[0]\' = \'$projectID\'';

    response = await http.get(
        Uri.https(docServer, path,
            {'page': '1', 'pageSize': '25', 'queryString': query}),
        headers: httpHeader());
  } catch (e) {
    return Project();
  }
  if (response.statusCode == 200) {
    Map<String, dynamic> result = jsonDecode(response.body);

    if (result.length == 4 && result['total'] >= 1) {
      Map<String, dynamic> item = result['items'][0];
      return Project.fromJson({
        'id': item['id'],
        'name': item['name'],
        'description': item['description'],
      });
    } else {
      return Project();
    }
  }
  return Project();
}

Future<List<Project>> fetchProjects() async {
  List<Project> projects;
  Configuration config = Configuration();

  http.Response response = await http.get(
      Uri.https(config.baseURLs['homeServer']!, '/api/v3/projects'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);

    projects = jsonRaw.map((item) => Project.fromJson(item)).toList();

    for (Project project in projects) {
      ProjectDetail pd = await fetchProjectDetail(project.id);
      project.description = pd.description;
      project.keyName = pd.keyName;
    }
  } else {
    print('Error fetching project data: ${response.statusCode}');
    projects = [];
  }
  return projects;
}

Future<ProjectDetail> fetchProjectDetail(int projectID) async {
  Configuration config = Configuration();

  final response = await http.get(
      Uri.https(config.baseURLs['homeServer']!, '/api/v3/projects/$projectID'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    return ProjectDetail.fromJson(json);
  } else {
    print("Error fetching project detail ${response.statusCode}");
    return ProjectDetail();
  }
}

class Project {
  int id;
  String name;
  String description;
  String keyName;

  Project(
      {this.id = 0, this.name = '', this.description = '', this.keyName = ''});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(id: json['id'], name: json['name']);
  }

  @override
  String toString() {
    return '$id: "$name", "$description", ';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ProjectDetail {
  int id = 0;
  String name = '';
  String description = '';
  String keyName = '';

  ProjectDetail({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.keyName = '',
  });

  ProjectDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    keyName = json['keyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['keyName'] = keyName;
    return data;
  }
}
