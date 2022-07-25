import 'package:codebeamer_documentation_engine/src/workitem_children.dart';
import 'package:codebeamer_documentation_engine/widgets/BHC_dialog.dart';
import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';

import 'package:codebeamer_documentation_engine/widgets/table_view.dart';

import 'package:codebeamer_documentation_engine/src/field.dart' as fld;
import 'package:codebeamer_documentation_engine/src/option.dart';
import 'package:codebeamer_documentation_engine/src/transition.dart';
import 'package:codebeamer_documentation_engine/src/wiki.dart';
import 'package:codebeamer_documentation_engine/src/work_item.dart';
import 'package:codebeamer_documentation_engine/src/project.dart';
import 'package:codebeamer_documentation_engine/src/tracker.dart';
import 'package:codebeamer_documentation_engine/src/tracker_type.dart';

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
    final Configuration config = Configuration();
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
    final Configuration config = Configuration();

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
    final Configuration config = Configuration();
    return Expanded(
        child: TableView<WorkItem>(context,
            columnLabels: config.workItemHeadings,
            itemID: id,
            callback: setItem));
  }
}

class FieldTopic extends StatelessWidget {
  const FieldTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Configuration config = Configuration();
    return Expanded(
        child: TableView<fld.Field>(context,
            columnLabels: config.fieldHeadings, itemID: id, callback: setItem));
  }
}

class OptionTopic extends StatelessWidget {
  const OptionTopic({Key? key}) : super(key: key);

  // String optionsList = '';
  // fetchOptions(id).then((options) {
  //   for (Option option in options) {
  //     print(option); // TODO: Remove print

  //     optionsList += '${option.id}: ${option.name}\n';
  //   }
  // });
  // return BHCDialogBox(
  //     title: 'Options of field "$id"',
  //     description: optionsList,
  //     buttonText: "OK");

  @override
  Widget build(BuildContext context) {
    final Configuration config = Configuration();

    return Expanded(
        child: TableView<Option>(context,
            columnLabels: config.optionHeadings, itemID: id, callback: () {}));
  }
}

class BaselineTopic extends StatelessWidget {
  const BaselineTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Configuration config = Configuration();
    return Expanded(
        child: TableView<Baseline>(context,
            columnLabels: config.baselineHeadings,
            itemID: id,
            callback: () {}));
  }
}

class TransitionTopic extends StatelessWidget {
  const TransitionTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Configuration config = Configuration();
    return Expanded(
        child: TableView<Transition>(context,
            columnLabels: config.transitionHeadings,
            itemID: id,
            callback: () {}));
  }
}

class TrackerTypeTopic extends StatelessWidget {
  const TrackerTypeTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Configuration config = Configuration();
    return Expanded(
        child: TableView<TrackerType>(context,
            columnLabels: config.trackerTypeHeadings,
            itemID: id,
            callback: () {}));
  }
}

// TODO: Not complete, needs some concept
class ChildrenTopic extends StatelessWidget {
  const ChildrenTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Configuration config = Configuration();
    return Expanded(
        child: TableView<ItemRef>(context,
            columnLabels: config.itemRefsHeadings,
            itemID: id,
            callback: setItem));
  }
}
