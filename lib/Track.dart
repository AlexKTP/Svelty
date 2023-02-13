import 'dart:core';

class TrackBuilder {
  int? id;
  late num weight;
  int? chest;
  int? abs;
  int? hip;
  int? bottom;
  int? leg;
}

class Track {
  final int? id;
  final num weight;
  final int? chest;
  final int? abs;
  final int? hip;
  final int? bottom;
  final int? leg;
  final DateTime createdAt;
  final bool toSynchronize;

  Track(TrackBuilder builder)
      : id = builder.id,
        weight = builder.weight,
        chest = builder.chest,
        abs = builder.abs,
        hip = builder.hip,
        bottom = builder.bottom,
        leg = builder.leg,
        createdAt = DateTime.now(),
        toSynchronize = true;

  Track.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        weight = data['weight'],
        chest = data['chest'],
        abs = data['abs'],
        hip = data['hip'],
        bottom = data['bottom'],
        leg = data['leg'],
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(data['created_at'] as int),
        toSynchronize = data['to_synchronize'] as int == 1;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weight': weight,
      'chest': chest,
      'abs': abs,
      'hip': hip,
      'bottom': bottom,
      'leg': leg,
      'created_at': createdAt,
      'to_synchronize': toSynchronize
    };
  }
}
