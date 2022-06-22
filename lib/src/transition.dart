import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/utils/utils.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';

// trackerID could be either tracker ID or work item ID
Future<List<Transition>> fetchTransitions(int trackerID) async {
  List<Transition> data = <Transition>[];

  Configuration config = Configuration();
  Uri uri = Uri.https(config.baseURLs['homeServer']!,
      '/api/v3/trackers/$trackerID/transitions');
  http.Response response = await http.get(uri, headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);
    data = jsonRaw.map((item) => Transition.fromJson(item)).toList();
    return data;
  } else {
    print("Error fetching transitions: ${response.statusCode}");
    return <Transition>[];
  }
}

class Transition {
  int? id;
  String? name;
  String? description;
  String? descriptionFormat;
  FromStatus? fromStatus;
  FromStatus? toStatus;
  bool? hidden;
  List<Permissions>? permissions;

  Transition(
      {id,
      name,
      description,
      descriptionFormat,
      fromStatus,
      toStatus,
      hidden,
      permissions});

  Transition.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    descriptionFormat = json['descriptionFormat'];
    fromStatus = json['fromStatus'] != null
        ? FromStatus.fromJson(json['fromStatus'])
        : null;
    toStatus =
        json['toStatus'] != null ? FromStatus.fromJson(json['toStatus']) : null;
    hidden = json['hidden'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['descriptionFormat'] = descriptionFormat;
    if (fromStatus != null) {
      data['fromStatus'] = fromStatus!.toJson();
    }
    if (toStatus != null) {
      data['toStatus'] = toStatus!.toJson();
    }
    data['hidden'] = hidden;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FromStatus {
  int? id;
  String? name;
  String? type;

  FromStatus({id, name, type});

  FromStatus.fromJson(Map<String, dynamic> json) {
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

class Permissions {
  FromStatus? role;
  Field? field;
  FromStatus? project;
  String? accessLevel;

  Permissions({role, field, project, accessLevel});

  Permissions.fromJson(Map<String, dynamic> json) {
    role = json['role'] != null ? FromStatus.fromJson(json['role']) : null;
    field = json['field'] != null ? Field.fromJson(json['field']) : null;
    project =
        json['project'] != null ? FromStatus.fromJson(json['project']) : null;
    accessLevel = json['accessLevel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (role != null) {
      data['role'] = role!.toJson();
    }
    if (field != null) {
      data['field'] = field!.toJson();
    }
    if (project != null) {
      data['project'] = project!.toJson();
    }
    data['accessLevel'] = accessLevel;
    return data;
  }
}

class Field {
  int? id;
  String? name;
  String? type;
  int? trackerId;

  Field({id, name, type, trackerId});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    trackerId = json['trackerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['trackerId'] = trackerId;
    return data;
  }
}
