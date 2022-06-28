import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/src/document.dart';
import 'package:codebeamer_documentation_engine/widgets/table_view.dart';

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
