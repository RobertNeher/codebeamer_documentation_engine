import 'package:html/parser.dart';
import 'package:html/dom.dart' as dom;

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<Document>> fetchDocuments() async {
  List<Document> data = [];
  Configuration config = Configuration();
  http.Response response;
  Uri uri = Uri.https(config.baseURLs['homeServer']!, config.documentsInfoURL);

  try {
    response = await http.get(uri, headers: httpHeader());

    if (response.statusCode == 200) {
      dom.Document document = parse(response.body);
      List<dom.Element> oddData = document.getElementsByClassName("odd");
      List<dom.Element> evenData = document.getElementsByClassName("even");

      for (dom.Element oddItem in oddData) {
        List<String> oddRow = oddItem.text.split('\n');

        data.add(_sortOutRow(oddRow));
      }

      for (dom.Element evenItem in evenData) {
        List<String> evenRow = evenItem.text.split('\n');

        data.add(_sortOutRow(evenRow));
      }
      return data;
    }
  } catch (e) {
    print(e);
    return <Document>[];
  }
  throw (Exception e) {
    return <Document>[];
  };
}

Document _sortOutRow(List<String> row) {
  return Document(
    project: row[7],
    docsInUse: row[8],
    docsInWasteBin: row[5].split(': ')[1],
    foldersInUse: row[9],
    foldersInWasteBin: row[4].split(': ')[1],
    diskCapacityUsage: row[10],
    recoverableCapacity: row[11],
  );
}

class Document {
  Document({
    required this.project,
    required this.docsInUse,
    required this.docsInWasteBin,
    required this.foldersInUse,
    required this.foldersInWasteBin,
    required this.diskCapacityUsage,
    required this.recoverableCapacity,
  });
  String project = '';
  String docsInUse = '';
  String docsInWasteBin = '';
  String foldersInUse = '';
  String foldersInWasteBin = '';
  String diskCapacityUsage = '';
  String recoverableCapacity = '';

  @override
  String toString() {
    return ('Project: $project\nDocuments in use: $docsInUse\nDocuments in waste bin: $docsInWasteBin\nFolders in use: $foldersInUse\nFolders in waste bin: $foldersInWasteBin\nDisk capacity (total): $diskCapacityUsage\nDisk capacity (recoverable): $recoverableCapacity\n');
  }
}
