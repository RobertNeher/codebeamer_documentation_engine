import 'package:codebeamer_documentation_engine/src/group.dart';
import 'package:codebeamer_documentation_engine/src/home.dart';
import 'package:codebeamer_documentation_engine/src/license.dart';
import 'package:codebeamer_documentation_engine/src/project.dart';
import 'package:codebeamer_documentation_engine/src/relation.dart';
import 'package:codebeamer_documentation_engine/src/tracker.dart';
import 'package:codebeamer_documentation_engine/src/tracker_type.dart';
import 'package:codebeamer_documentation_engine/src/transition.dart';
import 'package:codebeamer_documentation_engine/src/user.dart';
import 'package:codebeamer_documentation_engine/src/work_item.dart';
import 'package:codebeamer_documentation_engine/src/schema.dart';
import 'package:codebeamer_documentation_engine/src/option.dart';
import 'package:codebeamer_documentation_engine/src/wiki.dart';
import 'package:codebeamer_documentation_engine/src/baseline.dart' as bl;

Future<List<T>> fetchData<T>(var objectID) async {
  List<T> data = <T>[];

  if (T == Home) {
    data = [];
  } else if (T == Project) {
    data = await fetchProjects() as List<T>;
  } else if (T == Wiki) {
    data = await fetchWikis(objectID) as List<T>;
  } else if (T == Tracker) {
    data = await fetchTrackers(objectID) as List<T>;
  } else if (T == TrackerType) {
    data = await fetchTrackerTypes(objectID) as List<T>;
  } else if (T == WorkItem) {
    data = await fetchWorkItems(objectID) as List<T>;
  } else if (T == Schema) {
    data = await fetchSchema(objectID) as List<T>;
  } else if (T == Option) {
    data = fetchOptions(objectID) as List<T>;
  } else if (T == Relation) {
    data = await fetchRelations(objectID) as List<T>;
  } else if (T == Transition) {
    data = await fetchTransitions(objectID) as List<T>;
  } else if (T == bl.Baseline) {
    data = await bl.fetchBaselines(objectID) as List<T>;
  } else if (T == Group) {
    data = await fetchGroups() as List<T>;
  } else if (T == User) {
    data = await fetchUsers(objectID) as List<T>;
  } else if (T == License) {
    data = await fetchLicense() as List<T>;
  }
  return data;
}
