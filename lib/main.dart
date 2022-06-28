import 'package:codebeamer_documentation_engine/src/home.dart';
import 'package:codebeamer_documentation_engine/src/project.dart';
import 'package:flutter/material.dart';
import 'package:codebeamer_documentation_engine/widgets/show_data.dart';

import 'package:codebeamer_documentation_engine/widgets/BHC_bar.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/widgets/powered_by.dart';
import 'package:codebeamer_documentation_engine/topics/home_level.dart';

void main() {
  runApp(const codebeamerDocumentationEngine());
}

class codebeamerDocumentationEngine extends StatelessWidget {
  const codebeamerDocumentationEngine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BHC codebeamer documentation engine',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      // home: const HomePage(title: 'BHC codebeamer documentation engine'),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(title: ''),
        '/projects': (context) => const ProjectTopic(),
        '/trackers':(context) => const TrackerTopic(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  Configuration config = Configuration();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BHCBar(),
        body: ShowData(
            topics: config.homeTopics,
            id: 0,
            name: '',
            title: '${config.homeTopics[0]['subTitle']}',
            T: Home),
        bottomSheet: PoweredBy());
  }
}
