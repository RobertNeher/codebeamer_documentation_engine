import 'dart:js';

import 'package:flutter/material.dart';
import 'package:codebeamer_documentation_engine/main.dart';

const double PADDING = 5.0;
const double AVATAR_RADIUS = 50.0;

class BHCDialogBox extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;

  const BHCDialogBox({
    Key? key,
    required this.title,
    required this.description,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PADDING),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
              left: PADDING,
              top: AVATAR_RADIUS + PADDING,
              right: PADDING,
              bottom: PADDING),
          margin: const EdgeInsets.only(top: AVATAR_RADIUS),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(PADDING),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.pop;
                    },
                    child: Text(
                      buttonText,
                      style: const TextStyle(fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: PADDING,
          right: PADDING,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: AVATAR_RADIUS,
            child: ClipRRect(
                borderRadius:
                    const BorderRadius.all(Radius.circular(AVATAR_RADIUS)),
                child: Image.asset(
                  "assets/images/BHC.png",
                )),
          ),
        ),
      ],
    );
  }
}
