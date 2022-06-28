import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/widgets/table_view.dart';

import 'package:codebeamer_documentation_engine/src/document.dart';
import 'package:codebeamer_documentation_engine/src/job.dart';
import 'package:codebeamer_documentation_engine/src/wiki.dart';
import 'package:codebeamer_documentation_engine/src/group.dart';
import 'package:codebeamer_documentation_engine/src/license.dart';
import 'package:codebeamer_documentation_engine/src/project.dart';
import 'package:codebeamer_documentation_engine/src/tracker.dart';

int id = 0;
String name = '';

void setItem(newID, newName) {
  id = newID;
  name = newName;
}

class HomeTopic extends StatelessWidget {
  const HomeTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150, // BHC_Bar!
      color: const Color.fromARGB(255, 209, 209, 209),
    );
  }
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

class LicenseTopic extends StatelessWidget {
  const LicenseTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Expanded(
        child: TableView<License>(context,
            columnLabels: config.licenseHeadings, callback: () {}));
  }
}

class JobsTopic extends StatelessWidget {
  const JobsTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Expanded(
        child: TableView<Job>(context,
            columnLabels: config.jobsHeadings, callback: () {}));
  }
}

class DocumentsTopic extends StatelessWidget {
  const DocumentsTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Expanded(
        child: TableView<Document>(context,
            columnLabels: config.documentHeadings, callback: () {}));
  }
}

class TrackerTopic extends StatelessWidget {
  const TrackerTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    print('$id: $name');
    return Expanded(
        child: TableView<Tracker>(
      context,
      columnLabels: config.trackerHeadings,
      itemID: id,
      callback: setItem,
    ));
  }
}

class GroupTopic extends StatelessWidget {
  const GroupTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Expanded(
      child: TableView<Group>(context,
          columnLabels: config.groupHeadings, callback: () {}),
    );
  }
}

class WikiTopic extends StatelessWidget {
  const WikiTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();

    return Expanded(
      child: TableView<Wiki>(context,
          columnLabels: config.wikiHeadings, itemID: id, callback: () {}),
    );
  }
}
