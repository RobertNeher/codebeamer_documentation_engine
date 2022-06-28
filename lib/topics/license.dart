import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';

import 'package:codebeamer_documentation_engine/src/license.dart';

import 'package:codebeamer_documentation_engine/widgets/table_view.dart';

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
