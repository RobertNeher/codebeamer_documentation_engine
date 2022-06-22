import 'package:flutter/material.dart';

PreferredSizeWidget BHCBar(
    {String title = 'codebeamer Documentation Engine',
    List<Map<String, Object>> topics = const <Map<String, Object>>[]}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(90.0),
      child: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          flexibleSpace: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'BHC company logo',
                    child: Container(
                      height: 90.0,
                      child: Image.asset('assets/images/BHC.png'),
                    ),
                  ),
                ),
                Text(title,
                    style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ]),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(5.0),
              child: Container(height: 3, color: Colors.blueGrey),
          )
      ));
}
