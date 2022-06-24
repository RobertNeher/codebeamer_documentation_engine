import 'package:html/parser.dart';
import 'package:html/dom.dart';

import 'package:http/http.dart' as http;

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<Job>> fetchJobs() async {
  List<Job> data = [];
  Configuration config = Configuration();
  http.Response response;
  Uri uri = Uri.https(config.baseURLs['homeServer']!, config.jobsInfoURL);

  try {
    response = await http.get(uri, headers: httpHeader());

    if (response.statusCode == 200) {
      Document document = parse(response.body);
      List<Element> oddData = document.getElementsByClassName("odd");
      List<Element> evenData = document.getElementsByClassName("even");

      for (Element oddItem in oddData) {
        List<String> oddRow = oddItem.text.split('\n');

        data.add(_sortOutRow(oddRow));
      }

      for (Element evenItem in evenData) {
        List<String> evenRow = evenItem.text.split('\n');

        data.add(_sortOutRow(evenRow));
      }
      return data;
    }
  } catch (e) {
    print(e);
    return <Job>[];
  }
  throw (Exception e) {
    print(e);
    return <Job>[];
  };
}

Job _sortOutRow(List<String> row) {
  return Job(
    schedulerName: row[7],
    triggerID: row[8],
    triggerType: row[5].split(': ')[1],
    status: row[9],
    priority: row[4].split(': ')[1],
    scheduledStart: row[10],
    lastStartAt: row[11],
    nextStartAt: row[12],
  );
}

class Job {
  Job(
      {required this.schedulerName,
      required this.triggerID,
      required this.triggerType,
      required this.priority,
      required this.status,
      required this.scheduledStart,
      required this.lastStartAt,
      required this.nextStartAt});
  String schedulerName = '';
  String priority;
  String triggerID = '';
  String triggerType = '';
  String status = '';
  String scheduledStart = '';
  String lastStartAt = '';
  String nextStartAt = '';

  @override
  String toString() {
    return ('Scheduler Name: $schedulerName\nTriggerID: $triggerID\nTrigger Type: $triggerType\nPriority: $priority\nStatus: $status\nPlanned start: $scheduledStart\nLast start at: $lastStartAt\nNext start at: $nextStartAt');
  }
}
