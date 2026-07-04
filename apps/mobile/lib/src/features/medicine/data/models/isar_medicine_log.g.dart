// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_medicine_log.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarMedicineLogCollection on Isar {
  IsarCollection<IsarMedicineLog> get isarMedicineLogs => this.collection();
}

const IsarMedicineLogSchema = CollectionSchema(
  name: r'IsarMedicineLog',
  id: -7911030898294593094,
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
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'medicineId': PropertySchema(
      id: 3,
      name: r'medicineId',
      type: IsarType.string,
    ),
    r'memberId': PropertySchema(
      id: 4,
      name: r'memberId',
      type: IsarType.string,
    ),
    r'scheduledAtUtc': PropertySchema(
      id: 5,
      name: r'scheduledAtUtc',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 6,
      name: r'status',
      type: IsarType.string,
      enumMap: _IsarMedicineLogstatusEnumValueMap,
    ),
    r'takenAtUtc': PropertySchema(
      id: 7,
      name: r'takenAtUtc',
      type: IsarType.dateTime,
    ),
    r'updatedAtUtc': PropertySchema(
      id: 8,
      name: r'updatedAtUtc',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _isarMedicineLogEstimateSize,
  serialize: _isarMedicineLogSerialize,
  deserialize: _isarMedicineLogDeserialize,
  deserializeProp: _isarMedicineLogDeserializeProp,
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
  getId: _isarMedicineLogGetId,
  getLinks: _isarMedicineLogGetLinks,
  attach: _isarMedicineLogAttach,
  version: '3.1.0+1',
);

int _isarMedicineLogEstimateSize(
  IsarMedicineLog object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.familyId.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.medicineId.length * 3;
  bytesCount += 3 + object.memberId.length * 3;
  bytesCount += 3 + object.status.name.length * 3;
  return bytesCount;
}

void _isarMedicineLogSerialize(
  IsarMedicineLog object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAtUtc);
  writer.writeString(offsets[1], object.familyId);
  writer.writeString(offsets[2], object.id);
  writer.writeString(offsets[3], object.medicineId);
  writer.writeString(offsets[4], object.memberId);
  writer.writeDateTime(offsets[5], object.scheduledAtUtc);
  writer.writeString(offsets[6], object.status.name);
  writer.writeDateTime(offsets[7], object.takenAtUtc);
  writer.writeDateTime(offsets[8], object.updatedAtUtc);
}

IsarMedicineLog _isarMedicineLogDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMedicineLog();
  object.createdAtUtc = reader.readDateTime(offsets[0]);
  object.familyId = reader.readString(offsets[1]);
  object.id = reader.readString(offsets[2]);
  object.medicineId = reader.readString(offsets[3]);
  object.memberId = reader.readString(offsets[4]);
  object.scheduledAtUtc = reader.readDateTime(offsets[5]);
  object.status =
      _IsarMedicineLogstatusValueEnumMap[reader.readStringOrNull(offsets[6])] ??
          MedicineLogStatus.scheduled;
  object.takenAtUtc = reader.readDateTimeOrNull(offsets[7]);
  object.updatedAtUtc = reader.readDateTime(offsets[8]);
  return object;
}

P _isarMedicineLogDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (_IsarMedicineLogstatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          MedicineLogStatus.scheduled) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarMedicineLogstatusEnumValueMap = {
  r'scheduled': r'scheduled',
  r'taken': r'taken',
  r'skipped': r'skipped',
  r'missed': r'missed',
  r'postponed': r'postponed',
};
const _IsarMedicineLogstatusValueEnumMap = {
  r'scheduled': MedicineLogStatus.scheduled,
  r'taken': MedicineLogStatus.taken,
  r'skipped': MedicineLogStatus.skipped,
  r'missed': MedicineLogStatus.missed,
  r'postponed': MedicineLogStatus.postponed,
};

Id _isarMedicineLogGetId(IsarMedicineLog object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _isarMedicineLogGetLinks(IsarMedicineLog object) {
  return [];
}

void _isarMedicineLogAttach(
    IsarCollection<dynamic> col, Id id, IsarMedicineLog object) {}

extension IsarMedicineLogByIndex on IsarCollection<IsarMedicineLog> {
  Future<IsarMedicineLog?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  IsarMedicineLog? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<IsarMedicineLog?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<IsarMedicineLog?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(IsarMedicineLog object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(IsarMedicineLog object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<IsarMedicineLog> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<IsarMedicineLog> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension IsarMedicineLogQueryWhereSort
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QWhere> {
  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarMedicineLogQueryWhere
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QWhereClause> {
  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause> idEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
      medicineIdEqualTo(String medicineId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'medicineId',
        value: [medicineId],
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
      familyIdEqualTo(String familyId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'familyId',
        value: [familyId],
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
      memberIdEqualTo(String memberId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'memberId',
        value: [memberId],
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterWhereClause>
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

extension IsarMedicineLogQueryFilter
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QFilterCondition> {
  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      createdAtUtcEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      familyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      familyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'familyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      familyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'familyId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      familyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'familyId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      medicineIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      medicineIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'medicineId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      medicineIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicineId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      medicineIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'medicineId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      memberIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      memberIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memberId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      memberIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      memberIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      scheduledAtUtcEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      scheduledAtUtcGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      scheduledAtUtcLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      scheduledAtUtcBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledAtUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusEqualTo(
    MedicineLogStatus value, {
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusGreaterThan(
    MedicineLogStatus value, {
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusLessThan(
    MedicineLogStatus value, {
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusBetween(
    MedicineLogStatus lower,
    MedicineLogStatus upper, {
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusStartsWith(
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusEndsWith(
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      takenAtUtcIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'takenAtUtc',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      takenAtUtcIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'takenAtUtc',
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      takenAtUtcEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'takenAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      takenAtUtcGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'takenAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      takenAtUtcLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'takenAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      takenAtUtcBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'takenAtUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
      updatedAtUtcEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAtUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterFilterCondition>
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

extension IsarMedicineLogQueryObject
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QFilterCondition> {}

extension IsarMedicineLogQueryLinks
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QFilterCondition> {}

extension IsarMedicineLogQuerySortBy
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QSortBy> {
  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByCreatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByCreatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByFamilyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByFamilyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByScheduledAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByScheduledAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByTakenAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByTakenAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByUpdatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      sortByUpdatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.desc);
    });
  }
}

extension IsarMedicineLogQuerySortThenBy
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QSortThenBy> {
  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByCreatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByCreatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByFamilyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByFamilyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByScheduledAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByScheduledAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByTakenAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByTakenAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'takenAtUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByUpdatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QAfterSortBy>
      thenByUpdatedAtUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAtUtc', Sort.desc);
    });
  }
}

extension IsarMedicineLogQueryWhereDistinct
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct> {
  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct>
      distinctByCreatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAtUtc');
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct> distinctByFamilyId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'familyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct>
      distinctByMedicineId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicineId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct> distinctByMemberId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct>
      distinctByScheduledAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledAtUtc');
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct>
      distinctByTakenAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'takenAtUtc');
    });
  }

  QueryBuilder<IsarMedicineLog, IsarMedicineLog, QDistinct>
      distinctByUpdatedAtUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAtUtc');
    });
  }
}

extension IsarMedicineLogQueryProperty
    on QueryBuilder<IsarMedicineLog, IsarMedicineLog, QQueryProperty> {
  QueryBuilder<IsarMedicineLog, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IsarMedicineLog, DateTime, QQueryOperations>
      createdAtUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAtUtc');
    });
  }

  QueryBuilder<IsarMedicineLog, String, QQueryOperations> familyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'familyId');
    });
  }

  QueryBuilder<IsarMedicineLog, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarMedicineLog, String, QQueryOperations> medicineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicineId');
    });
  }

  QueryBuilder<IsarMedicineLog, String, QQueryOperations> memberIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberId');
    });
  }

  QueryBuilder<IsarMedicineLog, DateTime, QQueryOperations>
      scheduledAtUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledAtUtc');
    });
  }

  QueryBuilder<IsarMedicineLog, MedicineLogStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<IsarMedicineLog, DateTime?, QQueryOperations>
      takenAtUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'takenAtUtc');
    });
  }

  QueryBuilder<IsarMedicineLog, DateTime, QQueryOperations>
      updatedAtUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAtUtc');
    });
  }
}
