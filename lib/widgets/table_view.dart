import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';

import 'package:codebeamer_documentation_engine/widgets/BHC_bar.dart';
import 'package:codebeamer_documentation_engine/widgets/powered_by.dart';
import 'package:codebeamer_documentation_engine/widgets/show_data.dart';
import 'package:codebeamer_documentation_engine/src/group.dart';
import 'package:codebeamer_documentation_engine/src/license.dart';
import 'package:codebeamer_documentation_engine/src/project.dart';
import 'package:codebeamer_documentation_engine/src/tracker.dart';
import 'package:codebeamer_documentation_engine/src/work_item.dart';
import 'package:codebeamer_documentation_engine/utils/fetch_data.dart';
import 'package:codebeamer_documentation_engine/src/schema.dart';
import 'package:codebeamer_documentation_engine/src/wiki.dart';
import 'package:codebeamer_documentation_engine/src/transition.dart';
import 'package:codebeamer_documentation_engine/src/relation.dart';
import 'package:codebeamer_documentation_engine/src/baseline.dart' as bl;
import 'package:codebeamer_documentation_engine/src/option.dart';
import 'package:codebeamer_documentation_engine/src/home.dart';
import 'package:codebeamer_documentation_engine/src/document.dart';
import 'package:codebeamer_documentation_engine/src/job.dart';

class TableView<T> extends StatefulWidget {
  final BuildContext context;
  int? itemID;
  final Schema? field;
  late Map<String, double>? columnLabels = {};
  final Function callback;

  TableView(this.context,
      {Key? key,
      this.columnLabels,
      this.itemID,
      this.field,
      required this.callback})
      : super(key: key);

  @override
  State<TableView<T>> createState() => TableViewState<T>();
}

class TableViewState<T> extends State<TableView<T>> {
  Configuration config = Configuration();

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return widget.columnLabels == null || widget.columnLabels!.isEmpty
        ? Container()
        : Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder<List<T>>(
                    future: fetchData<T>(widget.itemID),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasError) {
                          print(snapshot.stackTrace);
                          return Center(
                            child: Text(
                                'Error fetching $T data: ${snapshot.stackTrace}'),
                          );
                        } else if (snapshot.hasData) {
                          return Expanded(
                            child: Container(
                              alignment: Alignment.topCenter,
                              child: DataTable2(
                                showCheckboxColumn: false,
                                border: TableBorder.all(
                                  color: Colors.orange,
                                  width: 0.5,
                                  style: BorderStyle.solid,
                                  borderRadius: BorderRadius.zero,
                                ),
                                columns: _getHeadings(widget.columnLabels!),
                                rows: _getRows(snapshot.data!,
                                    widget.columnLabels!.length),
                                dataRowColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                dataTextStyle: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 199, 198, 198),
                                ),
                                headingRowColor:
                                    MaterialStateProperty.all(Colors.orange),
                                headingTextStyle: const TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ],
            ))
          ]);
  }

  List<DataColumn> _getHeadings(Map<String, double> headers) {
    List<DataColumn> headerRow = <DataColumn>[];

    if (headers.isEmpty) {
      return <DataColumn>[];
    }

    headers.forEach((key, value) {
      headerRow.add(DataColumn(
        label: Container(
          width: value,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: value),
            child: Text(
              key,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontFamily: "Railway",
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
      ));
    });
    return headerRow; //
  }

  List<DataRow2> _getRows(List<T> data, int cols) {
    List<DataRow2> tableRows = <DataRow2>[];

    if (data.isEmpty) {
      return <DataRow2>[];
    }

    for (int rowIndex = 0; rowIndex < data.length; rowIndex++) {
      List<DataCell> dataRow = <DataCell>[];

      T object = data[rowIndex];

      if (T == Group) {
        Group group = object as Group;
        dataRow.add(DataCell(Text(group.id.toString())));
        dataRow.add(DataCell(Text(group.name!)));
      } else if (T == License) {
        License license = object as License;
        dataRow.add(DataCell(Text(license.tag)));
        dataRow.add(DataCell(Text(license.content)));
      } else if (T == License) {
        Job job = object as Job;
        dataRow.add(DataCell(Text(job.schedulerName)));
        dataRow.add(DataCell(Text(job.triggerID)));
        dataRow.add(DataCell(Text(job.triggerType)));
        dataRow.add(DataCell(Text(job.priority)));
        dataRow.add(DataCell(Text(job.status)));
        dataRow.add(DataCell(Text(job.scheduledStart)));
        dataRow.add(DataCell(Text(job.lastStartAt)));
        dataRow.add(DataCell(Text(job.nextStartAt)));
      } else if (T == Document) {
        Document document = object as Document;
        dataRow.add(DataCell(Text(document.project)));
        dataRow.add(DataCell(Text(document.docsInUse)));
        dataRow.add(DataCell(Text(document.docsInWasteBin)));
        dataRow.add(DataCell(Text(document.foldersInUse)));
        dataRow.add(DataCell(Text(document.foldersInWasteBin)));
        dataRow.add(DataCell(Text(document.diskCapacityUsage)));
        dataRow.add(DataCell(Text(document.recoverableCapacity)));
      } else if (T == Project) {
        Project project = object as Project;
        dataRow.add(DataCell(Text(project.id.toString())));
        dataRow.add(DataCell(Text(project.name)));
        dataRow.add(DataCell(Text(project.description)));
        dataRow.add(DataCell(Text(project.keyName)));
      } else if (T == Wiki) {
        Wiki wiki = object as Wiki;
        dataRow.add(DataCell(Text(wiki.id.toString())));
        dataRow.add(DataCell(Text(wiki.name)));
      } else if (T == Tracker) {
        Tracker tracker = object as Tracker;
        dataRow.add(DataCell(Text(tracker.id.toString())));
        dataRow.add(DataCell(Text(tracker.name)));
        dataRow.add(DataCell(Text(tracker.description)));
        dataRow.add(DataCell(Text(tracker.itemCount.toString())));
        dataRow.add(DataCell(Text(tracker.keyName)));
      } else if (T == WorkItem) {
        WorkItem workItem = object as WorkItem;
        dataRow.add(DataCell(Text(workItem.id.toString())));
        dataRow.add(DataCell(Text(workItem.name)));
        dataRow.add(DataCell(Text(workItem.description)));
        fetchRelations(workItem.id).then((value) {
          workItem.hasRelation = value.isNotEmpty;
        });
        dataRow.add(DataCell(Text(workItem.hasRelation ? 'Yo' : 'Nope')));
      } else if (T == Schema) {
        Schema field = object as Schema;
        dataRow.add(DataCell(Text(field.id.toString())));
        dataRow.add(DataCell(Text(field.name!)));
        dataRow.add(DataCell(Text(field.type!)));
        dataRow.add(DataCell(Text(field.valueModel!)));
        dataRow.add(DataCell(Text(field.trackerItemField!)));
        dataRow.add(DataCell(Text(field.title!)));
      } else if (T == Option) {
        Option option = object as Option;
        dataRow.add(DataCell(Text(option.id.toString())));
        dataRow.add(DataCell(Text(option.name)));
      } else if (T == Transition) {
        Transition transition = object as Transition;
        dataRow.add(DataCell(Text(transition.id.toString())));
        dataRow.add(DataCell(Text(transition.name!)));
        // dataRow.add(DataCell(Text(transition.description!)));
        dataRow.add(DataCell(Text(transition.fromStatus!.name!)));
        dataRow.add(DataCell(Text(transition.toStatus!.name!)));
      } else if (T == bl.Baseline) {
        bl.Baseline baseline = object as bl.Baseline;
        dataRow.add(DataCell(Text(baseline.id.toString())));
        dataRow.add(DataCell(Text(baseline.name!)));
      }
      tableRows.add(DataRow2(
          cells: dataRow,
          onSelectChanged: (bool? value) {
            int selectedID = 0;
            String itemName = '';

            T object = data[rowIndex];

            if (T == Home) {
              selectedID = 0;
            } else if (T == Project) {
              selectedID = (object as Project).id;
              itemName = (object as Project).name;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(
                      appBar: BHCBar(),
                      body: ShowData(
                          topics: config.projectTopics,
                          id: selectedID,
                          name: (object as Project).name,
                          title:
                              'Details of project "#name#" (#id#)',
                          T: Home),
                      bottomSheet: PoweredBy())));
            } else if (T == Wiki) {
              selectedID = 0;
            } else if (T == Tracker) {
              selectedID = (object as Tracker).id;
              itemName = (object as Tracker).name;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(
                      appBar: BHCBar(),
                      body: ShowData(
                          topics: config.trackerTopics,
                          id: selectedID,
                          name: (object as Tracker).name,
                          title:
                              'Details of tracker "#name#" (#id#)',
                          T: Tracker),
                      bottomSheet: PoweredBy())));
            } else if (T == WorkItem) {
              selectedID = (object as WorkItem).id;
            } else if (T == Schema) {
              selectedID = (object as Field).id!;
            } else if (T == Option) {
              selectedID = 0;
            } else if (T == Transition) {
              selectedID = 0;
            } else if (T == bl.Baseline) {
              selectedID = 0;
            }
            widget.callback(selectedID, itemName);
          }));
    }
    return tableRows;
  }
}
