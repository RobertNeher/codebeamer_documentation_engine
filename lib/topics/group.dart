import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/src/group.dart';
import 'package:codebeamer_documentation_engine/widgets/table_view.dart';

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
