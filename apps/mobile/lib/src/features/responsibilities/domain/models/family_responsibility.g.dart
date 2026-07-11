// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_responsibility.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFamilyResponsibilityCollection on Isar {
  IsarCollection<FamilyResponsibility> get familyResponsibilitys =>
      this.collection();
}

const FamilyResponsibilitySchema = CollectionSchema(
  name: r'FamilyResponsibility',
  id: -352680409528909665,
  properties: {
    r'backupOwnerId': PropertySchema(
      id: 0,
      name: r'backupOwnerId',
      type: IsarType.string,
    ),
    r'category': PropertySchema(
      id: 1,
      name: r'category',
      type: IsarType.string,
      enumMap: _FamilyResponsibilitycategoryEnumValueMap,
    ),
    r'completionEvidenceUri': PropertySchema(
      id: 2,
      name: r'completionEvidenceUri',
      type: IsarType.string,
    ),
    r'confidenceScore': PropertySchema(
      id: 3,
      name: r'confidenceScore',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 4,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dueDate': PropertySchema(
      id: 5,
      name: r'dueDate',
      type: IsarType.dateTime,
    ),
    r'escalationDelayMinutes': PropertySchema(
      id: 6,
      name: r'escalationDelayMinutes',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 7,
      name: r'name',
      type: IsarType.string,
    ),
    r'primaryOwnerId': PropertySchema(
      id: 8,
      name: r'primaryOwnerId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.string,
      enumMap: _FamilyResponsibilitystatusEnumValueMap,
    ),
    r'updatedAt': PropertySchema(
      id: 10,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 11,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _familyResponsibilityEstimateSize,
  serialize: _familyResponsibilitySerialize,
  deserialize: _familyResponsibilityDeserialize,
  deserializeProp: _familyResponsibilityDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'primaryOwnerId': IndexSchema(
      id: 2116453967281224137,
      name: r'primaryOwnerId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'primaryOwnerId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'backupOwnerId': IndexSchema(
      id: -759554690872113687,
      name: r'backupOwnerId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'backupOwnerId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _familyResponsibilityGetId,
  getLinks: _familyResponsibilityGetLinks,
  attach: _familyResponsibilityAttach,
  version: '3.1.0+1',
);

int _familyResponsibilityEstimateSize(
  FamilyResponsibility object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.backupOwnerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.category.name.length * 3;
  {
    final value = object.completionEvidenceUri;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.primaryOwnerId.length * 3;
  bytesCount += 3 + object.status.name.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _familyResponsibilitySerialize(
  FamilyResponsibility object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.backupOwnerId);
  writer.writeString(offsets[1], object.category.name);
  writer.writeString(offsets[2], object.completionEvidenceUri);
  writer.writeLong(offsets[3], object.confidenceScore);
  writer.writeDateTime(offsets[4], object.createdAt);
  writer.writeDateTime(offsets[5], object.dueDate);
  writer.writeLong(offsets[6], object.escalationDelayMinutes);
  writer.writeString(offsets[7], object.name);
  writer.writeString(offsets[8], object.primaryOwnerId);
  writer.writeString(offsets[9], object.status.name);
  writer.writeDateTime(offsets[10], object.updatedAt);
  writer.writeString(offsets[11], object.uuid);
}

FamilyResponsibility _familyResponsibilityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FamilyResponsibility();
  object.backupOwnerId = reader.readStringOrNull(offsets[0]);
  object.category = _FamilyResponsibilitycategoryValueEnumMap[
          reader.readStringOrNull(offsets[1])] ??
      ResponsibilityCategory.health;
  object.completionEvidenceUri = reader.readStringOrNull(offsets[2]);
  object.confidenceScore = reader.readLong(offsets[3]);
  object.createdAt = reader.readDateTime(offsets[4]);
  object.dueDate = reader.readDateTime(offsets[5]);
  object.escalationDelayMinutes = reader.readLong(offsets[6]);
  object.id = id;
  object.name = reader.readString(offsets[7]);
  object.primaryOwnerId = reader.readString(offsets[8]);
  object.status = _FamilyResponsibilitystatusValueEnumMap[
          reader.readStringOrNull(offsets[9])] ??
      ResponsibilityStatus.pending;
  object.updatedAt = reader.readDateTime(offsets[10]);
  object.uuid = reader.readString(offsets[11]);
  return object;
}

P _familyResponsibilityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (_FamilyResponsibilitycategoryValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ResponsibilityCategory.health) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (_FamilyResponsibilitystatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ResponsibilityStatus.pending) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _FamilyResponsibilitycategoryEnumValueMap = {
  r'health': r'health',
  r'finance': r'finance',
  r'household': r'household',
  r'event': r'event',
  r'documents': r'documents',
};
const _FamilyResponsibilitycategoryValueEnumMap = {
  r'health': ResponsibilityCategory.health,
  r'finance': ResponsibilityCategory.finance,
  r'household': ResponsibilityCategory.household,
  r'event': ResponsibilityCategory.event,
  r'documents': ResponsibilityCategory.documents,
};
const _FamilyResponsibilitystatusEnumValueMap = {
  r'pending': r'pending',
  r'dueSoon': r'dueSoon',
  r'escalated': r'escalated',
  r'completed': r'completed',
  r'verified': r'verified',
  r'skipped': r'skipped',
};
const _FamilyResponsibilitystatusValueEnumMap = {
  r'pending': ResponsibilityStatus.pending,
  r'dueSoon': ResponsibilityStatus.dueSoon,
  r'escalated': ResponsibilityStatus.escalated,
  r'completed': ResponsibilityStatus.completed,
  r'verified': ResponsibilityStatus.verified,
  r'skipped': ResponsibilityStatus.skipped,
};

Id _familyResponsibilityGetId(FamilyResponsibility object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _familyResponsibilityGetLinks(
    FamilyResponsibility object) {
  return [];
}

void _familyResponsibilityAttach(
    IsarCollection<dynamic> col, Id id, FamilyResponsibility object) {
  object.id = id;
}

extension FamilyResponsibilityByIndex on IsarCollection<FamilyResponsibility> {
  Future<FamilyResponsibility?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  FamilyResponsibility? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<FamilyResponsibility?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<FamilyResponsibility?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(FamilyResponsibility object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(FamilyResponsibility object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<FamilyResponsibility> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<FamilyResponsibility> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension FamilyResponsibilityQueryWhereSort
    on QueryBuilder<FamilyResponsibility, FamilyResponsibility, QWhere> {
  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FamilyResponsibilityQueryWhere
    on QueryBuilder<FamilyResponsibility, FamilyResponsibility, QWhereClause> {
  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      primaryOwnerIdEqualTo(String primaryOwnerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'primaryOwnerId',
        value: [primaryOwnerId],
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      primaryOwnerIdNotEqualTo(String primaryOwnerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryOwnerId',
              lower: [],
              upper: [primaryOwnerId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryOwnerId',
              lower: [primaryOwnerId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryOwnerId',
              lower: [primaryOwnerId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'primaryOwnerId',
              lower: [],
              upper: [primaryOwnerId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      backupOwnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'backupOwnerId',
        value: [null],
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      backupOwnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'backupOwnerId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      backupOwnerIdEqualTo(String? backupOwnerId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'backupOwnerId',
        value: [backupOwnerId],
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterWhereClause>
      backupOwnerIdNotEqualTo(String? backupOwnerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'backupOwnerId',
              lower: [],
              upper: [backupOwnerId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'backupOwnerId',
              lower: [backupOwnerId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'backupOwnerId',
              lower: [backupOwnerId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'backupOwnerId',
              lower: [],
              upper: [backupOwnerId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension FamilyResponsibilityQueryFilter on QueryBuilder<FamilyResponsibility,
    FamilyResponsibility, QFilterCondition> {
  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'backupOwnerId',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'backupOwnerId',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backupOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'backupOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'backupOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'backupOwnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'backupOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'backupOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      backupOwnerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'backupOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      backupOwnerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'backupOwnerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'backupOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> backupOwnerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'backupOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryEqualTo(
    ResponsibilityCategory value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryGreaterThan(
    ResponsibilityCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryLessThan(
    ResponsibilityCategory value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryBetween(
    ResponsibilityCategory lower,
    ResponsibilityCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      categoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'category',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      categoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'category',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'category',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completionEvidenceUri',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completionEvidenceUri',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completionEvidenceUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completionEvidenceUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completionEvidenceUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completionEvidenceUri',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'completionEvidenceUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'completionEvidenceUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      completionEvidenceUriContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'completionEvidenceUri',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      completionEvidenceUriMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'completionEvidenceUri',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completionEvidenceUri',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> completionEvidenceUriIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'completionEvidenceUri',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> confidenceScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'confidenceScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> confidenceScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'confidenceScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> confidenceScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'confidenceScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> confidenceScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'confidenceScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> dueDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> dueDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> dueDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dueDate',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> dueDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dueDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> escalationDelayMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'escalationDelayMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> escalationDelayMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'escalationDelayMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> escalationDelayMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'escalationDelayMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> escalationDelayMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'escalationDelayMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'primaryOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'primaryOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'primaryOwnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'primaryOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'primaryOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      primaryOwnerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'primaryOwnerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      primaryOwnerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'primaryOwnerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'primaryOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> primaryOwnerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'primaryOwnerId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusEqualTo(
    ResponsibilityStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusGreaterThan(
    ResponsibilityStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusLessThan(
    ResponsibilityStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusBetween(
    ResponsibilityStatus lower,
    ResponsibilityStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
          QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension FamilyResponsibilityQueryObject on QueryBuilder<FamilyResponsibility,
    FamilyResponsibility, QFilterCondition> {}

extension FamilyResponsibilityQueryLinks on QueryBuilder<FamilyResponsibility,
    FamilyResponsibility, QFilterCondition> {}

extension FamilyResponsibilityQuerySortBy
    on QueryBuilder<FamilyResponsibility, FamilyResponsibility, QSortBy> {
  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByBackupOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupOwnerId', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByBackupOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupOwnerId', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByCompletionEvidenceUri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionEvidenceUri', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByCompletionEvidenceUriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionEvidenceUri', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByEscalationDelayMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escalationDelayMinutes', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByEscalationDelayMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escalationDelayMinutes', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByPrimaryOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryOwnerId', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByPrimaryOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryOwnerId', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension FamilyResponsibilityQuerySortThenBy
    on QueryBuilder<FamilyResponsibility, FamilyResponsibility, QSortThenBy> {
  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByBackupOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupOwnerId', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByBackupOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'backupOwnerId', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByCompletionEvidenceUri() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionEvidenceUri', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByCompletionEvidenceUriDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionEvidenceUri', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByConfidenceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'confidenceScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByDueDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dueDate', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByEscalationDelayMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escalationDelayMinutes', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByEscalationDelayMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'escalationDelayMinutes', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByPrimaryOwnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryOwnerId', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByPrimaryOwnerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'primaryOwnerId', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension FamilyResponsibilityQueryWhereDistinct
    on QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct> {
  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByBackupOwnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'backupOwnerId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByCompletionEvidenceUri({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completionEvidenceUri',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByConfidenceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'confidenceScore');
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByDueDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dueDate');
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByEscalationDelayMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'escalationDelayMinutes');
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByPrimaryOwnerId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'primaryOwnerId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<FamilyResponsibility, FamilyResponsibility, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension FamilyResponsibilityQueryProperty on QueryBuilder<
    FamilyResponsibility, FamilyResponsibility, QQueryProperty> {
  QueryBuilder<FamilyResponsibility, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FamilyResponsibility, String?, QQueryOperations>
      backupOwnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'backupOwnerId');
    });
  }

  QueryBuilder<FamilyResponsibility, ResponsibilityCategory, QQueryOperations>
      categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<FamilyResponsibility, String?, QQueryOperations>
      completionEvidenceUriProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completionEvidenceUri');
    });
  }

  QueryBuilder<FamilyResponsibility, int, QQueryOperations>
      confidenceScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'confidenceScore');
    });
  }

  QueryBuilder<FamilyResponsibility, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<FamilyResponsibility, DateTime, QQueryOperations>
      dueDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dueDate');
    });
  }

  QueryBuilder<FamilyResponsibility, int, QQueryOperations>
      escalationDelayMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'escalationDelayMinutes');
    });
  }

  QueryBuilder<FamilyResponsibility, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<FamilyResponsibility, String, QQueryOperations>
      primaryOwnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'primaryOwnerId');
    });
  }

  QueryBuilder<FamilyResponsibility, ResponsibilityStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<FamilyResponsibility, DateTime, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<FamilyResponsibility, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
