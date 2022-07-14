import 'package:flutter/material.dart';

import 'package:codebeamer_documentation_engine/config/configuration.dart';

import 'package:codebeamer_documentation_engine/src/field.dart';

class ShowData extends StatefulWidget {
  ShowData(
      {Key? key,
      required this.topics,
      required this.title,
      required this.id,
      required this.name,
      // this.optionField,
      required this.T})
      : super(key: key);
  String title;
  int id;
  String name;
  // Field? optionField;
  List<Map<String, Object>> topics;
  Type T;

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  late Configuration _config;
  late ValueNotifier<String> _selectedItem;
  String? _subTitle = '';
  int _index = 0;

  @override
  void initState() {
    _index = 0;
    _config = Configuration();
    _subTitle = _processTitle(widget.title, widget.id, widget.name, _config);
    _selectedItem = ValueNotifier<String>(widget.topics[0]['topic'] as String);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  String _processTitle(
      String titleWithPlaceholders, int id, String name, Configuration config) {
    String title =
        titleWithPlaceholders.replaceAll(config.placeholderID, id.toString());
    return title.replaceAll(config.placeholderName, name);
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: <
        Widget>[
      Container(
        color: const Color.fromARGB(210, 255, 207, 136),
        child: StatefulBuilder(
            builder: ((BuildContext context, StateSetter setInnerState) {
          return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Spacer(),
                Text(_subTitle!,
                    style: const TextStyle(
                      fontFamily: "Railway",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blueGrey,
                    )),
                const Spacer(),
                widget.topics.isNotEmpty
                    ? DropdownButton<String>(
                        onChanged: (String? newValue) {
                          _index = 0;
                          for (Map<String, Object> topic in widget.topics) {
                            _index++;
                            if (topic['topic'].toString() == newValue) {
                              break;
                            }
                          }
                          _selectedItem.value =
                              widget.topics[_index - 1]["topic"] as String;
                          _subTitle =
                              widget.topics[_index - 1]["subTitle"] as String;

                          setInnerState(() {
                            _selectedItem.value = newValue!;
                          });
                        },
                        dropdownColor: const Color.fromARGB(255, 253, 188, 103),
                        alignment: Alignment.topLeft,
                        elevation: 20,
                        value: _selectedItem.value,
                        items: widget.topics.map((item) {
                          return DropdownMenuItem<String>(
                              value: item['topic'] as String,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      item['icon'] as IconData,
                                      size: 30,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(item['topic'] as String,
                                        style: const TextStyle(
                                            fontFamily: "Railway",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black)),
                                  ]));
                        }).toList())
                    : Container()
              ]);
        })),
      ),
      ValueListenableBuilder<String>(
          valueListenable: _selectedItem,
          builder: (BuildContext context, String value, Widget? child) {
            int index = 0;
            for (Map<String, Object> topic in widget.topics) {
              index++;
              if (topic['topic'].toString() == value) {
                break;
              }
            }
            _subTitle = _processTitle(
                widget.topics[index - 1]['subTitle'] as String,
                widget.id,
                widget.name,
                _config);
            return widget.topics[index - 1]['widget'] as Widget;
          }),
    ]);
  }
}
