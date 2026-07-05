// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_adherence_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarAdherenceRecordCollection on Isar {
  IsarCollection<IsarAdherenceRecord> get isarAdherenceRecords =>
      this.collection();
}

const IsarAdherenceRecordSchema = CollectionSchema(
  name: r'IsarAdherenceRecord',
  id: -3472631245738213360,
  properties: {
    r'dateUtc': PropertySchema(
      id: 0,
      name: r'dateUtc',
      type: IsarType.dateTime,
    ),
    r'dosesMissed': PropertySchema(
      id: 1,
      name: r'dosesMissed',
      type: IsarType.long,
    ),
    r'dosesScheduled': PropertySchema(
      id: 2,
      name: r'dosesScheduled',
      type: IsarType.long,
    ),
    r'dosesSkipped': PropertySchema(
      id: 3,
      name: r'dosesSkipped',
      type: IsarType.long,
    ),
    r'dosesTaken': PropertySchema(
      id: 4,
      name: r'dosesTaken',
      type: IsarType.long,
    ),
    r'familyId': PropertySchema(
      id: 5,
      name: r'familyId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 6,
      name: r'id',
      type: IsarType.string,
    ),
    r'medicineId': PropertySchema(
      id: 7,
      name: r'medicineId',
      type: IsarType.string,
    ),
    r'memberId': PropertySchema(
      id: 8,
      name: r'memberId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.byte,
      enumMap: _IsarAdherenceRecordstatusEnumValueMap,
    )
  },
  estimateSize: _isarAdherenceRecordEstimateSize,
  serialize: _isarAdherenceRecordSerialize,
  deserialize: _isarAdherenceRecordDeserialize,
  deserializeProp: _isarAdherenceRecordDeserializeProp,
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
    r'dateUtc': IndexSchema(
      id: 6496663728332232188,
      name: r'dateUtc',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'dateUtc',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _isarAdherenceRecordGetId,
  getLinks: _isarAdherenceRecordGetLinks,
  attach: _isarAdherenceRecordAttach,
  version: '3.1.0+1',
);

int _isarAdherenceRecordEstimateSize(
  IsarAdherenceRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.familyId.length * 3;
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.medicineId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.memberId.length * 3;
  return bytesCount;
}

void _isarAdherenceRecordSerialize(
  IsarAdherenceRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.dateUtc);
  writer.writeLong(offsets[1], object.dosesMissed);
  writer.writeLong(offsets[2], object.dosesScheduled);
  writer.writeLong(offsets[3], object.dosesSkipped);
  writer.writeLong(offsets[4], object.dosesTaken);
  writer.writeString(offsets[5], object.familyId);
  writer.writeString(offsets[6], object.id);
  writer.writeString(offsets[7], object.medicineId);
  writer.writeString(offsets[8], object.memberId);
  writer.writeByte(offsets[9], object.status.index);
}

IsarAdherenceRecord _isarAdherenceRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarAdherenceRecord();
  object.dateUtc = reader.readDateTime(offsets[0]);
  object.dosesMissed = reader.readLong(offsets[1]);
  object.dosesScheduled = reader.readLong(offsets[2]);
  object.dosesSkipped = reader.readLong(offsets[3]);
  object.dosesTaken = reader.readLong(offsets[4]);
  object.familyId = reader.readString(offsets[5]);
  object.id = reader.readString(offsets[6]);
  object.isarId = id;
  object.medicineId = reader.readStringOrNull(offsets[7]);
  object.memberId = reader.readString(offsets[8]);
  object.status = _IsarAdherenceRecordstatusValueEnumMap[
          reader.readByteOrNull(offsets[9])] ??
      AdherenceStatus.perfect;
  return object;
}

P _isarAdherenceRecordDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (_IsarAdherenceRecordstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          AdherenceStatus.perfect) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IsarAdherenceRecordstatusEnumValueMap = {
  'perfect': 0,
  'good': 1,
  'atRisk': 2,
  'critical': 3,
  'unknown': 4,
};
const _IsarAdherenceRecordstatusValueEnumMap = {
  0: AdherenceStatus.perfect,
  1: AdherenceStatus.good,
  2: AdherenceStatus.atRisk,
  3: AdherenceStatus.critical,
  4: AdherenceStatus.unknown,
};

Id _isarAdherenceRecordGetId(IsarAdherenceRecord object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _isarAdherenceRecordGetLinks(
    IsarAdherenceRecord object) {
  return [];
}

void _isarAdherenceRecordAttach(
    IsarCollection<dynamic> col, Id id, IsarAdherenceRecord object) {
  object.isarId = id;
}

extension IsarAdherenceRecordByIndex on IsarCollection<IsarAdherenceRecord> {
  Future<IsarAdherenceRecord?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  IsarAdherenceRecord? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<IsarAdherenceRecord?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<IsarAdherenceRecord?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(IsarAdherenceRecord object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(IsarAdherenceRecord object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<IsarAdherenceRecord> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<IsarAdherenceRecord> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension IsarAdherenceRecordQueryWhereSort
    on QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QWhere> {
  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhere>
      anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhere>
      anyDateUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'dateUtc'),
      );
    });
  }
}

extension IsarAdherenceRecordQueryWhere
    on QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QWhereClause> {
  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      familyIdEqualTo(String familyId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'familyId',
        value: [familyId],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      memberIdEqualTo(String memberId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'memberId',
        value: [memberId],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      medicineIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'medicineId',
        value: [null],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      medicineIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'medicineId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      medicineIdEqualTo(String? medicineId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'medicineId',
        value: [medicineId],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      medicineIdNotEqualTo(String? medicineId) {
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      dateUtcEqualTo(DateTime dateUtc) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'dateUtc',
        value: [dateUtc],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      dateUtcNotEqualTo(DateTime dateUtc) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtc',
              lower: [],
              upper: [dateUtc],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtc',
              lower: [dateUtc],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtc',
              lower: [dateUtc],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'dateUtc',
              lower: [],
              upper: [dateUtc],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      dateUtcGreaterThan(
    DateTime dateUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateUtc',
        lower: [dateUtc],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      dateUtcLessThan(
    DateTime dateUtc, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateUtc',
        lower: [],
        upper: [dateUtc],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterWhereClause>
      dateUtcBetween(
    DateTime lowerDateUtc,
    DateTime upperDateUtc, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'dateUtc',
        lower: [lowerDateUtc],
        includeLower: includeLower,
        upper: [upperDateUtc],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarAdherenceRecordQueryFilter on QueryBuilder<IsarAdherenceRecord,
    IsarAdherenceRecord, QFilterCondition> {
  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dateUtcEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dateUtcGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dateUtcLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateUtc',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dateUtcBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateUtc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesMissedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosesMissed',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesMissedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosesMissed',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesMissedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosesMissed',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesMissedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosesMissed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesScheduledEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosesScheduled',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesScheduledGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosesScheduled',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesScheduledLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosesScheduled',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesScheduledBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosesScheduled',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesSkippedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosesSkipped',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesSkippedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosesSkipped',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesSkippedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosesSkipped',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesSkippedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosesSkipped',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesTakenEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosesTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesTakenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosesTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesTakenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosesTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      dosesTakenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosesTaken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      familyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'familyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      familyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'familyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      familyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'familyId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      familyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'familyId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'medicineId',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'medicineId',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdEqualTo(
    String? value, {
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdGreaterThan(
    String? value, {
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdLessThan(
    String? value, {
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'medicineId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'medicineId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'medicineId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      medicineIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'medicineId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
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

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      memberIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'memberId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      memberIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'memberId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      memberIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      memberIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'memberId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      statusEqualTo(AdherenceStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      statusGreaterThan(
    AdherenceStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      statusLessThan(
    AdherenceStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterFilterCondition>
      statusBetween(
    AdherenceStatus lower,
    AdherenceStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarAdherenceRecordQueryObject on QueryBuilder<IsarAdherenceRecord,
    IsarAdherenceRecord, QFilterCondition> {}

extension IsarAdherenceRecordQueryLinks on QueryBuilder<IsarAdherenceRecord,
    IsarAdherenceRecord, QFilterCondition> {}

extension IsarAdherenceRecordQuerySortBy
    on QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QSortBy> {
  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDateUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDateUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesMissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesMissed', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesMissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesMissed', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesScheduled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesScheduled', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesScheduledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesScheduled', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesSkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesSkipped', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesSkippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesSkipped', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesTaken', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByDosesTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesTaken', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByFamilyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByFamilyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IsarAdherenceRecordQuerySortThenBy
    on QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QSortThenBy> {
  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDateUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtc', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDateUtcDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateUtc', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesMissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesMissed', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesMissedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesMissed', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesScheduled() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesScheduled', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesScheduledDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesScheduled', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesSkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesSkipped', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesSkippedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesSkipped', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesTaken', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByDosesTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosesTaken', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByFamilyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByFamilyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'familyId', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByMedicineId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByMedicineIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'medicineId', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByMemberId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByMemberIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'memberId', Sort.desc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }
}

extension IsarAdherenceRecordQueryWhereDistinct
    on QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct> {
  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByDateUtc() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateUtc');
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByDosesMissed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosesMissed');
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByDosesScheduled() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosesScheduled');
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByDosesSkipped() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosesSkipped');
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByDosesTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosesTaken');
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByFamilyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'familyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByMedicineId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'medicineId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByMemberId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'memberId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }
}

extension IsarAdherenceRecordQueryProperty
    on QueryBuilder<IsarAdherenceRecord, IsarAdherenceRecord, QQueryProperty> {
  QueryBuilder<IsarAdherenceRecord, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IsarAdherenceRecord, DateTime, QQueryOperations>
      dateUtcProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateUtc');
    });
  }

  QueryBuilder<IsarAdherenceRecord, int, QQueryOperations>
      dosesMissedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosesMissed');
    });
  }

  QueryBuilder<IsarAdherenceRecord, int, QQueryOperations>
      dosesScheduledProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosesScheduled');
    });
  }

  QueryBuilder<IsarAdherenceRecord, int, QQueryOperations>
      dosesSkippedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosesSkipped');
    });
  }

  QueryBuilder<IsarAdherenceRecord, int, QQueryOperations>
      dosesTakenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosesTaken');
    });
  }

  QueryBuilder<IsarAdherenceRecord, String, QQueryOperations>
      familyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'familyId');
    });
  }

  QueryBuilder<IsarAdherenceRecord, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarAdherenceRecord, String?, QQueryOperations>
      medicineIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicineId');
    });
  }

  QueryBuilder<IsarAdherenceRecord, String, QQueryOperations>
      memberIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'memberId');
    });
  }

  QueryBuilder<IsarAdherenceRecord, AdherenceStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }
}
