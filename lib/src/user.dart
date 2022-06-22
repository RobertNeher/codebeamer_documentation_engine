import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<User>> fetchUsers(int? id) async {
  List<User> users = <User>[];
  Configuration config = Configuration();
  List<UserPage> pages = <UserPage>[];
  UserPage stats;

  final int maxPageSize = config.maxPageSize;

  int maxPages;

  var response = await http.get(
    Uri.https(config.baseURLs['homeServer'] as String, id != 0?' /api/v3/groups/$id/members':
      '/api/v3/users',
          {'page': '1', 'pageSize': maxPageSize.toString()}),
      headers: httpHeader());

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonRaw = jsonDecode(response.body);
    stats = UserPage.fromJson(jsonRaw);
    maxPages = (stats.total / maxPageSize).ceil();
  } else {
    return [];
  }
  for (int pageNr = 1; pageNr <= maxPages; pageNr++) {
    response = await http.get(
        Uri.https(config.baseURLs['homeServer'] as String, '/api/v3/users',
            {'page': pageNr.toString(), 'pageSize': maxPageSize.toString()}),
        headers: httpHeader());

    if (response.statusCode == 200) {
      UserPage pageItem = UserPage.fromJson(jsonDecode(response.body));
      pages.add(pageItem);
    } else {
      print("Error fetching users ${response.statusCode}");
      return [];
    }
  }

  for (var page in pages) {
    users.addAll(page.users);
  }
  return users;
}

class User {
  User({this.id, this.name});
  int? id;
  String? name;
  String? email;

  User.fromJson(Map<String, dynamic> json) {
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

class UserPage {
  int page = 0;
  int pageSize = 0;
  int total = 0;
  List<User> users = <User>[];

  UserPage(
      {this.page = 0,
      this.pageSize = 0,
      this.total = 0,
      this.users = const <User>[]});

  UserPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    total = json['total'];

    if (json['users'] != null) {
      json['users'].forEach((workItem) {
        users.add(User.fromJson(workItem));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['total'] = total;
    data['users'] = users.map((user) => user.toJson()).toList();

    return data;
  }

  @override
  String toString() {
    return 'Page $page, Size: $pageSize, Total Users: $total';
  }
}
