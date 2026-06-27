/// LifeCircle OS — FamilyLocalModel: local SQLite persistence model.
library;

import 'package:equatable/equatable.dart';

/// Persistence model for a locally-cached family record.
class FamilyLocalModel extends Equatable {
  const FamilyLocalModel({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    this.syncedAt,
  });

  final String id;
  final String name;
  final String ownerId;
  final int? syncedAt;    // Unix timestamp ms
  final int createdAt;    // Unix timestamp ms

  Map<String, Object?> toMap() => {
        'id':         id,
        'name':       name,
        'owner_id':   ownerId,
        'synced_at':  syncedAt,
        'created_at': createdAt,
      };

  factory FamilyLocalModel.fromMap(Map<String, Object?> map) => FamilyLocalModel(
        id:        map['id']         as String,
        name:      map['name']       as String,
        ownerId:   map['owner_id']   as String,
        syncedAt:  map['synced_at']  as int?,
        createdAt: map['created_at'] as int,
      );

  FamilyLocalModel copyWith({int? syncedAt}) => FamilyLocalModel(
        id:        id,
        name:      name,
        ownerId:   ownerId,
        syncedAt:  syncedAt ?? this.syncedAt,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [id, name, ownerId, syncedAt];
}
