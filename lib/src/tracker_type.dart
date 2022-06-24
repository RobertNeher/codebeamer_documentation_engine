import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:codebeamer_documentation_engine/utils/utils.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';

Future<List<TrackerType>> fetchTrackerTypes(int trackerID) async {
  List<TrackerType> data = <TrackerType>[];
  Configuration config = Configuration();
  Uri uri = Uri.https(config.baseURLs['homeServer']!,
      '${config.REST_URL_Prefix}/trackers/types', {'outline': 'ANY'});
  http.Response response = await http.get(uri, headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);
    data = jsonRaw.map((item) => TrackerType.fromJson(item)).toList();
    return data;
  } else {
    print("Error fetching tracker types: ${response.statusCode}");
    return <TrackerType>[];
  }
}

class TrackerType {
  int? id;
  String? name;
  String? type;

  TrackerType({this.id, this.name, this.type});

  TrackerType.fromJson(Map<String, dynamic> json) {
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
