import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<Group>> fetchGroups() async {
  List<Group> data = <Group>[];

  Configuration config = Configuration();

  http.Response response = await http.get(
      Uri.https(config.baseURLs['homeServer']!, '/api/v3/users/groups'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);
    data = jsonRaw.map((item) => Group.fromJson(item)).toList();
    return data;
  } else {
    print("Error fetching groups: ${response.statusCode}");
    return [];
  }
}

class Group {
  Group({this.id, this.name});
  int? id;
  String? name;

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}

class Member {
  Member({this.id, this.name});
  int? id;
  String? name;
  String? email;

  Member.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['e-mail'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'e-mail': email,
    };
  }
}

class MemberPage {
  int page = 0;
  int pageSize = 0;
}
