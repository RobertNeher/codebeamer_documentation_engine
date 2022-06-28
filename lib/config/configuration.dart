import "dart:convert";
import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/topics/document.dart';
import 'package:codebeamer_documentation_engine/topics/group.dart';
import 'package:codebeamer_documentation_engine/topics/job.dart';
import 'package:codebeamer_documentation_engine/topics/license.dart';
import 'package:codebeamer_documentation_engine/topics/home.dart';
import 'package:codebeamer_documentation_engine/topics/home_level.dart';
import 'package:codebeamer_documentation_engine/topics/about.dart';

class Configuration {
  static String _REST_User = 'ROBNEH01';
  static String _REST_Password = 'INfLuxTeREST';
  // static String _REST_User = 'bond';
  // static String _REST_Password = '007';
  final Map<String, int> _fieldTypes = <String, int>{}; // codebeamer Data Types
  static const String _REST_URL_Prefix = '/api/v3/';
  static const String _licenseInfoURL =
      '/sysadmin/configLicense.spr'; // root to REST
  static const String _jobsInfoURL = '/sysadmin/quartz/triggers.spr';
  static const String _documentsInfoURL = '/sysadmin/documentsSummary.do';
  static const int _documentationProjectID = 7;
  static const int _associcationRole = 3;
  static const String _associcationName = 'child';
  static const int _maxPageSize = 500;
  static const String _placeholderID = '#id#';
  static const String _placeholderName = '#name#';
  static final String _aboutText =
      """This application retrieves all data avaiable which may be
  accessed through codebeamer's Swagger API
  "https://${_baseURLs['homeServer']}/v3/swagger/editor.spr"
  This service is continously updated by BHC Consulting GmbH.

  Please call for your data you need out from your productive codebeamer instance at https://www.b-h-c.de/#kontakt-info

  Copyright: BHC Consulting GmbH, 2022
  Author: Robert Neher (robert.neher@b-h-c.de)
  """;

  static final Map<String, double> _projectHeadings = {
    'ID': 30,
    'Name': 50,
    'Description': 200,
    'Key': 50,
  };

  static final Map<String, double> _licenseHeadings = {
    'Tag': 30,
    'Content': 200,
  };

  static final Map<String, double> _documentHeadings = {
    'Project': 100,
    'Docs in use': 50,
    'Docs in waste bin': 50,
    'Folders in use': 50,
    'Folders in waste bin': 50,
    'Disk capacity (total)': 50,
    'Disk capacity (recoverable': 50,
  };

  static final Map<String, double> _jobsHeadings = {
    'Scheduler Name': 100,
    'Trigger ID': 100,
    'Trigger Type': 100,
    'Priority': 40,
    'Status': 75,
    'Scheduled start at': 100,
    'Last run at': 100,
    'Next run at': 100
  };

  static final Map<String, double> _groupHeadings = {
    'ID': 30,
    'Name': 200,
  };

  static final Map<String, double> _workItemHeadings = {
    'ID': 30,
    'Name': 200,
    'Description': 400,
  };

  static final Map<String, double> _trackerHeadings = {
    'ID': 30,
    'Name': 50,
    'Description': 200,
    'Work items count': 50,
    'Key': 50,
  };

  static final Map<String, double> _wikiHeadings = {
    'ID': 30,
    'Name': 200,
  };

  static final List<Map<String, Object>> _homeTopics = [
    {
      'topic': 'Home',
      'icon': Icons.home_sharp,
      'widget': const HomeTopic(),
      'subTitle': 'Details of server "${_baseURLs['homeServer']}"'
    },
    {
      'topic': 'Projects',
      'icon': Icons.money_sharp,
      'widget': const ProjectTopic(),
      'subTitle': 'Projects hosted on server "${_baseURLs['homeServer']}"'
    },
    {
      'topic': 'License',
      'icon': Icons.label_important_sharp,
      'widget': const LicenseTopic(),
      'subTitle': 'License details for server "${_baseURLs['homeServer']}"'
    },
    {
      'topic': 'Jobs',
      'icon': Icons.work_sharp,
      'widget': const JobsTopic(),
      'subTitle': 'Jobs on server "${_baseURLs['homeServer']}"'
    },
    {
      'topic': 'Documents',
      'icon': Icons.document_scanner_sharp,
      'widget': const DocumentsTopic(),
      'subTitle': 'Documents managed on server "${_baseURLs['homeServer']}"'
    },
    {
      'topic': 'Groups',
      'icon': Icons.people_sharp,
      'widget': const GroupTopic(),
      'subTitle': 'Groups defined on server "${_baseURLs['homeServer']}"'
    },
    {
      'topic': 'About',
      'icon': Icons.help_sharp,
      'widget': const About(),
      'subTitle': 'About codebeamer Documentation Engine'
    },
  ];

  static final List<Map<String, Object>> _projectTopics = [
    {
      'topic': 'Trackers',
      'icon': Icons.table_chart_sharp,
      'widget': const TrackerTopic(),
      'subTitle': 'Trackers of project "$_placeholderName" ($_placeholderID)'
    },
    {
      'topic': 'Wikis',
      'icon': Icons.document_scanner_sharp,
      'widget': WikiTopic(),
      'subTitle': 'Wikis of project "$_placeholderName" ($_placeholderID)'
    },
  ];

  static final List<Map<String, Object>> _trackerTopics = [
    {
      'topic': 'Work Items',
      'icon': Icons.table_chart_sharp,
      'widget': const WorkItemTopic(),
      'subTitle': 'Work Items of tracker "$_placeholderName" ($_placeholderID)'
    },
    {
      'topic': 'Fields',
      'icon': Icons.input_sharp,
      'widget': const Text('Fields'),
      'subTitle': 'Fields of tracker "$_placeholderName" ($_placeholderID)'
    },
    {
      'topic': 'Baselines',
      'icon': Icons.timeline_sharp,
      'widget': const Text('Baselines'),
      'subTitle': 'Baselines of tracker "$_placeholderName" ($_placeholderID)'
    },
    {
      'topic': 'Transitions',
      'icon': Icons.traffic_sharp,
      'widget': const Text('Transitions'),
      'subTitle':
          'Transitions configured for tracker "$_placeholderName" ($_placeholderID)'
    },
  ];

  static final Map<String, int> _trackers = {
    'Project': 11739,
    'Tracker': 11421,
    'Field': 11507,
    'Wiki': 10439,
  };

  static final Map<String, String> _baseURLs = {
    'homeServer': 'codebeamer.b-h-c.de',
    'documentationServer': 'codebeamer.b-h-c.de',
  };

  Map<String, double> get licenseHeadings {
    return _licenseHeadings;
  }

  Map<String, double> get jobsHeadings {
    return _jobsHeadings;
  }

  Map<String, double> get groupHeadings {
    return _groupHeadings;
  }

  Map<String, double> get projectHeadings {
    return _projectHeadings;
  }

  Map<String, double> get trackerHeadings {
    return _trackerHeadings;
  }

  Map<String, double> get documentHeadings {
    return _documentHeadings;
  }

  Map<String, double> get wikiHeadings {
    return _wikiHeadings;
  }

  Map<String, double> get workItemHeadings {
    return _workItemHeadings;
  }

  Map<String, String> get baseURLs {
    return _baseURLs;
  }

  String get associationName {
    return _associcationName;
  }

  int get associationRole {
    return _associcationRole;
  }

  int get documentationProjectID {
    return _documentationProjectID;
  }

  Map<String, int> get docTrackers {
    return _trackers;
  }

  Map<String, int> get fieldTypes {
    return _fieldTypes;
  }

  String get REST_User {
    return _REST_User;
  }

  String get REST_Password {
    return _REST_Password;
  }

  String get REST_URL_Prefix {
    return _REST_URL_Prefix;
  }

  String get licenseInfoURL {
    return _licenseInfoURL;
  }

  String get jobsInfoURL {
    return _jobsInfoURL;
  }

  String get documentsInfoURL {
    return _documentsInfoURL;
  }

  int get maxPageSize {
    return _maxPageSize;
  }

  String get placeholderID {
    return _placeholderID;
  }

  String get placeholderName {
    return _placeholderName;
  }

  List<Map<String, Object>> get homeTopics {
    return _homeTopics;
  }

  List<Map<String, Object>> get projectTopics {
    return _projectTopics;
  }

  List<Map<String, Object>> get trackerTopics {
    return _trackerTopics;
  }

  String getAuthToken([String type = "Basic"]) {
    String token = base64.encode(utf8.encode("$REST_User:$REST_Password"));
    return "$type $token";
  }

  String get aboutText {
    return _aboutText;
  }
}
