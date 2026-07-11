// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'peace_index_audit_entry.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPeaceIndexAuditEntryCollection on Isar {
  IsarCollection<PeaceIndexAuditEntry> get peaceIndexAuditEntrys =>
      this.collection();
}

const PeaceIndexAuditEntrySchema = CollectionSchema(
  name: r'PeaceIndexAuditEntry',
  id: -2701396558288221356,
  properties: {
    r'calculatedAt': PropertySchema(
      id: 0,
      name: r'calculatedAt',
      type: IsarType.dateTime,
    ),
    r'delta': PropertySchema(
      id: 1,
      name: r'delta',
      type: IsarType.long,
    ),
    r'householdId': PropertySchema(
      id: 2,
      name: r'householdId',
      type: IsarType.string,
    ),
    r'newScore': PropertySchema(
      id: 3,
      name: r'newScore',
      type: IsarType.long,
    ),
    r'previousScore': PropertySchema(
      id: 4,
      name: r'previousScore',
      type: IsarType.long,
    ),
    r'reason': PropertySchema(
      id: 5,
      name: r'reason',
      type: IsarType.string,
    ),
    r'triggeringCategory': PropertySchema(
      id: 6,
      name: r'triggeringCategory',
      type: IsarType.string,
    ),
    r'triggeringResponsibilityUuid': PropertySchema(
      id: 7,
      name: r'triggeringResponsibilityUuid',
      type: IsarType.string,
    )
  },
  estimateSize: _peaceIndexAuditEntryEstimateSize,
  serialize: _peaceIndexAuditEntrySerialize,
  deserialize: _peaceIndexAuditEntryDeserialize,
  deserializeProp: _peaceIndexAuditEntryDeserializeProp,
  idName: r'id',
  indexes: {
    r'householdId': IndexSchema(
      id: 8941485815717012049,
      name: r'householdId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'householdId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _peaceIndexAuditEntryGetId,
  getLinks: _peaceIndexAuditEntryGetLinks,
  attach: _peaceIndexAuditEntryAttach,
  version: '3.1.0+1',
);

int _peaceIndexAuditEntryEstimateSize(
  PeaceIndexAuditEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.householdId.length * 3;
  bytesCount += 3 + object.reason.length * 3;
  {
    final value = object.triggeringCategory;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.triggeringResponsibilityUuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _peaceIndexAuditEntrySerialize(
  PeaceIndexAuditEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.calculatedAt);
  writer.writeLong(offsets[1], object.delta);
  writer.writeString(offsets[2], object.householdId);
  writer.writeLong(offsets[3], object.newScore);
  writer.writeLong(offsets[4], object.previousScore);
  writer.writeString(offsets[5], object.reason);
  writer.writeString(offsets[6], object.triggeringCategory);
  writer.writeString(offsets[7], object.triggeringResponsibilityUuid);
}

PeaceIndexAuditEntry _peaceIndexAuditEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PeaceIndexAuditEntry();
  object.calculatedAt = reader.readDateTime(offsets[0]);
  object.delta = reader.readLong(offsets[1]);
  object.householdId = reader.readString(offsets[2]);
  object.id = id;
  object.newScore = reader.readLong(offsets[3]);
  object.previousScore = reader.readLong(offsets[4]);
  object.reason = reader.readString(offsets[5]);
  object.triggeringCategory = reader.readStringOrNull(offsets[6]);
  object.triggeringResponsibilityUuid = reader.readStringOrNull(offsets[7]);
  return object;
}

P _peaceIndexAuditEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _peaceIndexAuditEntryGetId(PeaceIndexAuditEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _peaceIndexAuditEntryGetLinks(
    PeaceIndexAuditEntry object) {
  return [];
}

void _peaceIndexAuditEntryAttach(
    IsarCollection<dynamic> col, Id id, PeaceIndexAuditEntry object) {
  object.id = id;
}

extension PeaceIndexAuditEntryQueryWhereSort
    on QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QWhere> {
  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PeaceIndexAuditEntryQueryWhere
    on QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QWhereClause> {
  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhereClause>
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhereClause>
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhereClause>
      householdIdEqualTo(String householdId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'householdId',
        value: [householdId],
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterWhereClause>
      householdIdNotEqualTo(String householdId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [],
              upper: [householdId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [householdId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [householdId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'householdId',
              lower: [],
              upper: [householdId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PeaceIndexAuditEntryQueryFilter on QueryBuilder<PeaceIndexAuditEntry,
    PeaceIndexAuditEntry, QFilterCondition> {
  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> calculatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'calculatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> calculatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'calculatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> calculatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'calculatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> calculatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'calculatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> deltaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'delta',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> deltaGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'delta',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> deltaLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'delta',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> deltaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'delta',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdEqualTo(
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdGreaterThan(
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdLessThan(
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdBetween(
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdStartsWith(
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdEndsWith(
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      householdIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      householdIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'householdId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> householdIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
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

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> newScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newScore',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> newScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newScore',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> newScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newScore',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> newScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> previousScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'previousScore',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> previousScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'previousScore',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> previousScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'previousScore',
        value: value,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> previousScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'previousScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reason',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      reasonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'reason',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      reasonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'reason',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> reasonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'reason',
        value: '',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'triggeringCategory',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'triggeringCategory',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggeringCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'triggeringCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'triggeringCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'triggeringCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'triggeringCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'triggeringCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      triggeringCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'triggeringCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      triggeringCategoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'triggeringCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggeringCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'triggeringCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'triggeringResponsibilityUuid',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'triggeringResponsibilityUuid',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggeringResponsibilityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'triggeringResponsibilityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'triggeringResponsibilityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'triggeringResponsibilityUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'triggeringResponsibilityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'triggeringResponsibilityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      triggeringResponsibilityUuidContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'triggeringResponsibilityUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
          QAfterFilterCondition>
      triggeringResponsibilityUuidMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'triggeringResponsibilityUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'triggeringResponsibilityUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry,
      QAfterFilterCondition> triggeringResponsibilityUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'triggeringResponsibilityUuid',
        value: '',
      ));
    });
  }
}

extension PeaceIndexAuditEntryQueryObject on QueryBuilder<PeaceIndexAuditEntry,
    PeaceIndexAuditEntry, QFilterCondition> {}

extension PeaceIndexAuditEntryQueryLinks on QueryBuilder<PeaceIndexAuditEntry,
    PeaceIndexAuditEntry, QFilterCondition> {}

extension PeaceIndexAuditEntryQuerySortBy
    on QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QSortBy> {
  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByCalculatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedAt', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByCalculatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedAt', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delta', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByDeltaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delta', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByNewScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newScore', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByNewScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newScore', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByPreviousScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByPreviousScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByTriggeringCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringCategory', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByTriggeringCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringCategory', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByTriggeringResponsibilityUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringResponsibilityUuid', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      sortByTriggeringResponsibilityUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringResponsibilityUuid', Sort.desc);
    });
  }
}

extension PeaceIndexAuditEntryQuerySortThenBy
    on QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QSortThenBy> {
  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByCalculatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedAt', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByCalculatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'calculatedAt', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delta', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByDeltaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'delta', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByNewScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newScore', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByNewScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newScore', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByPreviousScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByPreviousScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'previousScore', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByReason() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByReasonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reason', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByTriggeringCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringCategory', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByTriggeringCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringCategory', Sort.desc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByTriggeringResponsibilityUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringResponsibilityUuid', Sort.asc);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QAfterSortBy>
      thenByTriggeringResponsibilityUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'triggeringResponsibilityUuid', Sort.desc);
    });
  }
}

extension PeaceIndexAuditEntryQueryWhereDistinct
    on QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct> {
  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByCalculatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'calculatedAt');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByDelta() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'delta');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByHouseholdId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'householdId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByNewScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newScore');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByPreviousScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'previousScore');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByReason({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reason', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByTriggeringCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'triggeringCategory',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, PeaceIndexAuditEntry, QDistinct>
      distinctByTriggeringResponsibilityUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'triggeringResponsibilityUuid',
          caseSensitive: caseSensitive);
    });
  }
}

extension PeaceIndexAuditEntryQueryProperty on QueryBuilder<
    PeaceIndexAuditEntry, PeaceIndexAuditEntry, QQueryProperty> {
  QueryBuilder<PeaceIndexAuditEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, DateTime, QQueryOperations>
      calculatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'calculatedAt');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, int, QQueryOperations> deltaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'delta');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, String, QQueryOperations>
      householdIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'householdId');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, int, QQueryOperations> newScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newScore');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, int, QQueryOperations>
      previousScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'previousScore');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, String, QQueryOperations>
      reasonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reason');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, String?, QQueryOperations>
      triggeringCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'triggeringCategory');
    });
  }

  QueryBuilder<PeaceIndexAuditEntry, String?, QQueryOperations>
      triggeringResponsibilityUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'triggeringResponsibilityUuid');
    });
  }
}
