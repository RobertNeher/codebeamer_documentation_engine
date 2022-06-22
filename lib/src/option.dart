import 'schema.dart';

List<Option> fetchOptions(Schema field) {
  List<Option> data = <Option>[];

  for (var option in field.options!) {
    data.add(Option(id: option.id!, name: option.name!));
  }
  return data;
}

class Option {
  int id;
  String name;

  Option({this.id = 0, this.name = ''});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(id: json['id'], name: json['name']);
  }

  @override
  String toString() {
    return '$id: $name';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
