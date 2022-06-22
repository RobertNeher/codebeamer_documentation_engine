import 'package:flutter/material.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/src/group.dart';
import 'package:codebeamer_documentation_engine/src/license.dart';
import 'package:codebeamer_documentation_engine/src/project.dart';
import 'package:codebeamer_documentation_engine/src/tracker.dart';
import 'package:codebeamer_documentation_engine/widgets/table_view.dart';

int id = 0;

void setID(int newID) {
  id = newID;
  print(newID);
}

class HomeTopic extends StatelessWidget {
  const HomeTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 800,
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
      callback: setID,
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
      callback: setID,
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
