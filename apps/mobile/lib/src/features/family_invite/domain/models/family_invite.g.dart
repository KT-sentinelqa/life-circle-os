// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_invite.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFamilyInviteCollection on Isar {
  IsarCollection<FamilyInvite> get familyInvites => this.collection();
}

const FamilyInviteSchema = CollectionSchema(
  name: r'FamilyInvite',
  id: -3072075320780982065,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'expiresAt': PropertySchema(
      id: 1,
      name: r'expiresAt',
      type: IsarType.dateTime,
    ),
    r'householdId': PropertySchema(
      id: 2,
      name: r'householdId',
      type: IsarType.string,
    ),
    r'inviteCode': PropertySchema(
      id: 3,
      name: r'inviteCode',
      type: IsarType.string,
    ),
    r'isAccepted': PropertySchema(
      id: 4,
      name: r'isAccepted',
      type: IsarType.bool,
    ),
    r'proposedRole': PropertySchema(
      id: 5,
      name: r'proposedRole',
      type: IsarType.string,
    )
  },
  estimateSize: _familyInviteEstimateSize,
  serialize: _familyInviteSerialize,
  deserialize: _familyInviteDeserialize,
  deserializeProp: _familyInviteDeserializeProp,
  idName: r'id',
  indexes: {
    r'inviteCode': IndexSchema(
      id: 1149539950050509013,
      name: r'inviteCode',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'inviteCode',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _familyInviteGetId,
  getLinks: _familyInviteGetLinks,
  attach: _familyInviteAttach,
  version: '3.1.0+1',
);

int _familyInviteEstimateSize(
  FamilyInvite object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.householdId.length * 3;
  bytesCount += 3 + object.inviteCode.length * 3;
  bytesCount += 3 + object.proposedRole.length * 3;
  return bytesCount;
}

void _familyInviteSerialize(
  FamilyInvite object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeDateTime(offsets[1], object.expiresAt);
  writer.writeString(offsets[2], object.householdId);
  writer.writeString(offsets[3], object.inviteCode);
  writer.writeBool(offsets[4], object.isAccepted);
  writer.writeString(offsets[5], object.proposedRole);
}

FamilyInvite _familyInviteDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FamilyInvite();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.expiresAt = reader.readDateTime(offsets[1]);
  object.householdId = reader.readString(offsets[2]);
  object.id = id;
  object.inviteCode = reader.readString(offsets[3]);
  object.isAccepted = reader.readBool(offsets[4]);
  object.proposedRole = reader.readString(offsets[5]);
  return object;
}

P _familyInviteDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _familyInviteGetId(FamilyInvite object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _familyInviteGetLinks(FamilyInvite object) {
  return [];
}

void _familyInviteAttach(
    IsarCollection<dynamic> col, Id id, FamilyInvite object) {
  object.id = id;
}

extension FamilyInviteByIndex on IsarCollection<FamilyInvite> {
  Future<FamilyInvite?> getByInviteCode(String inviteCode) {
    return getByIndex(r'inviteCode', [inviteCode]);
  }

  FamilyInvite? getByInviteCodeSync(String inviteCode) {
    return getByIndexSync(r'inviteCode', [inviteCode]);
  }

  Future<bool> deleteByInviteCode(String inviteCode) {
    return deleteByIndex(r'inviteCode', [inviteCode]);
  }

  bool deleteByInviteCodeSync(String inviteCode) {
    return deleteByIndexSync(r'inviteCode', [inviteCode]);
  }

  Future<List<FamilyInvite?>> getAllByInviteCode(
      List<String> inviteCodeValues) {
    final values = inviteCodeValues.map((e) => [e]).toList();
    return getAllByIndex(r'inviteCode', values);
  }

  List<FamilyInvite?> getAllByInviteCodeSync(List<String> inviteCodeValues) {
    final values = inviteCodeValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'inviteCode', values);
  }

  Future<int> deleteAllByInviteCode(List<String> inviteCodeValues) {
    final values = inviteCodeValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'inviteCode', values);
  }

  int deleteAllByInviteCodeSync(List<String> inviteCodeValues) {
    final values = inviteCodeValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'inviteCode', values);
  }

  Future<Id> putByInviteCode(FamilyInvite object) {
    return putByIndex(r'inviteCode', object);
  }

  Id putByInviteCodeSync(FamilyInvite object, {bool saveLinks = true}) {
    return putByIndexSync(r'inviteCode', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByInviteCode(List<FamilyInvite> objects) {
    return putAllByIndex(r'inviteCode', objects);
  }

  List<Id> putAllByInviteCodeSync(List<FamilyInvite> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'inviteCode', objects, saveLinks: saveLinks);
  }
}

extension FamilyInviteQueryWhereSort
    on QueryBuilder<FamilyInvite, FamilyInvite, QWhere> {
  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FamilyInviteQueryWhere
    on QueryBuilder<FamilyInvite, FamilyInvite, QWhereClause> {
  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhereClause> inviteCodeEqualTo(
      String inviteCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'inviteCode',
        value: [inviteCode],
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterWhereClause>
      inviteCodeNotEqualTo(String inviteCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inviteCode',
              lower: [],
              upper: [inviteCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inviteCode',
              lower: [inviteCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inviteCode',
              lower: [inviteCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'inviteCode',
              lower: [],
              upper: [inviteCode],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FamilyInviteQueryFilter
    on QueryBuilder<FamilyInvite, FamilyInvite, QFilterCondition> {
  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      expiresAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      expiresAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      expiresAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expiresAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      expiresAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expiresAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'householdId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'householdId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      householdIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inviteCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inviteCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inviteCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inviteCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'inviteCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'inviteCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'inviteCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'inviteCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inviteCode',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      inviteCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'inviteCode',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      isAcceptedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAccepted',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposedRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proposedRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proposedRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proposedRole',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'proposedRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'proposedRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'proposedRole',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'proposedRole',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proposedRole',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterFilterCondition>
      proposedRoleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'proposedRole',
        value: '',
      ));
    });
  }
}

extension FamilyInviteQueryObject
    on QueryBuilder<FamilyInvite, FamilyInvite, QFilterCondition> {}

extension FamilyInviteQueryLinks
    on QueryBuilder<FamilyInvite, FamilyInvite, QFilterCondition> {}

extension FamilyInviteQuerySortBy
    on QueryBuilder<FamilyInvite, FamilyInvite, QSortBy> {
  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      sortByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByInviteCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteCode', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      sortByInviteCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteCode', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByIsAccepted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccepted', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      sortByIsAcceptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccepted', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> sortByProposedRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedRole', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      sortByProposedRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedRole', Sort.desc);
    });
  }
}

extension FamilyInviteQuerySortThenBy
    on QueryBuilder<FamilyInvite, FamilyInvite, QSortThenBy> {
  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByExpiresAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expiresAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      thenByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByInviteCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteCode', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      thenByInviteCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inviteCode', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByIsAccepted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccepted', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      thenByIsAcceptedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAccepted', Sort.desc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy> thenByProposedRole() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedRole', Sort.asc);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QAfterSortBy>
      thenByProposedRoleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proposedRole', Sort.desc);
    });
  }
}

extension FamilyInviteQueryWhereDistinct
    on QueryBuilder<FamilyInvite, FamilyInvite, QDistinct> {
  QueryBuilder<FamilyInvite, FamilyInvite, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QDistinct> distinctByExpiresAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expiresAt');
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QDistinct> distinctByHouseholdId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'householdId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QDistinct> distinctByInviteCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inviteCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QDistinct> distinctByIsAccepted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAccepted');
    });
  }

  QueryBuilder<FamilyInvite, FamilyInvite, QDistinct> distinctByProposedRole(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proposedRole', caseSensitive: caseSensitive);
    });
  }
}

extension FamilyInviteQueryProperty
    on QueryBuilder<FamilyInvite, FamilyInvite, QQueryProperty> {
  QueryBuilder<FamilyInvite, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FamilyInvite, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FamilyInvite, DateTime, QQueryOperations> expiresAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expiresAt');
    });
  }

  QueryBuilder<FamilyInvite, String, QQueryOperations> householdIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'householdId');
    });
  }

  QueryBuilder<FamilyInvite, String, QQueryOperations> inviteCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inviteCode');
    });
  }

  QueryBuilder<FamilyInvite, bool, QQueryOperations> isAcceptedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAccepted');
    });
  }

  QueryBuilder<FamilyInvite, String, QQueryOperations> proposedRoleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proposedRole');
    });
  }
}
