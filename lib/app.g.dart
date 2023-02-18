// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetArtistCollection on Isar {
  IsarCollection<Artist> get artists => getCollection();
}

const ArtistSchema = CollectionSchema(
  name: 'Artist',
  schema:
      '{"name":"Artist","idName":"id","properties":[{"name":"cost","type":"Long"},{"name":"desc","type":"String"},{"name":"heat","type":"Long"},{"name":"imgcred","type":"String"},{"name":"imgurl","type":"String"},{"name":"name","type":"String"},{"name":"number","type":"Long"},{"name":"song","type":"String"},{"name":"timestamp","type":"Long"}],"indexes":[{"name":"timestamp","unique":false,"properties":[{"name":"timestamp","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'cost': 0,
    'desc': 1,
    'heat': 2,
    'imgcred': 3,
    'imgurl': 4,
    'name': 5,
    'number': 6,
    'song': 7,
    'timestamp': 8
  },
  listProperties: {},
  indexIds: {'timestamp': 0},
  indexValueTypes: {
    'timestamp': [
      IndexValueType.long,
    ]
  },
  linkIds: {'events': 0},
  backlinkLinkNames: {'events': 'artist'},
  getId: _artistGetId,
  setId: _artistSetId,
  getLinks: _artistGetLinks,
  attachLinks: _artistAttachLinks,
  serializeNative: _artistSerializeNative,
  deserializeNative: _artistDeserializeNative,
  deserializePropNative: _artistDeserializePropNative,
  serializeWeb: _artistSerializeWeb,
  deserializeWeb: _artistDeserializeWeb,
  deserializePropWeb: _artistDeserializePropWeb,
  version: 3,
);

int? _artistGetId(Artist object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _artistSetId(Artist object, int id) {
  object.id = id;
}

List<IsarLinkBase> _artistGetLinks(Artist object) {
  return [object.events];
}

void _artistSerializeNative(
    IsarCollection<Artist> collection,
    IsarRawObject rawObj,
    Artist object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.cost;
  final _cost = value0;
  final value1 = object.desc;
  final _desc = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_desc.length) as int;
  final value2 = object.heat;
  final _heat = value2;
  final value3 = object.imgcred;
  final _imgcred = IsarBinaryWriter.utf8Encoder.convert(value3);
  dynamicSize += (_imgcred.length) as int;
  final value4 = object.imgurl;
  final _imgurl = IsarBinaryWriter.utf8Encoder.convert(value4);
  dynamicSize += (_imgurl.length) as int;
  final value5 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value5);
  dynamicSize += (_name.length) as int;
  final value6 = object.number;
  final _number = value6;
  final value7 = object.song;
  final _song = IsarBinaryWriter.utf8Encoder.convert(value7);
  dynamicSize += (_song.length) as int;
  final value8 = object.timestamp;
  final _timestamp = value8;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeLong(offsets[0], _cost);
  writer.writeBytes(offsets[1], _desc);
  writer.writeLong(offsets[2], _heat);
  writer.writeBytes(offsets[3], _imgcred);
  writer.writeBytes(offsets[4], _imgurl);
  writer.writeBytes(offsets[5], _name);
  writer.writeLong(offsets[6], _number);
  writer.writeBytes(offsets[7], _song);
  writer.writeDateTime(offsets[8], _timestamp);
}

Artist _artistDeserializeNative(IsarCollection<Artist> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Artist(
    id,
    reader.readString(offsets[5]),
    reader.readString(offsets[7]),
    reader.readLong(offsets[0]),
    reader.readLong(offsets[2]),
    reader.readLong(offsets[6]),
    reader.readString(offsets[1]),
    reader.readString(offsets[3]),
    reader.readString(offsets[4]),
    reader.readDateTime(offsets[8]),
  );
  _artistAttachLinks(collection, id, object);
  return object;
}

P _artistDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readLong(offset)) as P;
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
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _artistSerializeWeb(IsarCollection<Artist> collection, Artist object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'cost', object.cost);
  IsarNative.jsObjectSet(jsObj, 'desc', object.desc);
  IsarNative.jsObjectSet(jsObj, 'heat', object.heat);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'imgcred', object.imgcred);
  IsarNative.jsObjectSet(jsObj, 'imgurl', object.imgurl);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'number', object.number);
  IsarNative.jsObjectSet(jsObj, 'song', object.song);
  IsarNative.jsObjectSet(
      jsObj, 'timestamp', object.timestamp.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

Artist _artistDeserializeWeb(IsarCollection<Artist> collection, dynamic jsObj) {
  final object = Artist(
    IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity,
    IsarNative.jsObjectGet(jsObj, 'name') ?? '',
    IsarNative.jsObjectGet(jsObj, 'song') ?? '',
    IsarNative.jsObjectGet(jsObj, 'cost') ?? double.negativeInfinity,
    IsarNative.jsObjectGet(jsObj, 'heat') ?? double.negativeInfinity,
    IsarNative.jsObjectGet(jsObj, 'number') ?? double.negativeInfinity,
    IsarNative.jsObjectGet(jsObj, 'desc') ?? '',
    IsarNative.jsObjectGet(jsObj, 'imgcred') ?? '',
    IsarNative.jsObjectGet(jsObj, 'imgurl') ?? '',
    IsarNative.jsObjectGet(jsObj, 'timestamp') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'timestamp'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0),
  );
  _artistAttachLinks(collection,
      IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity, object);
  return object;
}

P _artistDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'cost':
      return (IsarNative.jsObjectGet(jsObj, 'cost') ?? double.negativeInfinity)
          as P;
    case 'desc':
      return (IsarNative.jsObjectGet(jsObj, 'desc') ?? '') as P;
    case 'heat':
      return (IsarNative.jsObjectGet(jsObj, 'heat') ?? double.negativeInfinity)
          as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'imgcred':
      return (IsarNative.jsObjectGet(jsObj, 'imgcred') ?? '') as P;
    case 'imgurl':
      return (IsarNative.jsObjectGet(jsObj, 'imgurl') ?? '') as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'number':
      return (IsarNative.jsObjectGet(jsObj, 'number') ??
          double.negativeInfinity) as P;
    case 'song':
      return (IsarNative.jsObjectGet(jsObj, 'song') ?? '') as P;
    case 'timestamp':
      return (IsarNative.jsObjectGet(jsObj, 'timestamp') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'timestamp'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _artistAttachLinks(IsarCollection col, int id, Artist object) {
  object.events.attach(col, col.isar.events, 'events', id);
}

extension ArtistQueryWhereSort on QueryBuilder<Artist, Artist, QWhere> {
  QueryBuilder<Artist, Artist, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<Artist, Artist, QAfterWhere> anyTimestamp() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'timestamp'));
  }
}

extension ArtistQueryWhere on QueryBuilder<Artist, Artist, QWhereClause> {
  QueryBuilder<Artist, Artist, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> timestampEqualTo(
      DateTime timestamp) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'timestamp',
      value: [timestamp],
    ));
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> timestampNotEqualTo(
      DateTime timestamp) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'timestamp',
        upper: [timestamp],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'timestamp',
        lower: [timestamp],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'timestamp',
        lower: [timestamp],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'timestamp',
        upper: [timestamp],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'timestamp',
      lower: [timestamp],
      includeLower: include,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'timestamp',
      upper: [timestamp],
      includeUpper: include,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterWhereClause> timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'timestamp',
      lower: [lowerTimestamp],
      includeLower: includeLower,
      upper: [upperTimestamp],
      includeUpper: includeUpper,
    ));
  }
}

extension ArtistQueryFilter on QueryBuilder<Artist, Artist, QFilterCondition> {
  QueryBuilder<Artist, Artist, QAfterFilterCondition> costEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'cost',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> costGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'cost',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> costLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'cost',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> costBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'cost',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'desc',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> descMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'desc',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> heatEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'heat',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> heatGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'heat',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> heatLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'heat',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> heatBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'heat',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'imgcred',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'imgcred',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'imgcred',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'imgcred',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'imgcred',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'imgcred',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'imgcred',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgcredMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'imgcred',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'imgurl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'imgurl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'imgurl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'imgurl',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'imgurl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'imgurl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'imgurl',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> imgurlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'imgurl',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> numberEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'number',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> numberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'number',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> numberLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'number',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> numberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'number',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'song',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'song',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'song',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'song',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'song',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'song',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'song',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> songMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'song',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> timestampEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Artist, Artist, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'timestamp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension ArtistQueryLinks on QueryBuilder<Artist, Artist, QFilterCondition> {
  QueryBuilder<Artist, Artist, QAfterFilterCondition> events(
      FilterQuery<Event> q) {
    return linkInternal(
      isar.events,
      q,
      'events',
    );
  }
}

extension ArtistQueryWhereSortBy on QueryBuilder<Artist, Artist, QSortBy> {
  QueryBuilder<Artist, Artist, QAfterSortBy> sortByCost() {
    return addSortByInternal('cost', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByCostDesc() {
    return addSortByInternal('cost', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByDesc() {
    return addSortByInternal('desc', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByDescDesc() {
    return addSortByInternal('desc', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByHeat() {
    return addSortByInternal('heat', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByHeatDesc() {
    return addSortByInternal('heat', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByImgcred() {
    return addSortByInternal('imgcred', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByImgcredDesc() {
    return addSortByInternal('imgcred', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByImgurl() {
    return addSortByInternal('imgurl', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByImgurlDesc() {
    return addSortByInternal('imgurl', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByNumber() {
    return addSortByInternal('number', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByNumberDesc() {
    return addSortByInternal('number', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortBySong() {
    return addSortByInternal('song', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortBySongDesc() {
    return addSortByInternal('song', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension ArtistQueryWhereSortThenBy
    on QueryBuilder<Artist, Artist, QSortThenBy> {
  QueryBuilder<Artist, Artist, QAfterSortBy> thenByCost() {
    return addSortByInternal('cost', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByCostDesc() {
    return addSortByInternal('cost', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByDesc() {
    return addSortByInternal('desc', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByDescDesc() {
    return addSortByInternal('desc', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByHeat() {
    return addSortByInternal('heat', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByHeatDesc() {
    return addSortByInternal('heat', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByImgcred() {
    return addSortByInternal('imgcred', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByImgcredDesc() {
    return addSortByInternal('imgcred', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByImgurl() {
    return addSortByInternal('imgurl', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByImgurlDesc() {
    return addSortByInternal('imgurl', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByNumber() {
    return addSortByInternal('number', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByNumberDesc() {
    return addSortByInternal('number', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenBySong() {
    return addSortByInternal('song', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenBySongDesc() {
    return addSortByInternal('song', Sort.desc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<Artist, Artist, QAfterSortBy> thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension ArtistQueryWhereDistinct on QueryBuilder<Artist, Artist, QDistinct> {
  QueryBuilder<Artist, Artist, QDistinct> distinctByCost() {
    return addDistinctByInternal('cost');
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctByDesc(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('desc', caseSensitive: caseSensitive);
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctByHeat() {
    return addDistinctByInternal('heat');
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctByImgcred(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('imgcred', caseSensitive: caseSensitive);
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctByImgurl(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('imgurl', caseSensitive: caseSensitive);
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctByNumber() {
    return addDistinctByInternal('number');
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctBySong(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('song', caseSensitive: caseSensitive);
  }

  QueryBuilder<Artist, Artist, QDistinct> distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }
}

extension ArtistQueryProperty on QueryBuilder<Artist, Artist, QQueryProperty> {
  QueryBuilder<Artist, int, QQueryOperations> costProperty() {
    return addPropertyNameInternal('cost');
  }

  QueryBuilder<Artist, String, QQueryOperations> descProperty() {
    return addPropertyNameInternal('desc');
  }

  QueryBuilder<Artist, int, QQueryOperations> heatProperty() {
    return addPropertyNameInternal('heat');
  }

  QueryBuilder<Artist, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Artist, String, QQueryOperations> imgcredProperty() {
    return addPropertyNameInternal('imgcred');
  }

  QueryBuilder<Artist, String, QQueryOperations> imgurlProperty() {
    return addPropertyNameInternal('imgurl');
  }

  QueryBuilder<Artist, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<Artist, int, QQueryOperations> numberProperty() {
    return addPropertyNameInternal('number');
  }

  QueryBuilder<Artist, String, QQueryOperations> songProperty() {
    return addPropertyNameInternal('song');
  }

  QueryBuilder<Artist, DateTime, QQueryOperations> timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetRuleCollection on Isar {
  IsarCollection<Rule> get rules => getCollection();
}

const RuleSchema = CollectionSchema(
  name: 'Rule',
  schema:
      '{"name":"Rule","idName":"id","properties":[{"name":"category","type":"String"},{"name":"desc","type":"String"},{"name":"name","type":"String"},{"name":"reward","type":"Long"},{"name":"timestamp","type":"Long"}],"indexes":[{"name":"timestamp","unique":false,"properties":[{"name":"timestamp","type":"Value","caseSensitive":false}]}],"links":[]}',
  idName: 'id',
  propertyIds: {
    'category': 0,
    'desc': 1,
    'name': 2,
    'reward': 3,
    'timestamp': 4
  },
  listProperties: {},
  indexIds: {'timestamp': 0},
  indexValueTypes: {
    'timestamp': [
      IndexValueType.long,
    ]
  },
  linkIds: {},
  backlinkLinkNames: {},
  getId: _ruleGetId,
  setId: _ruleSetId,
  getLinks: _ruleGetLinks,
  attachLinks: _ruleAttachLinks,
  serializeNative: _ruleSerializeNative,
  deserializeNative: _ruleDeserializeNative,
  deserializePropNative: _ruleDeserializePropNative,
  serializeWeb: _ruleSerializeWeb,
  deserializeWeb: _ruleDeserializeWeb,
  deserializePropWeb: _ruleDeserializePropWeb,
  version: 3,
);

int? _ruleGetId(Rule object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _ruleSetId(Rule object, int id) {
  object.id = id;
}

List<IsarLinkBase> _ruleGetLinks(Rule object) {
  return [];
}

void _ruleSerializeNative(IsarCollection<Rule> collection, IsarRawObject rawObj,
    Rule object, int staticSize, List<int> offsets, AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.category;
  final _category = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_category.length) as int;
  final value1 = object.desc;
  final _desc = IsarBinaryWriter.utf8Encoder.convert(value1);
  dynamicSize += (_desc.length) as int;
  final value2 = object.name;
  final _name = IsarBinaryWriter.utf8Encoder.convert(value2);
  dynamicSize += (_name.length) as int;
  final value3 = object.reward;
  final _reward = value3;
  final value4 = object.timestamp;
  final _timestamp = value4;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _category);
  writer.writeBytes(offsets[1], _desc);
  writer.writeBytes(offsets[2], _name);
  writer.writeLong(offsets[3], _reward);
  writer.writeDateTime(offsets[4], _timestamp);
}

Rule _ruleDeserializeNative(IsarCollection<Rule> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Rule(
    id,
    reader.readString(offsets[2]),
    reader.readString(offsets[1]),
    reader.readString(offsets[0]),
    reader.readLong(offsets[3]),
    reader.readDateTime(offsets[4]),
  );
  return object;
}

P _ruleDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readDateTime(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _ruleSerializeWeb(IsarCollection<Rule> collection, Rule object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'category', object.category);
  IsarNative.jsObjectSet(jsObj, 'desc', object.desc);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(jsObj, 'name', object.name);
  IsarNative.jsObjectSet(jsObj, 'reward', object.reward);
  IsarNative.jsObjectSet(
      jsObj, 'timestamp', object.timestamp.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

Rule _ruleDeserializeWeb(IsarCollection<Rule> collection, dynamic jsObj) {
  final object = Rule(
    IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity,
    IsarNative.jsObjectGet(jsObj, 'name') ?? '',
    IsarNative.jsObjectGet(jsObj, 'desc') ?? '',
    IsarNative.jsObjectGet(jsObj, 'category') ?? '',
    IsarNative.jsObjectGet(jsObj, 'reward') ?? double.negativeInfinity,
    IsarNative.jsObjectGet(jsObj, 'timestamp') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'timestamp'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0),
  );
  return object;
}

P _ruleDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'category':
      return (IsarNative.jsObjectGet(jsObj, 'category') ?? '') as P;
    case 'desc':
      return (IsarNative.jsObjectGet(jsObj, 'desc') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'name':
      return (IsarNative.jsObjectGet(jsObj, 'name') ?? '') as P;
    case 'reward':
      return (IsarNative.jsObjectGet(jsObj, 'reward') ??
          double.negativeInfinity) as P;
    case 'timestamp':
      return (IsarNative.jsObjectGet(jsObj, 'timestamp') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'timestamp'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _ruleAttachLinks(IsarCollection col, int id, Rule object) {}

extension RuleQueryWhereSort on QueryBuilder<Rule, Rule, QWhere> {
  QueryBuilder<Rule, Rule, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<Rule, Rule, QAfterWhere> anyTimestamp() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'timestamp'));
  }
}

extension RuleQueryWhere on QueryBuilder<Rule, Rule, QWhereClause> {
  QueryBuilder<Rule, Rule, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> timestampEqualTo(
      DateTime timestamp) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'timestamp',
      value: [timestamp],
    ));
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> timestampNotEqualTo(
      DateTime timestamp) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'timestamp',
        upper: [timestamp],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'timestamp',
        lower: [timestamp],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'timestamp',
        lower: [timestamp],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'timestamp',
        upper: [timestamp],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'timestamp',
      lower: [timestamp],
      includeLower: include,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'timestamp',
      upper: [timestamp],
      includeUpper: include,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterWhereClause> timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'timestamp',
      lower: [lowerTimestamp],
      includeLower: includeLower,
      upper: [upperTimestamp],
      includeUpper: includeUpper,
    ));
  }
}

extension RuleQueryFilter on QueryBuilder<Rule, Rule, QFilterCondition> {
  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'category',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'category',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> categoryMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'category',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'desc',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'desc',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> descMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'desc',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'name',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'name',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'name',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> rewardEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'reward',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> rewardGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'reward',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> rewardLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'reward',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> rewardBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'reward',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> timestampEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Rule, Rule, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'timestamp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension RuleQueryLinks on QueryBuilder<Rule, Rule, QFilterCondition> {}

extension RuleQueryWhereSortBy on QueryBuilder<Rule, Rule, QSortBy> {
  QueryBuilder<Rule, Rule, QAfterSortBy> sortByCategory() {
    return addSortByInternal('category', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByCategoryDesc() {
    return addSortByInternal('category', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByDesc() {
    return addSortByInternal('desc', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByDescDesc() {
    return addSortByInternal('desc', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByReward() {
    return addSortByInternal('reward', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByRewardDesc() {
    return addSortByInternal('reward', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension RuleQueryWhereSortThenBy on QueryBuilder<Rule, Rule, QSortThenBy> {
  QueryBuilder<Rule, Rule, QAfterSortBy> thenByCategory() {
    return addSortByInternal('category', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByCategoryDesc() {
    return addSortByInternal('category', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByDesc() {
    return addSortByInternal('desc', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByDescDesc() {
    return addSortByInternal('desc', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByName() {
    return addSortByInternal('name', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByNameDesc() {
    return addSortByInternal('name', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByReward() {
    return addSortByInternal('reward', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByRewardDesc() {
    return addSortByInternal('reward', Sort.desc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<Rule, Rule, QAfterSortBy> thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension RuleQueryWhereDistinct on QueryBuilder<Rule, Rule, QDistinct> {
  QueryBuilder<Rule, Rule, QDistinct> distinctByCategory(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('category', caseSensitive: caseSensitive);
  }

  QueryBuilder<Rule, Rule, QDistinct> distinctByDesc(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('desc', caseSensitive: caseSensitive);
  }

  QueryBuilder<Rule, Rule, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Rule, Rule, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('name', caseSensitive: caseSensitive);
  }

  QueryBuilder<Rule, Rule, QDistinct> distinctByReward() {
    return addDistinctByInternal('reward');
  }

  QueryBuilder<Rule, Rule, QDistinct> distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }
}

extension RuleQueryProperty on QueryBuilder<Rule, Rule, QQueryProperty> {
  QueryBuilder<Rule, String, QQueryOperations> categoryProperty() {
    return addPropertyNameInternal('category');
  }

  QueryBuilder<Rule, String, QQueryOperations> descProperty() {
    return addPropertyNameInternal('desc');
  }

  QueryBuilder<Rule, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Rule, String, QQueryOperations> nameProperty() {
    return addPropertyNameInternal('name');
  }

  QueryBuilder<Rule, int, QQueryOperations> rewardProperty() {
    return addPropertyNameInternal('reward');
  }

  QueryBuilder<Rule, DateTime, QQueryOperations> timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }
}

// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, unused_local_variable

extension GetEventCollection on Isar {
  IsarCollection<Event> get events => getCollection();
}

const EventSchema = CollectionSchema(
  name: 'Event',
  schema:
      '{"name":"Event","idName":"id","properties":[{"name":"comment","type":"String"},{"name":"timestamp","type":"Long"}],"indexes":[{"name":"timestamp","unique":false,"properties":[{"name":"timestamp","type":"Value","caseSensitive":false}]}],"links":[{"name":"artist","target":"Artist"},{"name":"rule","target":"Rule"}]}',
  idName: 'id',
  propertyIds: {'comment': 0, 'timestamp': 1},
  listProperties: {},
  indexIds: {'timestamp': 0},
  indexValueTypes: {
    'timestamp': [
      IndexValueType.long,
    ]
  },
  linkIds: {'artist': 0, 'rule': 1},
  backlinkLinkNames: {},
  getId: _eventGetId,
  setId: _eventSetId,
  getLinks: _eventGetLinks,
  attachLinks: _eventAttachLinks,
  serializeNative: _eventSerializeNative,
  deserializeNative: _eventDeserializeNative,
  deserializePropNative: _eventDeserializePropNative,
  serializeWeb: _eventSerializeWeb,
  deserializeWeb: _eventDeserializeWeb,
  deserializePropWeb: _eventDeserializePropWeb,
  version: 3,
);

int? _eventGetId(Event object) {
  if (object.id == Isar.autoIncrement) {
    return null;
  } else {
    return object.id;
  }
}

void _eventSetId(Event object, int id) {
  object.id = id;
}

List<IsarLinkBase> _eventGetLinks(Event object) {
  return [object.artist, object.rule];
}

void _eventSerializeNative(
    IsarCollection<Event> collection,
    IsarRawObject rawObj,
    Event object,
    int staticSize,
    List<int> offsets,
    AdapterAlloc alloc) {
  var dynamicSize = 0;
  final value0 = object.comment;
  final _comment = IsarBinaryWriter.utf8Encoder.convert(value0);
  dynamicSize += (_comment.length) as int;
  final value1 = object.timestamp;
  final _timestamp = value1;
  final size = staticSize + dynamicSize;

  rawObj.buffer = alloc(size);
  rawObj.buffer_length = size;
  final buffer = IsarNative.bufAsBytes(rawObj.buffer, size);
  final writer = IsarBinaryWriter(buffer, staticSize);
  writer.writeBytes(offsets[0], _comment);
  writer.writeDateTime(offsets[1], _timestamp);
}

Event _eventDeserializeNative(IsarCollection<Event> collection, int id,
    IsarBinaryReader reader, List<int> offsets) {
  final object = Event(
    id,
    reader.readString(offsets[0]),
    reader.readDateTime(offsets[1]),
  );
  _eventAttachLinks(collection, id, object);
  return object;
}

P _eventDeserializePropNative<P>(
    int id, IsarBinaryReader reader, int propertyIndex, int offset) {
  switch (propertyIndex) {
    case -1:
      return id as P;
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    default:
      throw 'Illegal propertyIndex';
  }
}

dynamic _eventSerializeWeb(IsarCollection<Event> collection, Event object) {
  final jsObj = IsarNative.newJsObject();
  IsarNative.jsObjectSet(jsObj, 'comment', object.comment);
  IsarNative.jsObjectSet(jsObj, 'id', object.id);
  IsarNative.jsObjectSet(
      jsObj, 'timestamp', object.timestamp.toUtc().millisecondsSinceEpoch);
  return jsObj;
}

Event _eventDeserializeWeb(IsarCollection<Event> collection, dynamic jsObj) {
  final object = Event(
    IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity,
    IsarNative.jsObjectGet(jsObj, 'comment') ?? '',
    IsarNative.jsObjectGet(jsObj, 'timestamp') != null
        ? DateTime.fromMillisecondsSinceEpoch(
                IsarNative.jsObjectGet(jsObj, 'timestamp'),
                isUtc: true)
            .toLocal()
        : DateTime.fromMillisecondsSinceEpoch(0),
  );
  _eventAttachLinks(collection,
      IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity, object);
  return object;
}

P _eventDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    case 'comment':
      return (IsarNative.jsObjectGet(jsObj, 'comment') ?? '') as P;
    case 'id':
      return (IsarNative.jsObjectGet(jsObj, 'id') ?? double.negativeInfinity)
          as P;
    case 'timestamp':
      return (IsarNative.jsObjectGet(jsObj, 'timestamp') != null
          ? DateTime.fromMillisecondsSinceEpoch(
                  IsarNative.jsObjectGet(jsObj, 'timestamp'),
                  isUtc: true)
              .toLocal()
          : DateTime.fromMillisecondsSinceEpoch(0)) as P;
    default:
      throw 'Illegal propertyName';
  }
}

void _eventAttachLinks(IsarCollection col, int id, Event object) {
  object.artist.attach(col, col.isar.artists, 'artist', id);
  object.rule.attach(col, col.isar.rules, 'rule', id);
}

extension EventQueryWhereSort on QueryBuilder<Event, Event, QWhere> {
  QueryBuilder<Event, Event, QAfterWhere> anyId() {
    return addWhereClauseInternal(const IdWhereClause.any());
  }

  QueryBuilder<Event, Event, QAfterWhere> anyTimestamp() {
    return addWhereClauseInternal(
        const IndexWhereClause.any(indexName: 'timestamp'));
  }
}

extension EventQueryWhere on QueryBuilder<Event, Event, QWhereClause> {
  QueryBuilder<Event, Event, QAfterWhereClause> idEqualTo(int id) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: id,
      includeLower: true,
      upper: id,
      includeUpper: true,
    ));
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idNotEqualTo(int id) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      ).addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      );
    } else {
      return addWhereClauseInternal(
        IdWhereClause.greaterThan(lower: id, includeLower: false),
      ).addWhereClauseInternal(
        IdWhereClause.lessThan(upper: id, includeUpper: false),
      );
    }
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idGreaterThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.greaterThan(lower: id, includeLower: include),
    );
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idLessThan(int id,
      {bool include = false}) {
    return addWhereClauseInternal(
      IdWhereClause.lessThan(upper: id, includeUpper: include),
    );
  }

  QueryBuilder<Event, Event, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IdWhereClause.between(
      lower: lowerId,
      includeLower: includeLower,
      upper: upperId,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Event, Event, QAfterWhereClause> timestampEqualTo(
      DateTime timestamp) {
    return addWhereClauseInternal(IndexWhereClause.equalTo(
      indexName: 'timestamp',
      value: [timestamp],
    ));
  }

  QueryBuilder<Event, Event, QAfterWhereClause> timestampNotEqualTo(
      DateTime timestamp) {
    if (whereSortInternal == Sort.asc) {
      return addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'timestamp',
        upper: [timestamp],
        includeUpper: false,
      )).addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'timestamp',
        lower: [timestamp],
        includeLower: false,
      ));
    } else {
      return addWhereClauseInternal(IndexWhereClause.greaterThan(
        indexName: 'timestamp',
        lower: [timestamp],
        includeLower: false,
      )).addWhereClauseInternal(IndexWhereClause.lessThan(
        indexName: 'timestamp',
        upper: [timestamp],
        includeUpper: false,
      ));
    }
  }

  QueryBuilder<Event, Event, QAfterWhereClause> timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.greaterThan(
      indexName: 'timestamp',
      lower: [timestamp],
      includeLower: include,
    ));
  }

  QueryBuilder<Event, Event, QAfterWhereClause> timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return addWhereClauseInternal(IndexWhereClause.lessThan(
      indexName: 'timestamp',
      upper: [timestamp],
      includeUpper: include,
    ));
  }

  QueryBuilder<Event, Event, QAfterWhereClause> timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addWhereClauseInternal(IndexWhereClause.between(
      indexName: 'timestamp',
      lower: [lowerTimestamp],
      includeLower: includeLower,
      upper: [upperTimestamp],
      includeUpper: includeUpper,
    ));
  }
}

extension EventQueryFilter on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> commentEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> commentGreaterThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> commentLessThan(
    String value, {
    bool caseSensitive = true,
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> commentBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'comment',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> commentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.startsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> commentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.endsWith,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> commentContains(
      String value,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.contains,
      property: 'comment',
      value: value,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> commentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.matches,
      property: 'comment',
      value: pattern,
      caseSensitive: caseSensitive,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idEqualTo(int value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idGreaterThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idLessThan(
    int value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'id',
      value: value,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'id',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> timestampEqualTo(
      DateTime value) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.eq,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.gt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return addFilterConditionInternal(FilterCondition(
      type: ConditionType.lt,
      include: include,
      property: 'timestamp',
      value: value,
    ));
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return addFilterConditionInternal(FilterCondition.between(
      property: 'timestamp',
      lower: lower,
      includeLower: includeLower,
      upper: upper,
      includeUpper: includeUpper,
    ));
  }
}

extension EventQueryLinks on QueryBuilder<Event, Event, QFilterCondition> {
  QueryBuilder<Event, Event, QAfterFilterCondition> artist(
      FilterQuery<Artist> q) {
    return linkInternal(
      isar.artists,
      q,
      'artist',
    );
  }

  QueryBuilder<Event, Event, QAfterFilterCondition> rule(FilterQuery<Rule> q) {
    return linkInternal(
      isar.rules,
      q,
      'rule',
    );
  }
}

extension EventQueryWhereSortBy on QueryBuilder<Event, Event, QSortBy> {
  QueryBuilder<Event, Event, QAfterSortBy> sortByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> sortByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension EventQueryWhereSortThenBy on QueryBuilder<Event, Event, QSortThenBy> {
  QueryBuilder<Event, Event, QAfterSortBy> thenByComment() {
    return addSortByInternal('comment', Sort.asc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByCommentDesc() {
    return addSortByInternal('comment', Sort.desc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenById() {
    return addSortByInternal('id', Sort.asc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByIdDesc() {
    return addSortByInternal('id', Sort.desc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByTimestamp() {
    return addSortByInternal('timestamp', Sort.asc);
  }

  QueryBuilder<Event, Event, QAfterSortBy> thenByTimestampDesc() {
    return addSortByInternal('timestamp', Sort.desc);
  }
}

extension EventQueryWhereDistinct on QueryBuilder<Event, Event, QDistinct> {
  QueryBuilder<Event, Event, QDistinct> distinctByComment(
      {bool caseSensitive = true}) {
    return addDistinctByInternal('comment', caseSensitive: caseSensitive);
  }

  QueryBuilder<Event, Event, QDistinct> distinctById() {
    return addDistinctByInternal('id');
  }

  QueryBuilder<Event, Event, QDistinct> distinctByTimestamp() {
    return addDistinctByInternal('timestamp');
  }
}

extension EventQueryProperty on QueryBuilder<Event, Event, QQueryProperty> {
  QueryBuilder<Event, String, QQueryOperations> commentProperty() {
    return addPropertyNameInternal('comment');
  }

  QueryBuilder<Event, int, QQueryOperations> idProperty() {
    return addPropertyNameInternal('id');
  }

  QueryBuilder<Event, DateTime, QQueryOperations> timestampProperty() {
    return addPropertyNameInternal('timestamp');
  }
}
