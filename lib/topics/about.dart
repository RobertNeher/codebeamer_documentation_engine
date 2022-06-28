import 'package:flutter/material.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/widgets/BHC_dialog.dart';

//
class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);
//
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    Configuration config = Configuration();
    return Center(
      child: BHCDialogBox(
        buttonText: 'OK',
        title: 'About codebeamer Documentation Engine',
        description: config.aboutText,
      ));
  }
}
