import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

class Wiki {
  int projectID;
  int id;
  String name;

  Wiki(this.projectID, this.id, this.name);

  factory Wiki.fromJson(Map<String, dynamic> json) {
    return Wiki(
      json['projectID'],
      json['id'],
      json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectID': projectID,
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return '$id: $name';
  }
}

class WikiPage {
  int? page;
  int? pageSize;
  int? total;
  List<OutlineWikiPages>? outlineWikiPages;

  WikiPage({this.page, this.pageSize, this.total, this.outlineWikiPages});

  WikiPage.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    total = json['total'];
    if (json['outlineWikiPages'] != null) {
      outlineWikiPages = <OutlineWikiPages>[];
      json['outlineWikiPages'].forEach((v) {
        outlineWikiPages!.add(OutlineWikiPages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['pageSize'] = pageSize;
    data['total'] = total;
    if (outlineWikiPages != null) {
      data['outlineWikiPages'] =
          outlineWikiPages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OutlineWikiPages {
  List<OutlineIndexes>? outlineIndexes;
  String? type;
  WikiPageReferenceModel? wikiPageReferenceModel;

  OutlineWikiPages(
      {this.outlineIndexes, this.type, this.wikiPageReferenceModel});

  OutlineWikiPages.fromJson(Map<String, dynamic> json) {
    if (json['outlineIndexes'] != null) {
      outlineIndexes = <OutlineIndexes>[];
      json['outlineIndexes'].forEach((v) {
        outlineIndexes!.add(OutlineIndexes.fromJson(v));
      });
    }
    type = json['type'];
    wikiPageReferenceModel = json['wikiPageReferenceModel'] != null
        ? WikiPageReferenceModel.fromJson(json['wikiPageReferenceModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (outlineIndexes != null) {
      data['outlineIndexes'] = outlineIndexes!.map((v) => v.toJson()).toList();
    }
    data['type'] = type;
    if (wikiPageReferenceModel != null) {
      data['wikiPageReferenceModel'] = wikiPageReferenceModel!.toJson();
    }
    return data;
  }
}

class OutlineIndexes {
  int? level;
  int? index;

  OutlineIndexes({this.level, this.index});

  OutlineIndexes.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['index'] = index;
    return data;
  }
}

class WikiPageReferenceModel {
  int? id;
  String? name;
  String? type;

  WikiPageReferenceModel({this.id, this.name, this.type});

  WikiPageReferenceModel.fromJson(Map<String, dynamic> json) {
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

Future<List<Wiki>> fetchWikis(int project) async {
  Configuration config = Configuration();
  List<Wiki> result = <Wiki>[];
  List<WikiPage> pages = <WikiPage>[];
  WikiPage stats;
  int maxPages = 0;
  http.Response? response;

  try {
    Uri uri = Uri.https(
        config.baseURLs['homeServer']!,
        '${config.REST_URL_Prefix}/projects/$project/wikipages',
        {'page': '1', 'pageSize': config.maxPageSize.toString()});
    response = await http.get(uri, headers: httpHeader());

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonRaw = jsonDecode(response.body);
      stats = WikiPage.fromJson(jsonRaw);
      maxPages =
          stats.total! < config.maxPageSize
          ? 1
          : (stats.total! / config.maxPageSize).ceil();
    } else {
      return [];
    }

    for (int page = 1; page <= maxPages; page++) {
      uri = Uri.https(
          config.baseURLs['homeServer']!,
          '${config.REST_URL_Prefix}/projects/$project/wikipages',
          {'page': page.toString(), 'pageSize': config.maxPageSize.toString()});
      response = await http.get(uri, headers: httpHeader());

      if (response.statusCode == 200) {
        WikiPage pageItem = WikiPage.fromJson(jsonDecode(response.body));
        pages.add(pageItem);
      } else {
        print("Error fetching wiki pages ${response.statusCode}");
        return [];
      }
    }
  } catch (e) {
    print(
        'Error in fetching wiki pages from project $project: ${response!.statusCode}: ${response.body}');
  }

  for (WikiPage page in pages) {
    for (OutlineWikiPages item in page.outlineWikiPages!) {
      result.add(Wiki(project, item.wikiPageReferenceModel!.id!,
          item.wikiPageReferenceModel!.name!));
    }
  }
  return result;
}
