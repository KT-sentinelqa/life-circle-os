/// LifeCircle OS — UserLocalModel: local SQLite persistence model.
///
/// This is NOT a domain entity. It is a data-layer transfer object
/// that maps to the [users_local] SQLite table.
///
/// Conversion to/from domain entities happens in the repository layer.
///
/// Governed by: docs/mobile-architecture.md | docs/coding-standards.md
library;

import 'package:equatable/equatable.dart';

/// Persistence model for a locally-cached user record.
class UserLocalModel extends Equatable {
  const UserLocalModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.role,
    required this.createdAt,
    this.jwtToken,
    this.isVerified = false,
    this.syncedAt,
  });

  final String id;
  final String email;
  final String fullName;
  final String role;
  final String? jwtToken;
  final bool isVerified;
  final int? syncedAt;     // Unix timestamp ms, null if never synced
  final int createdAt;     // Unix timestamp ms

  // ── SQLite Serialisation ───────────────────────────────────────────────────

  /// Convert to a map for SQLite insertion.
  Map<String, Object?> toMap() => {
        'id':          id,
        'email':       email,
        'full_name':   fullName,
        'role':        role,
        'jwt_token':   jwtToken,
        'is_verified': isVerified ? 1 : 0,
        'synced_at':   syncedAt,
        'created_at':  createdAt,
      };

  /// Construct from a SQLite row map.
  factory UserLocalModel.fromMap(Map<String, Object?> map) => UserLocalModel(
        id:         map['id']          as String,
        email:      map['email']       as String,
        fullName:   map['full_name']   as String,
        role:       map['role']        as String,
        jwtToken:   map['jwt_token']   as String?,
        isVerified: (map['is_verified'] as int? ?? 0) == 1,
        syncedAt:   map['synced_at']   as int?,
        createdAt:  map['created_at']  as int,
      );

  /// Return a copy with updated fields.
  UserLocalModel copyWith({
    String? jwtToken,
    bool? isVerified,
    int? syncedAt,
  }) =>
      UserLocalModel(
        id:         id,
        email:      email,
        fullName:   fullName,
        role:       role,
        jwtToken:   jwtToken   ?? this.jwtToken,
        isVerified: isVerified ?? this.isVerified,
        syncedAt:   syncedAt   ?? this.syncedAt,
        createdAt:  createdAt,
      );

  @override
  List<Object?> get props => [id, email, fullName, role, isVerified, syncedAt];
}
