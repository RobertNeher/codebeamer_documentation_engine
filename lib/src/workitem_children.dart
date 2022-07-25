import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/utils/utils.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';

Future<List<int>> fetchWorkItemChildren(int workItemID) async {
  final Configuration config = Configuration();
  List<int> items = <int>[];

  config.maxPageSize;

  http.Response response;

  for (int pageNr = 1; true; pageNr++) {
    try {
      response = await http.get(
          Uri.https(config.baseURLs['homeServer']!,
              '${config.REST_URL_Prefix}/items/$workItemID/children', {
            'page': pageNr.toString(),
            'pageSize': config.maxPageSize.toString()
          }),
          headers: httpHeader());

      if (response.statusCode == 200) {
        Children refItem = Children.fromJson(jsonDecode(response.body));

        if (refItem.itemRefs!.isEmpty) {
          break;
        }
        refItem.itemRefs!.map((item) => items.add(item.id!)).toList();
      } else {
        print("Error fetching workitem children ${response.statusCode}");
        return <int>[];
      }
    } catch (e) {
      print('Error fetching workitem children: $e');
      return <int>[];
    }
  }
  return items;
}

class Children {
  List<ItemRef>? itemRefs;
  int? page;
  int? pageSize;
  int? total;

  Children({this.itemRefs, this.page, this.pageSize, this.total});

  Children.fromJson(Map<String, dynamic> json) {
    if (json['n'] != null) {
      itemRefs = <ItemRef>[];
      json['Children'].forEach((v) {
        itemRefs!.add(ItemRef.fromJson(v));
      });
    }
    page = json['page'];
    pageSize = json['pageSize'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (itemRefs != null) {
      data['itemRefs'] = itemRefs!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['total'] = total;
    return data;
  }
}

class ItemRef {
  int? id;
  String? name;
  ItemRef({this.id, this.name});

  ItemRef.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ReferenceData {
  String? suspectPropagation;

  ReferenceData({this.suspectPropagation});

  ReferenceData.fromJson(Map<String, dynamic> json) {
    suspectPropagation = json['suspectPropagation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['suspectPropagation'] = suspectPropagation;
    return data;
  }
}
