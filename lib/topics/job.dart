import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';

import 'package:codebeamer_documentation_engine/src/job.dart';

import 'package:codebeamer_documentation_engine/widgets/table_view.dart';

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
