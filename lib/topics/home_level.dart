import 'package:codebeamer_documentation_engine/src/wiki.dart';
import 'package:codebeamer_documentation_engine/src/work_item.dart';
import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/widgets/table_view.dart';
import 'package:codebeamer_documentation_engine/src/project.dart';
import 'package:codebeamer_documentation_engine/src/tracker.dart';

int id = 0;
String name = '';

void setItem(newID, newName) {
  id = newID;
  name = newName;
}

class ProjectTopic extends StatelessWidget {
  const ProjectTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Expanded(
        child: TableView<Project>(
      context,
      columnLabels: config.projectHeadings,
      callback: setItem,
    ));
  }
}

class TrackerTopic extends StatelessWidget {
  const TrackerTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Expanded(
        child: TableView<Tracker>(
      context,
      columnLabels: config.trackerHeadings,
      itemID: id,
      callback: setItem,
    ));
  }
}

class WikiTopic extends StatelessWidget {
  WikiTopic({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();

    return Expanded(
      child: TableView<Wiki>(context,
          columnLabels: config.wikiHeadings, itemID: id, callback: () {}),
    );
  }
}

class WorkItemTopic extends StatelessWidget {
  const WorkItemTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Expanded(
        child: TableView<WorkItem>(context,
            columnLabels: config.workItemHeadings, callback: setItem));
  }
}
