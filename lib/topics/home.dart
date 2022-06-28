import 'package:flutter/material.dart';

class HomeTopic extends StatelessWidget {
  const HomeTopic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 150, // BHC_Bar!
      color: const Color.fromARGB(255, 209, 209, 209),
    );
  }
}
