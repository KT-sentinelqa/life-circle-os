// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family_peace_index.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetFamilyPeaceIndexCollection on Isar {
  IsarCollection<FamilyPeaceIndex> get familyPeaceIndexs => this.collection();
}

const FamilyPeaceIndexSchema = CollectionSchema(
  name: r'FamilyPeaceIndex',
  id: 2849465099088799530,
  properties: {
    r'financeScore': PropertySchema(
      id: 0,
      name: r'financeScore',
      type: IsarType.long,
    ),
    r'healthScore': PropertySchema(
      id: 1,
      name: r'healthScore',
      type: IsarType.long,
    ),
    r'householdId': PropertySchema(
      id: 2,
      name: r'householdId',
      type: IsarType.string,
    ),
    r'householdScore': PropertySchema(
      id: 3,
      name: r'householdScore',
      type: IsarType.long,
    ),
    r'lastCalculatedAt': PropertySchema(
      id: 4,
      name: r'lastCalculatedAt',
      type: IsarType.dateTime,
    ),
    r'overallScore': PropertySchema(
      id: 5,
      name: r'overallScore',
      type: IsarType.long,
    )
  },
  estimateSize: _familyPeaceIndexEstimateSize,
  serialize: _familyPeaceIndexSerialize,
  deserialize: _familyPeaceIndexDeserialize,
  deserializeProp: _familyPeaceIndexDeserializeProp,
  idName: r'id',
  indexes: {
    r'householdId': IndexSchema(
      id: 8941485815717012049,
      name: r'householdId',
      unique: true,
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
  getId: _familyPeaceIndexGetId,
  getLinks: _familyPeaceIndexGetLinks,
  attach: _familyPeaceIndexAttach,
  version: '3.1.0+1',
);

int _familyPeaceIndexEstimateSize(
  FamilyPeaceIndex object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.householdId.length * 3;
  return bytesCount;
}

void _familyPeaceIndexSerialize(
  FamilyPeaceIndex object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.financeScore);
  writer.writeLong(offsets[1], object.healthScore);
  writer.writeString(offsets[2], object.householdId);
  writer.writeLong(offsets[3], object.householdScore);
  writer.writeDateTime(offsets[4], object.lastCalculatedAt);
  writer.writeLong(offsets[5], object.overallScore);
}

FamilyPeaceIndex _familyPeaceIndexDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = FamilyPeaceIndex();
  object.financeScore = reader.readLong(offsets[0]);
  object.healthScore = reader.readLong(offsets[1]);
  object.householdId = reader.readString(offsets[2]);
  object.householdScore = reader.readLong(offsets[3]);
  object.id = id;
  object.lastCalculatedAt = reader.readDateTime(offsets[4]);
  object.overallScore = reader.readLong(offsets[5]);
  return object;
}

P _familyPeaceIndexDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _familyPeaceIndexGetId(FamilyPeaceIndex object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _familyPeaceIndexGetLinks(FamilyPeaceIndex object) {
  return [];
}

void _familyPeaceIndexAttach(
    IsarCollection<dynamic> col, Id id, FamilyPeaceIndex object) {
  object.id = id;
}

extension FamilyPeaceIndexByIndex on IsarCollection<FamilyPeaceIndex> {
  Future<FamilyPeaceIndex?> getByHouseholdId(String householdId) {
    return getByIndex(r'householdId', [householdId]);
  }

  FamilyPeaceIndex? getByHouseholdIdSync(String householdId) {
    return getByIndexSync(r'householdId', [householdId]);
  }

  Future<bool> deleteByHouseholdId(String householdId) {
    return deleteByIndex(r'householdId', [householdId]);
  }

  bool deleteByHouseholdIdSync(String householdId) {
    return deleteByIndexSync(r'householdId', [householdId]);
  }

  Future<List<FamilyPeaceIndex?>> getAllByHouseholdId(
      List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'householdId', values);
  }

  List<FamilyPeaceIndex?> getAllByHouseholdIdSync(
      List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'householdId', values);
  }

  Future<int> deleteAllByHouseholdId(List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'householdId', values);
  }

  int deleteAllByHouseholdIdSync(List<String> householdIdValues) {
    final values = householdIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'householdId', values);
  }

  Future<Id> putByHouseholdId(FamilyPeaceIndex object) {
    return putByIndex(r'householdId', object);
  }

  Id putByHouseholdIdSync(FamilyPeaceIndex object, {bool saveLinks = true}) {
    return putByIndexSync(r'householdId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByHouseholdId(List<FamilyPeaceIndex> objects) {
    return putAllByIndex(r'householdId', objects);
  }

  List<Id> putAllByHouseholdIdSync(List<FamilyPeaceIndex> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'householdId', objects, saveLinks: saveLinks);
  }
}

extension FamilyPeaceIndexQueryWhereSort
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QWhere> {
  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension FamilyPeaceIndexQueryWhere
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QWhereClause> {
  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhereClause>
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhereClause> idBetween(
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhereClause>
      householdIdEqualTo(String householdId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'householdId',
        value: [householdId],
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterWhereClause>
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

extension FamilyPeaceIndexQueryFilter
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QFilterCondition> {
  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      financeScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'financeScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      financeScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'financeScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      financeScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'financeScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      financeScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'financeScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      healthScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'healthScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      healthScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'healthScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      healthScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'healthScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      healthScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'healthScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'householdId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'householdId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'householdId',
        value: '',
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'householdScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'householdScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'householdScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      householdScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'householdScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      lastCalculatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastCalculatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      lastCalculatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastCalculatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      lastCalculatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastCalculatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      lastCalculatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastCalculatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      overallScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overallScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      overallScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overallScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      overallScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overallScore',
        value: value,
      ));
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterFilterCondition>
      overallScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overallScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension FamilyPeaceIndexQueryObject
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QFilterCondition> {}

extension FamilyPeaceIndexQueryLinks
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QFilterCondition> {}

extension FamilyPeaceIndexQuerySortBy
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QSortBy> {
  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByFinanceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financeScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByFinanceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financeScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByHealthScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByHealthScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByHouseholdScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByHouseholdScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByLastCalculatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCalculatedAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByLastCalculatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCalculatedAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByOverallScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      sortByOverallScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallScore', Sort.desc);
    });
  }
}

extension FamilyPeaceIndexQuerySortThenBy
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QSortThenBy> {
  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByFinanceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financeScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByFinanceScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'financeScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByHealthScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByHealthScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'healthScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByHouseholdId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByHouseholdIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdId', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByHouseholdScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByHouseholdScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'householdScore', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByLastCalculatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCalculatedAt', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByLastCalculatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastCalculatedAt', Sort.desc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByOverallScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallScore', Sort.asc);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QAfterSortBy>
      thenByOverallScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overallScore', Sort.desc);
    });
  }
}

extension FamilyPeaceIndexQueryWhereDistinct
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QDistinct> {
  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QDistinct>
      distinctByFinanceScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'financeScore');
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QDistinct>
      distinctByHealthScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'healthScore');
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QDistinct>
      distinctByHouseholdId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'householdId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QDistinct>
      distinctByHouseholdScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'householdScore');
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QDistinct>
      distinctByLastCalculatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastCalculatedAt');
    });
  }

  QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QDistinct>
      distinctByOverallScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overallScore');
    });
  }
}

extension FamilyPeaceIndexQueryProperty
    on QueryBuilder<FamilyPeaceIndex, FamilyPeaceIndex, QQueryProperty> {
  QueryBuilder<FamilyPeaceIndex, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<FamilyPeaceIndex, int, QQueryOperations> financeScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'financeScore');
    });
  }

  QueryBuilder<FamilyPeaceIndex, int, QQueryOperations> healthScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'healthScore');
    });
  }

  QueryBuilder<FamilyPeaceIndex, String, QQueryOperations>
      householdIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'householdId');
    });
  }

  QueryBuilder<FamilyPeaceIndex, int, QQueryOperations>
      householdScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'householdScore');
    });
  }

  QueryBuilder<FamilyPeaceIndex, DateTime, QQueryOperations>
      lastCalculatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastCalculatedAt');
    });
  }

  QueryBuilder<FamilyPeaceIndex, int, QQueryOperations> overallScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overallScore');
    });
  }
}
