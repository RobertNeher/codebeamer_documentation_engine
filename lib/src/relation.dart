import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:codebeamer_documentation_engine/config/configuration.dart';
import 'package:codebeamer_documentation_engine/utils/utils.dart';

Future<List<Relation>> fetchRelations(int workItemID) async {
  List<Relation> data = <Relation>[];

  Configuration config = Configuration();

  http.Response response = await http.get(
      Uri.https(config.baseURLs['homeServer']!,
          '/api/v3/items/$workItemID/relations'),
      headers: httpHeader());

  if (response.statusCode == 200) {
    List jsonRaw = jsonDecode(response.body);
    data = jsonRaw.map((item) => Relation.fromJson(item)).toList();
    return data;
  } else {
    print("Error fetching relations: ${response.statusCode}");
    return [];
  }
}

class Relation {
  ItemId? itemId;
  List<DownstreamReferences>? downstreamReferences;
  List<UpstreamReferences>? upstreamReferences;
  List<IncomingAssociations>? incomingAssociations;
  List<OutgoingAssociations>? outgoingAssociations;

  Relation(
      {this.itemId,
      this.downstreamReferences,
      this.upstreamReferences,
      this.incomingAssociations,
      this.outgoingAssociations});

  Relation.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'] != null ? ItemId.fromJson(json['itemId']) : null;
    if (json['downstreamReferences'] != null) {
      downstreamReferences = <DownstreamReferences>[];
      json['downstreamReferences'].forEach((v) {
        downstreamReferences!.add(DownstreamReferences.fromJson(v));
      });
    }
    if (json['upstreamReferences'] != null) {
      upstreamReferences = <UpstreamReferences>[];
      json['upstreamReferences'].forEach((v) {
        upstreamReferences!.add(UpstreamReferences.fromJson(v));
      });
    }
    if (json['incomingAssociations'] != null) {
      incomingAssociations = <IncomingAssociations>[];
      json['incomingAssociations'].forEach((v) {
        incomingAssociations!.add(IncomingAssociations.fromJson(v));
      });
    }
    if (json['outgoingAssociations'] != null) {
      outgoingAssociations = <OutgoingAssociations>[];
      json['outgoingAssociations'].forEach((v) {
        outgoingAssociations!.add(OutgoingAssociations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (itemId != null) {
      data['itemId'] = itemId!.toJson();
    }
    if (downstreamReferences != null) {
      data['downstreamReferences'] =
          downstreamReferences!.map((v) => v.toJson()).toList();
    }
    if (upstreamReferences != null) {
      data['upstreamReferences'] =
          upstreamReferences!.map((v) => v.toJson()).toList();
    }
    if (incomingAssociations != null) {
      data['incomingAssociations'] =
          incomingAssociations!.map((v) => v.toJson()).toList();
    }
    if (outgoingAssociations != null) {
      data['outgoingAssociations'] =
          outgoingAssociations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemId {
  int? id;
  int? version;

  ItemId({this.id, this.version});

  ItemId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['version'] = version;
    return data;
  }
}

class DownstreamReferences {
  int? id;
  ItemId? itemRevision;
  String? type;

  DownstreamReferences({this.id, this.itemRevision, this.type});

  DownstreamReferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemRevision = json['itemRevision'] != null
        ? ItemId.fromJson(json['itemRevision'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (itemRevision != null) {
      data['itemRevision'] = itemRevision!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class UpstreamReferences {
  int? id;
  ItemId? itemRevision;
  String? type;

  UpstreamReferences({this.id, this.itemRevision, this.type});

  UpstreamReferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemRevision = json['itemRevision'] != null
        ? ItemId.fromJson(json['itemRevision'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (itemRevision != null) {
      data['itemRevision'] = itemRevision!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class IncomingAssociations {
  int? id;
  ItemId? itemRevision;
  String? type;

  IncomingAssociations({this.id, this.itemRevision, this.type});

  IncomingAssociations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemRevision = json['itemRevision'] != null
        ? ItemId.fromJson(json['itemRevision'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (itemRevision != null) {
      data['itemRevision'] = itemRevision!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class OutgoingAssociations {
  int? id;
  ItemId? itemRevision;
  String? type;

  OutgoingAssociations({this.id, this.itemRevision, this.type});

  OutgoingAssociations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemRevision = json['itemRevision'] != null
        ? ItemId.fromJson(json['itemRevision'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (itemRevision != null) {
      data['itemRevision'] = itemRevision!.toJson();
    }
    data['type'] = type;
    return data;
  }
}
