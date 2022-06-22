import 'package:flutter/material.dart';
import 'package:codebeamer_documentation_engine/config/configuration.dart';

class ShowData extends StatefulWidget {
  ShowData(
      {Key? key, required this.topics, required this.title, required this.T})
      : super(key: key);
  String title;
  List<Map<String, Object>> topics;
  Type T;

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  late Configuration _config;
  late ValueNotifier<String> _selectedTopic;
  String? _subTitle = '';
  int _index = 0;

  @override
  void initState() {
    _index = 0;
    _config = Configuration();
    _selectedTopic = ValueNotifier<String>(widget.topics[0]['topic'] as String);
    _subTitle = widget.title;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: const Color.fromARGB(210, 255, 207, 136),
            child: StatefulBuilder(
                builder: ((BuildContext context, StateSetter setInnerState) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(_subTitle!,
                        style: const TextStyle(
                          fontFamily: "Railway",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.blueGrey,
                        )),
                    // const SizedBox(width: 50),
                    DropdownButton<String>(
                        onChanged: (String? newValue) {
                          _index = 0;
                          for (Map<String, Object> topic in widget.topics) {
                            _index++;
                            if (topic['topic'].toString() == newValue) {
                              break;
                            }
                          }
                          _selectedTopic.value =
                              widget.topics[_index - 1]["topic"] as String;
                          _subTitle =
                              widget.topics[_index - 1]["subTitle"] as String;

                          setInnerState(() {
                            _selectedTopic.value = newValue!;
                          });
                        },
                        dropdownColor: Colors.orangeAccent,
                        alignment: Alignment.topLeft,
                        elevation: 20,
                        value: _selectedTopic.value,
                        items: _config.homeTopics.map((topic) {
                          return DropdownMenuItem<String>(
                              value: topic['topic'] as String,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(topic['icon'] as IconData, size: 20),
                                    const SizedBox(width: 10),
                                    Text(topic['topic'] as String,
                                        style: const TextStyle(
                                            fontFamily: "Railway",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.black))
                                  ]));
                        }).toList())
                  ]);
            })),
          ),
          ValueListenableBuilder<String>(
              valueListenable: _selectedTopic,
              builder: (BuildContext context, String value, Widget? child) {
                int index = 0;
                for (Map<String, Object> topic in widget.topics) {
                  index++;
                  if (topic['topic'].toString() == value) {
                    break;
                  }
                }
                _subTitle = widget.topics[index - 1]['subTitle'] as String;
                return widget.topics[index - 1]['widget'] as Widget;
              }),
        ]);
  }
}
