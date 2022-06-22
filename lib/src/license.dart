import 'package:html/parser.dart';
import 'package:html/dom.dart';

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<License>> fetchLicense() async {
  List<License> data = [];
  Configuration config = Configuration();
  http.Response response;
  Uri uri = Uri.https(config.baseURLs['homeServer']!, config.licenseInfoURL);

  try {
    response = await http.get(uri, headers: httpHeader());

    if (response.statusCode == 200) {
      Document document = parse(response.body);

      List<Element> rawData =
          document.getElementsByClassName("labelColumn optional");

      for (Element item in rawData) {
        data.add(License(
            tag: item.text.trim(),
            content: item.nextElementSibling!.text.trim()));
      }
      return data;
    }
  } catch(e) {
    print(e);
    return<License>[];

  } throw(Exception e) {
    print(e);
    return<License>[];
  };
  // } else {
  //   print("Error fetching license data: ${response.statusCode}");
  //   return [];
  // }
}

class License {
  License({required this.tag, required this.content});
  String tag = '';
  String content = '';
}
