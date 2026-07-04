// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_dosage_schedule.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarDosageScheduleCollection on Isar {
  IsarCollection<IsarDosageSchedule> get isarDosageSchedules =>
      this.collection();
}

const IsarDosageScheduleSchema = CollectionSchema(
  name: r'IsarDosageSchedule',
  id: -2754896744770027692,
  properties: {
    r'createdAtUtc': PropertySchema(
      id: 0,
      name: r'createdAtUtc',
      type: IsarType.dateTime,
    ),
    r'familyId': PropertySchema(
      id: 1,
      name: r'familyId',
      type: IsarType.string,
    ),
    r'frequencyPerDay': PropertySchema(
      id: 2,
      name: r'frequencyPerDay',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 3,
      name: r'id',
      type: IsarType.string,
    ),
    r'medicineId': PropertySchema(
      id: 4,
      name: r'medicineId',
      type: IsarType.string,
    ),
    r'memberId': PropertySchema(
      id: 5,
      name: r'memberId',
      type: IsarType.string,
    ),
    r'specificDaysOfWeek': PropertySchema(
      id: 6,
      name: r'specificDaysOfWeek',
      type: IsarType.longList,
    ),
    r'timesOfDay': PropertySchema(
      id: 7,
      name: r'timesOfDay',
      type: IsarType.stringList,
    ),
    r'updatedAtUtc': PropertySchema(
      id: 8,
      name: r'updatedAtUtc',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _isarDosageScheduleEstimateSize,
  serialize: _isarDosageScheduleSerialize,
  deserialize: _isarDosageScheduleDeserialize,
  deserializeProp: _isarDosageScheduleDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'medicineId': IndexSchema(
      id: 6094895651756910893,
      name: r'medicineId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'medicineId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'familyId': IndexSchema(
      id: 928332670682933091,
      name: r'familyId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'familyId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'memberId': IndexSchema(
      id: 5707689632932325803,
      name: r'memberId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'memberId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarDosageScheduleGetId,
  getLinks: _isarDosageScheduleGetLinks,
  attach: _isarDosageScheduleAttach,
  version: '3.1.0+1',
);

int _isarDosageScheduleEstimateSize(
  IsarDosageSchedule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.familyId.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.medicineId.length * 3;
  bytesCount += 3 + object.memberId.length * 3;
  bytesCount += 3 + object.specificDaysOfWeek.length * 8;
  bytesCount += 3 + object.timesOfDay.length * 3;
  {
    for (var i = 0; i < object.timesOfDay.length; i++) {
      final value = object.timesOfDay[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _isarDosageScheduleSerialize(
  IsarDosageSchedule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAtUtc);
  writer.writeString(offsets[1], object.familyId);
  writer.writeLong(offsets[2], object.frequencyPerDay);
  writer.writeString(offsets[3], object.id);
  writer.writeString(offsets[4], object.medicineId);
  writer.writeString(offsets[5], object.memberId);
  writer.writeLongList(offsets[6], object.specificDaysOfWeek);
  writer.writeStringList(offsets[7], object.timesOfDay);
  writer.writeDateTime(offsets[8], object.updatedAtUtc);
}

IsarDosageSchedule _isarDosageScheduleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarDosageSchedule();
  object.createdAtUtc = reader.readDateTime(offsets[0]);
  object.familyId = reader.readString(offsets[1]);
  object.frequencyPerDay = reader.readLong(offsets[2]);
  object.id = reader.readString(offsets[3]);
  object.medicineId = reader.readString(offsets[4]);
  object.memberId = reader.readString(offsets[5]);
  object.specificDaysOfWeek = reader.readLongList(offsets[6]) ?? [];
  object.timesOfDay = reader.readStringList(offsets[7]) ?? [];
  object.updatedAtUtc = reader.readDateTime(offsets[8]);
  return object;
}

P _isarDosageScheduleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLongList(offset) ?? []) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarDosageScheduleGetId(IsarDosageSchedule object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _isarDosageScheduleGetLinks(
    IsarDosageSchedule object) {
  return [];
}

void _isarDosageScheduleAttach(
    IsarCollection<dynamic> col, Id id, IsarDosageSchedule object) {}

extension IsarDosageScheduleByIndex on IsarCollection<IsarDosageSchedule> {
  Future<IsarDosageSchedule?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  IsarDosageSchedule? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<IsarDosageSchedule?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<IsarDosageSchedule?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(IsarDosageSchedule object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(IsarDosageSchedule object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<IsarDosageSchedule> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<IsarDosageSchedule> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension IsarDosageScheduleQueryWhereSort
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QWhere> {
  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarDosageScheduleQueryWhere
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QWhereClause> {
  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      idNotEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      medicineIdEqualTo(String medicineId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'medicineId',
        value: [medicineId],
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      medicineIdNotEqualTo(String medicineId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicineId',
              lower: [],
              upper: [medicineId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicineId',
              lower: [medicineId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicineId',
              lower: [medicineId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'medicineId',
              lower: [],
              upper: [medicineId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      familyIdEqualTo(String familyId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'familyId',
        value: [familyId],
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      familyIdNotEqualTo(String familyId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'familyId',
              lower: [],
              upper: [familyId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'familyId',
              lower: [familyId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'familyId',
              lower: [familyId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'familyId',
              lower: [],
              upper: [familyId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      memberIdEqualTo(String memberId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'memberId',
        value: [memberId],
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterWhereClause>
      memberIdNotEqualTo(String memberId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [],
              upper: [memberId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [memberId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [memberId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'memberId',
              lower: [],
              upper: [memberId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarDosageScheduleQueryFilter
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QFilterCondition> {
  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      createdAtUtcEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      createdAtUtcGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      createdAtUtcLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      createdAtUtcBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAtUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'familyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'familyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'familyId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      familyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'familyId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      frequencyPerDayEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'frequencyPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      frequencyPerDayGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'frequencyPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      frequencyPerDayLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'frequencyPerDay',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      frequencyPerDayBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'frequencyPerDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'medicineId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'medicineId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicineId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      medicineIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'medicineId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'memberId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memberId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      memberIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'specificDaysOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'specificDaysOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'specificDaysOfWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'specificDaysOfWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'specificDaysOfWeek',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'specificDaysOfWeek',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'specificDaysOfWeek',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'specificDaysOfWeek',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'specificDaysOfWeek',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      specificDaysOfWeekLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'specificDaysOfWeek',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timesOfDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timesOfDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timesOfDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timesOfDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timesOfDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timesOfDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timesOfDay',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timesOfDay',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timesOfDay',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timesOfDay',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timesOfDay',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timesOfDay',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timesOfDay',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timesOfDay',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timesOfDay',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      timesOfDayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timesOfDay',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      updatedAtUtcEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      updatedAtUtcGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      updatedAtUtcLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterFilterCondition>
      updatedAtUtcBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAtUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarDosageScheduleQueryObject
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QFilterCondition> {}

extension IsarDosageScheduleQueryLinks
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QFilterCondition> {}

extension IsarDosageScheduleQuerySortBy
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QSortBy> {
  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByCreatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByCreatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByFamilyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByFamilyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByFrequencyPerDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyPerDay', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByFrequencyPerDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyPerDay', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByUpdatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      sortByUpdatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.desc);
    });
  }
}

extension IsarDosageScheduleQuerySortThenBy
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QSortThenBy> {
  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByCreatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByCreatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByFamilyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByFamilyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByFrequencyPerDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyPerDay', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByFrequencyPerDayDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'frequencyPerDay', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByUpdatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QAfterSortBy>
      thenByUpdatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.desc);
    });
  }
}

extension IsarDosageScheduleQueryWhereDistinct
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct> {
  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctByCreatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtUtc');
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctByFamilyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'familyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctByFrequencyPerDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'frequencyPerDay');
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctByMedicineId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicineId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctByMemberId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctBySpecificDaysOfWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'specificDaysOfWeek');
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctByTimesOfDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timesOfDay');
    });
  }

  QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QDistinct>
      distinctByUpdatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAtUtc');
    });
  }
}

extension IsarDosageScheduleQueryProperty
    on QueryBuilder<IsarDosageSchedule, IsarDosageSchedule, QQueryProperty> {
  QueryBuilder<IsarDosageSchedule, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IsarDosageSchedule, DateTime, QQueryOperations>
      createdAtUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtUtc');
    });
  }

  QueryBuilder<IsarDosageSchedule, String, QQueryOperations>
      familyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'familyId');
    });
  }

  QueryBuilder<IsarDosageSchedule, int, QQueryOperations>
      frequencyPerDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'frequencyPerDay');
    });
  }

  QueryBuilder<IsarDosageSchedule, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarDosageSchedule, String, QQueryOperations>
      medicineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicineId');
    });
  }

  QueryBuilder<IsarDosageSchedule, String, QQueryOperations>
      memberIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberId');
    });
  }

  QueryBuilder<IsarDosageSchedule, List<int>, QQueryOperations>
      specificDaysOfWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'specificDaysOfWeek');
    });
  }

  QueryBuilder<IsarDosageSchedule, List<String>, QQueryOperations>
      timesOfDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timesOfDay');
    });
  }

  QueryBuilder<IsarDosageSchedule, DateTime, QQueryOperations>
      updatedAtUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAtUtc');
    });
  }
}
