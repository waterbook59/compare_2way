// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comparison_item_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class ComparisonOverviewRecord extends DataClass
    implements Insertable<ComparisonOverviewRecord> {
  final int dataId;
  final String comparisonItemId;
  final String itemTitle;
  final String way1Title;
  final String way1Demerit;
  final int way1Evaluate;
  final String way2Title;
  final int way2Evaluate;
  final String tags;
  final bool favorite;
  final String conclusion;
  ComparisonOverviewRecord(
      {@required this.dataId,
      @required this.comparisonItemId,
      @required this.itemTitle,
      @required this.way1Title,
      this.way1Demerit,
      @required this.way1Evaluate,
      @required this.way2Title,
      @required this.way2Evaluate,
      this.tags,
      @required this.favorite,
      this.conclusion});
  factory ComparisonOverviewRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return ComparisonOverviewRecord(
      dataId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}data_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
      itemTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}item_title']),
      way1Title: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_title']),
      way1Demerit: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_demerit']),
      way1Evaluate: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_evaluate']),
      way2Title: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_title']),
      way2Evaluate: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_evaluate']),
      tags: stringType.mapFromDatabaseResponse(data['${effectivePrefix}tags']),
      favorite:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}favorite']),
      conclusion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}conclusion']),
    );
  }
  factory ComparisonOverviewRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ComparisonOverviewRecord(
      dataId: serializer.fromJson<int>(json['dataId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      itemTitle: serializer.fromJson<String>(json['itemTitle']),
      way1Title: serializer.fromJson<String>(json['way1Title']),
      way1Demerit: serializer.fromJson<String>(json['way1Demerit']),
      way1Evaluate: serializer.fromJson<int>(json['way1Evaluate']),
      way2Title: serializer.fromJson<String>(json['way2Title']),
      way2Evaluate: serializer.fromJson<int>(json['way2Evaluate']),
      tags: serializer.fromJson<String>(json['tags']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      conclusion: serializer.fromJson<String>(json['conclusion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dataId': serializer.toJson<int>(dataId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'itemTitle': serializer.toJson<String>(itemTitle),
      'way1Title': serializer.toJson<String>(way1Title),
      'way1Demerit': serializer.toJson<String>(way1Demerit),
      'way1Evaluate': serializer.toJson<int>(way1Evaluate),
      'way2Title': serializer.toJson<String>(way2Title),
      'way2Evaluate': serializer.toJson<int>(way2Evaluate),
      'tags': serializer.toJson<String>(tags),
      'favorite': serializer.toJson<bool>(favorite),
      'conclusion': serializer.toJson<String>(conclusion),
    };
  }

  @override
  ComparisonOverviewRecordsCompanion createCompanion(bool nullToAbsent) {
    return ComparisonOverviewRecordsCompanion(
      dataId:
          dataId == null && nullToAbsent ? const Value.absent() : Value(dataId),
      comparisonItemId: comparisonItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(comparisonItemId),
      itemTitle: itemTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(itemTitle),
      way1Title: way1Title == null && nullToAbsent
          ? const Value.absent()
          : Value(way1Title),
      way1Demerit: way1Demerit == null && nullToAbsent
          ? const Value.absent()
          : Value(way1Demerit),
      way1Evaluate: way1Evaluate == null && nullToAbsent
          ? const Value.absent()
          : Value(way1Evaluate),
      way2Title: way2Title == null && nullToAbsent
          ? const Value.absent()
          : Value(way2Title),
      way2Evaluate: way2Evaluate == null && nullToAbsent
          ? const Value.absent()
          : Value(way2Evaluate),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      favorite: favorite == null && nullToAbsent
          ? const Value.absent()
          : Value(favorite),
      conclusion: conclusion == null && nullToAbsent
          ? const Value.absent()
          : Value(conclusion),
    );
  }

  ComparisonOverviewRecord copyWith(
          {int dataId,
          String comparisonItemId,
          String itemTitle,
          String way1Title,
          String way1Demerit,
          int way1Evaluate,
          String way2Title,
          int way2Evaluate,
          String tags,
          bool favorite,
          String conclusion}) =>
      ComparisonOverviewRecord(
        dataId: dataId ?? this.dataId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        itemTitle: itemTitle ?? this.itemTitle,
        way1Title: way1Title ?? this.way1Title,
        way1Demerit: way1Demerit ?? this.way1Demerit,
        way1Evaluate: way1Evaluate ?? this.way1Evaluate,
        way2Title: way2Title ?? this.way2Title,
        way2Evaluate: way2Evaluate ?? this.way2Evaluate,
        tags: tags ?? this.tags,
        favorite: favorite ?? this.favorite,
        conclusion: conclusion ?? this.conclusion,
      );
  @override
  String toString() {
    return (StringBuffer('ComparisonOverviewRecord(')
          ..write('dataId: $dataId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('itemTitle: $itemTitle, ')
          ..write('way1Title: $way1Title, ')
          ..write('way1Demerit: $way1Demerit, ')
          ..write('way1Evaluate: $way1Evaluate, ')
          ..write('way2Title: $way2Title, ')
          ..write('way2Evaluate: $way2Evaluate, ')
          ..write('tags: $tags, ')
          ..write('favorite: $favorite, ')
          ..write('conclusion: $conclusion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      dataId.hashCode,
      $mrjc(
          comparisonItemId.hashCode,
          $mrjc(
              itemTitle.hashCode,
              $mrjc(
                  way1Title.hashCode,
                  $mrjc(
                      way1Demerit.hashCode,
                      $mrjc(
                          way1Evaluate.hashCode,
                          $mrjc(
                              way2Title.hashCode,
                              $mrjc(
                                  way2Evaluate.hashCode,
                                  $mrjc(
                                      tags.hashCode,
                                      $mrjc(favorite.hashCode,
                                          conclusion.hashCode)))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ComparisonOverviewRecord &&
          other.dataId == this.dataId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.itemTitle == this.itemTitle &&
          other.way1Title == this.way1Title &&
          other.way1Demerit == this.way1Demerit &&
          other.way1Evaluate == this.way1Evaluate &&
          other.way2Title == this.way2Title &&
          other.way2Evaluate == this.way2Evaluate &&
          other.tags == this.tags &&
          other.favorite == this.favorite &&
          other.conclusion == this.conclusion);
}

class ComparisonOverviewRecordsCompanion
    extends UpdateCompanion<ComparisonOverviewRecord> {
  final Value<int> dataId;
  final Value<String> comparisonItemId;
  final Value<String> itemTitle;
  final Value<String> way1Title;
  final Value<String> way1Demerit;
  final Value<int> way1Evaluate;
  final Value<String> way2Title;
  final Value<int> way2Evaluate;
  final Value<String> tags;
  final Value<bool> favorite;
  final Value<String> conclusion;
  const ComparisonOverviewRecordsCompanion({
    this.dataId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.itemTitle = const Value.absent(),
    this.way1Title = const Value.absent(),
    this.way1Demerit = const Value.absent(),
    this.way1Evaluate = const Value.absent(),
    this.way2Title = const Value.absent(),
    this.way2Evaluate = const Value.absent(),
    this.tags = const Value.absent(),
    this.favorite = const Value.absent(),
    this.conclusion = const Value.absent(),
  });
  ComparisonOverviewRecordsCompanion.insert({
    this.dataId = const Value.absent(),
    @required String comparisonItemId,
    @required String itemTitle,
    @required String way1Title,
    this.way1Demerit = const Value.absent(),
    this.way1Evaluate = const Value.absent(),
    @required String way2Title,
    this.way2Evaluate = const Value.absent(),
    this.tags = const Value.absent(),
    this.favorite = const Value.absent(),
    this.conclusion = const Value.absent(),
  })  : comparisonItemId = Value(comparisonItemId),
        itemTitle = Value(itemTitle),
        way1Title = Value(way1Title),
        way2Title = Value(way2Title);
  ComparisonOverviewRecordsCompanion copyWith(
      {Value<int> dataId,
      Value<String> comparisonItemId,
      Value<String> itemTitle,
      Value<String> way1Title,
      Value<String> way1Demerit,
      Value<int> way1Evaluate,
      Value<String> way2Title,
      Value<int> way2Evaluate,
      Value<String> tags,
      Value<bool> favorite,
      Value<String> conclusion}) {
    return ComparisonOverviewRecordsCompanion(
      dataId: dataId ?? this.dataId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      itemTitle: itemTitle ?? this.itemTitle,
      way1Title: way1Title ?? this.way1Title,
      way1Demerit: way1Demerit ?? this.way1Demerit,
      way1Evaluate: way1Evaluate ?? this.way1Evaluate,
      way2Title: way2Title ?? this.way2Title,
      way2Evaluate: way2Evaluate ?? this.way2Evaluate,
      tags: tags ?? this.tags,
      favorite: favorite ?? this.favorite,
      conclusion: conclusion ?? this.conclusion,
    );
  }
}

class $ComparisonOverviewRecordsTable extends ComparisonOverviewRecords
    with TableInfo<$ComparisonOverviewRecordsTable, ComparisonOverviewRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $ComparisonOverviewRecordsTable(this._db, [this._alias]);
  final VerificationMeta _dataIdMeta = const VerificationMeta('dataId');
  GeneratedIntColumn _dataId;
  @override
  GeneratedIntColumn get dataId => _dataId ??= _constructDataId();
  GeneratedIntColumn _constructDataId() {
    return GeneratedIntColumn('data_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  GeneratedTextColumn _comparisonItemId;
  @override
  GeneratedTextColumn get comparisonItemId =>
      _comparisonItemId ??= _constructComparisonItemId();
  GeneratedTextColumn _constructComparisonItemId() {
    return GeneratedTextColumn(
      'comparison_item_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _itemTitleMeta = const VerificationMeta('itemTitle');
  GeneratedTextColumn _itemTitle;
  @override
  GeneratedTextColumn get itemTitle => _itemTitle ??= _constructItemTitle();
  GeneratedTextColumn _constructItemTitle() {
    return GeneratedTextColumn(
      'item_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _way1TitleMeta = const VerificationMeta('way1Title');
  GeneratedTextColumn _way1Title;
  @override
  GeneratedTextColumn get way1Title => _way1Title ??= _constructWay1Title();
  GeneratedTextColumn _constructWay1Title() {
    return GeneratedTextColumn(
      'way1_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _way1DemeritMeta =
      const VerificationMeta('way1Demerit');
  GeneratedTextColumn _way1Demerit;
  @override
  GeneratedTextColumn get way1Demerit =>
      _way1Demerit ??= _constructWay1Demerit();
  GeneratedTextColumn _constructWay1Demerit() {
    return GeneratedTextColumn(
      'way1_demerit',
      $tableName,
      true,
    );
  }

  final VerificationMeta _way1EvaluateMeta =
      const VerificationMeta('way1Evaluate');
  GeneratedIntColumn _way1Evaluate;
  @override
  GeneratedIntColumn get way1Evaluate =>
      _way1Evaluate ??= _constructWay1Evaluate();
  GeneratedIntColumn _constructWay1Evaluate() {
    return GeneratedIntColumn('way1_evaluate', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _way2TitleMeta = const VerificationMeta('way2Title');
  GeneratedTextColumn _way2Title;
  @override
  GeneratedTextColumn get way2Title => _way2Title ??= _constructWay2Title();
  GeneratedTextColumn _constructWay2Title() {
    return GeneratedTextColumn(
      'way2_title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _way2EvaluateMeta =
      const VerificationMeta('way2Evaluate');
  GeneratedIntColumn _way2Evaluate;
  @override
  GeneratedIntColumn get way2Evaluate =>
      _way2Evaluate ??= _constructWay2Evaluate();
  GeneratedIntColumn _constructWay2Evaluate() {
    return GeneratedIntColumn('way2_evaluate', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _tagsMeta = const VerificationMeta('tags');
  GeneratedTextColumn _tags;
  @override
  GeneratedTextColumn get tags => _tags ??= _constructTags();
  GeneratedTextColumn _constructTags() {
    return GeneratedTextColumn(
      'tags',
      $tableName,
      true,
    );
  }

  final VerificationMeta _favoriteMeta = const VerificationMeta('favorite');
  GeneratedBoolColumn _favorite;
  @override
  GeneratedBoolColumn get favorite => _favorite ??= _constructFavorite();
  GeneratedBoolColumn _constructFavorite() {
    return GeneratedBoolColumn('favorite', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _conclusionMeta = const VerificationMeta('conclusion');
  GeneratedTextColumn _conclusion;
  @override
  GeneratedTextColumn get conclusion => _conclusion ??= _constructConclusion();
  GeneratedTextColumn _constructConclusion() {
    return GeneratedTextColumn(
      'conclusion',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        dataId,
        comparisonItemId,
        itemTitle,
        way1Title,
        way1Demerit,
        way1Evaluate,
        way2Title,
        way2Evaluate,
        tags,
        favorite,
        conclusion
      ];
  @override
  $ComparisonOverviewRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'comparison_overview_records';
  @override
  final String actualTableName = 'comparison_overview_records';
  @override
  VerificationContext validateIntegrity(ComparisonOverviewRecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.dataId.present) {
      context.handle(
          _dataIdMeta, dataId.isAcceptableValue(d.dataId.value, _dataIdMeta));
    }
    if (d.comparisonItemId.present) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableValue(
              d.comparisonItemId.value, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (d.itemTitle.present) {
      context.handle(_itemTitleMeta,
          itemTitle.isAcceptableValue(d.itemTitle.value, _itemTitleMeta));
    } else if (isInserting) {
      context.missing(_itemTitleMeta);
    }
    if (d.way1Title.present) {
      context.handle(_way1TitleMeta,
          way1Title.isAcceptableValue(d.way1Title.value, _way1TitleMeta));
    } else if (isInserting) {
      context.missing(_way1TitleMeta);
    }
    if (d.way1Demerit.present) {
      context.handle(_way1DemeritMeta,
          way1Demerit.isAcceptableValue(d.way1Demerit.value, _way1DemeritMeta));
    }
    if (d.way1Evaluate.present) {
      context.handle(
          _way1EvaluateMeta,
          way1Evaluate.isAcceptableValue(
              d.way1Evaluate.value, _way1EvaluateMeta));
    }
    if (d.way2Title.present) {
      context.handle(_way2TitleMeta,
          way2Title.isAcceptableValue(d.way2Title.value, _way2TitleMeta));
    } else if (isInserting) {
      context.missing(_way2TitleMeta);
    }
    if (d.way2Evaluate.present) {
      context.handle(
          _way2EvaluateMeta,
          way2Evaluate.isAcceptableValue(
              d.way2Evaluate.value, _way2EvaluateMeta));
    }
    if (d.tags.present) {
      context.handle(
          _tagsMeta, tags.isAcceptableValue(d.tags.value, _tagsMeta));
    }
    if (d.favorite.present) {
      context.handle(_favoriteMeta,
          favorite.isAcceptableValue(d.favorite.value, _favoriteMeta));
    }
    if (d.conclusion.present) {
      context.handle(_conclusionMeta,
          conclusion.isAcceptableValue(d.conclusion.value, _conclusionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dataId};
  @override
  ComparisonOverviewRecord map(Map<String, dynamic> data,
      {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ComparisonOverviewRecord.fromData(data, _db,
        prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ComparisonOverviewRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.dataId.present) {
      map['data_id'] = Variable<int, IntType>(d.dataId.value);
    }
    if (d.comparisonItemId.present) {
      map['comparison_item_id'] =
          Variable<String, StringType>(d.comparisonItemId.value);
    }
    if (d.itemTitle.present) {
      map['item_title'] = Variable<String, StringType>(d.itemTitle.value);
    }
    if (d.way1Title.present) {
      map['way1_title'] = Variable<String, StringType>(d.way1Title.value);
    }
    if (d.way1Demerit.present) {
      map['way1_demerit'] = Variable<String, StringType>(d.way1Demerit.value);
    }
    if (d.way1Evaluate.present) {
      map['way1_evaluate'] = Variable<int, IntType>(d.way1Evaluate.value);
    }
    if (d.way2Title.present) {
      map['way2_title'] = Variable<String, StringType>(d.way2Title.value);
    }
    if (d.way2Evaluate.present) {
      map['way2_evaluate'] = Variable<int, IntType>(d.way2Evaluate.value);
    }
    if (d.tags.present) {
      map['tags'] = Variable<String, StringType>(d.tags.value);
    }
    if (d.favorite.present) {
      map['favorite'] = Variable<bool, BoolType>(d.favorite.value);
    }
    if (d.conclusion.present) {
      map['conclusion'] = Variable<String, StringType>(d.conclusion.value);
    }
    return map;
  }

  @override
  $ComparisonOverviewRecordsTable createAlias(String alias) {
    return $ComparisonOverviewRecordsTable(_db, alias);
  }
}

class Way1MeritRecord extends DataClass implements Insertable<Way1MeritRecord> {
  final int way1MeritId;
  final String comparisonItemId;
  final String way1MeritDesc;
  Way1MeritRecord(
      {@required this.way1MeritId,
      @required this.comparisonItemId,
      this.way1MeritDesc});
  factory Way1MeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Way1MeritRecord(
      way1MeritId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_merit_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
      way1MeritDesc: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_merit_desc']),
    );
  }
  factory Way1MeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way1MeritRecord(
      way1MeritId: serializer.fromJson<int>(json['way1MeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way1MeritDesc: serializer.fromJson<String>(json['way1MeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way1MeritId': serializer.toJson<int>(way1MeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way1MeritDesc': serializer.toJson<String>(way1MeritDesc),
    };
  }

  @override
  Way1MeritRecordsCompanion createCompanion(bool nullToAbsent) {
    return Way1MeritRecordsCompanion(
      way1MeritId: way1MeritId == null && nullToAbsent
          ? const Value.absent()
          : Value(way1MeritId),
      comparisonItemId: comparisonItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(comparisonItemId),
      way1MeritDesc: way1MeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way1MeritDesc),
    );
  }

  Way1MeritRecord copyWith(
          {int way1MeritId, String comparisonItemId, String way1MeritDesc}) =>
      Way1MeritRecord(
        way1MeritId: way1MeritId ?? this.way1MeritId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        way1MeritDesc: way1MeritDesc ?? this.way1MeritDesc,
      );
  @override
  String toString() {
    return (StringBuffer('Way1MeritRecord(')
          ..write('way1MeritId: $way1MeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way1MeritDesc: $way1MeritDesc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(way1MeritId.hashCode,
      $mrjc(comparisonItemId.hashCode, way1MeritDesc.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Way1MeritRecord &&
          other.way1MeritId == this.way1MeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way1MeritDesc == this.way1MeritDesc);
}

class Way1MeritRecordsCompanion extends UpdateCompanion<Way1MeritRecord> {
  final Value<int> way1MeritId;
  final Value<String> comparisonItemId;
  final Value<String> way1MeritDesc;
  const Way1MeritRecordsCompanion({
    this.way1MeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way1MeritDesc = const Value.absent(),
  });
  Way1MeritRecordsCompanion.insert({
    this.way1MeritId = const Value.absent(),
    @required String comparisonItemId,
    this.way1MeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  Way1MeritRecordsCompanion copyWith(
      {Value<int> way1MeritId,
      Value<String> comparisonItemId,
      Value<String> way1MeritDesc}) {
    return Way1MeritRecordsCompanion(
      way1MeritId: way1MeritId ?? this.way1MeritId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      way1MeritDesc: way1MeritDesc ?? this.way1MeritDesc,
    );
  }
}

class $Way1MeritRecordsTable extends Way1MeritRecords
    with TableInfo<$Way1MeritRecordsTable, Way1MeritRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $Way1MeritRecordsTable(this._db, [this._alias]);
  final VerificationMeta _way1MeritIdMeta =
      const VerificationMeta('way1MeritId');
  GeneratedIntColumn _way1MeritId;
  @override
  GeneratedIntColumn get way1MeritId =>
      _way1MeritId ??= _constructWay1MeritId();
  GeneratedIntColumn _constructWay1MeritId() {
    return GeneratedIntColumn('way1_merit_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  GeneratedTextColumn _comparisonItemId;
  @override
  GeneratedTextColumn get comparisonItemId =>
      _comparisonItemId ??= _constructComparisonItemId();
  GeneratedTextColumn _constructComparisonItemId() {
    return GeneratedTextColumn(
      'comparison_item_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _way1MeritDescMeta =
      const VerificationMeta('way1MeritDesc');
  GeneratedTextColumn _way1MeritDesc;
  @override
  GeneratedTextColumn get way1MeritDesc =>
      _way1MeritDesc ??= _constructWay1MeritDesc();
  GeneratedTextColumn _constructWay1MeritDesc() {
    return GeneratedTextColumn(
      'way1_merit_desc',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [way1MeritId, comparisonItemId, way1MeritDesc];
  @override
  $Way1MeritRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'way1_merit_records';
  @override
  final String actualTableName = 'way1_merit_records';
  @override
  VerificationContext validateIntegrity(Way1MeritRecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.way1MeritId.present) {
      context.handle(_way1MeritIdMeta,
          way1MeritId.isAcceptableValue(d.way1MeritId.value, _way1MeritIdMeta));
    }
    if (d.comparisonItemId.present) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableValue(
              d.comparisonItemId.value, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (d.way1MeritDesc.present) {
      context.handle(
          _way1MeritDescMeta,
          way1MeritDesc.isAcceptableValue(
              d.way1MeritDesc.value, _way1MeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way1MeritId};
  @override
  Way1MeritRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Way1MeritRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(Way1MeritRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.way1MeritId.present) {
      map['way1_merit_id'] = Variable<int, IntType>(d.way1MeritId.value);
    }
    if (d.comparisonItemId.present) {
      map['comparison_item_id'] =
          Variable<String, StringType>(d.comparisonItemId.value);
    }
    if (d.way1MeritDesc.present) {
      map['way1_merit_desc'] =
          Variable<String, StringType>(d.way1MeritDesc.value);
    }
    return map;
  }

  @override
  $Way1MeritRecordsTable createAlias(String alias) {
    return $Way1MeritRecordsTable(_db, alias);
  }
}

class Way1DemeritRecord extends DataClass
    implements Insertable<Way1DemeritRecord> {
  final int way1DemeritId;
  final String comparisonItemId;
  final String way1DemeritDesc;
  Way1DemeritRecord(
      {@required this.way1DemeritId,
      @required this.comparisonItemId,
      this.way1DemeritDesc});
  factory Way1DemeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Way1DemeritRecord(
      way1DemeritId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_demerit_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
      way1DemeritDesc: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_demerit_desc']),
    );
  }
  factory Way1DemeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way1DemeritRecord(
      way1DemeritId: serializer.fromJson<int>(json['way1DemeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way1DemeritDesc: serializer.fromJson<String>(json['way1DemeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way1DemeritId': serializer.toJson<int>(way1DemeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way1DemeritDesc': serializer.toJson<String>(way1DemeritDesc),
    };
  }

  @override
  Way1DemeritRecordsCompanion createCompanion(bool nullToAbsent) {
    return Way1DemeritRecordsCompanion(
      way1DemeritId: way1DemeritId == null && nullToAbsent
          ? const Value.absent()
          : Value(way1DemeritId),
      comparisonItemId: comparisonItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(comparisonItemId),
      way1DemeritDesc: way1DemeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way1DemeritDesc),
    );
  }

  Way1DemeritRecord copyWith(
          {int way1DemeritId,
          String comparisonItemId,
          String way1DemeritDesc}) =>
      Way1DemeritRecord(
        way1DemeritId: way1DemeritId ?? this.way1DemeritId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        way1DemeritDesc: way1DemeritDesc ?? this.way1DemeritDesc,
      );
  @override
  String toString() {
    return (StringBuffer('Way1DemeritRecord(')
          ..write('way1DemeritId: $way1DemeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way1DemeritDesc: $way1DemeritDesc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(way1DemeritId.hashCode,
      $mrjc(comparisonItemId.hashCode, way1DemeritDesc.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Way1DemeritRecord &&
          other.way1DemeritId == this.way1DemeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way1DemeritDesc == this.way1DemeritDesc);
}

class Way1DemeritRecordsCompanion extends UpdateCompanion<Way1DemeritRecord> {
  final Value<int> way1DemeritId;
  final Value<String> comparisonItemId;
  final Value<String> way1DemeritDesc;
  const Way1DemeritRecordsCompanion({
    this.way1DemeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way1DemeritDesc = const Value.absent(),
  });
  Way1DemeritRecordsCompanion.insert({
    this.way1DemeritId = const Value.absent(),
    @required String comparisonItemId,
    this.way1DemeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  Way1DemeritRecordsCompanion copyWith(
      {Value<int> way1DemeritId,
      Value<String> comparisonItemId,
      Value<String> way1DemeritDesc}) {
    return Way1DemeritRecordsCompanion(
      way1DemeritId: way1DemeritId ?? this.way1DemeritId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      way1DemeritDesc: way1DemeritDesc ?? this.way1DemeritDesc,
    );
  }
}

class $Way1DemeritRecordsTable extends Way1DemeritRecords
    with TableInfo<$Way1DemeritRecordsTable, Way1DemeritRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $Way1DemeritRecordsTable(this._db, [this._alias]);
  final VerificationMeta _way1DemeritIdMeta =
      const VerificationMeta('way1DemeritId');
  GeneratedIntColumn _way1DemeritId;
  @override
  GeneratedIntColumn get way1DemeritId =>
      _way1DemeritId ??= _constructWay1DemeritId();
  GeneratedIntColumn _constructWay1DemeritId() {
    return GeneratedIntColumn('way1_demerit_id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  GeneratedTextColumn _comparisonItemId;
  @override
  GeneratedTextColumn get comparisonItemId =>
      _comparisonItemId ??= _constructComparisonItemId();
  GeneratedTextColumn _constructComparisonItemId() {
    return GeneratedTextColumn(
      'comparison_item_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _way1DemeritDescMeta =
      const VerificationMeta('way1DemeritDesc');
  GeneratedTextColumn _way1DemeritDesc;
  @override
  GeneratedTextColumn get way1DemeritDesc =>
      _way1DemeritDesc ??= _constructWay1DemeritDesc();
  GeneratedTextColumn _constructWay1DemeritDesc() {
    return GeneratedTextColumn(
      'way1_demerit_desc',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [way1DemeritId, comparisonItemId, way1DemeritDesc];
  @override
  $Way1DemeritRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'way1_demerit_records';
  @override
  final String actualTableName = 'way1_demerit_records';
  @override
  VerificationContext validateIntegrity(Way1DemeritRecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.way1DemeritId.present) {
      context.handle(
          _way1DemeritIdMeta,
          way1DemeritId.isAcceptableValue(
              d.way1DemeritId.value, _way1DemeritIdMeta));
    }
    if (d.comparisonItemId.present) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableValue(
              d.comparisonItemId.value, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (d.way1DemeritDesc.present) {
      context.handle(
          _way1DemeritDescMeta,
          way1DemeritDesc.isAcceptableValue(
              d.way1DemeritDesc.value, _way1DemeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way1DemeritId};
  @override
  Way1DemeritRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Way1DemeritRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(Way1DemeritRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.way1DemeritId.present) {
      map['way1_demerit_id'] = Variable<int, IntType>(d.way1DemeritId.value);
    }
    if (d.comparisonItemId.present) {
      map['comparison_item_id'] =
          Variable<String, StringType>(d.comparisonItemId.value);
    }
    if (d.way1DemeritDesc.present) {
      map['way1_demerit_desc'] =
          Variable<String, StringType>(d.way1DemeritDesc.value);
    }
    return map;
  }

  @override
  $Way1DemeritRecordsTable createAlias(String alias) {
    return $Way1DemeritRecordsTable(_db, alias);
  }
}

class TagOverviewRecord extends DataClass
    implements Insertable<TagOverviewRecord> {
  final String tagId;
  final String tagTitle;
  TagOverviewRecord({@required this.tagId, @required this.tagTitle});
  factory TagOverviewRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return TagOverviewRecord(
      tagId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
      tagTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_title']),
    );
  }
  factory TagOverviewRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TagOverviewRecord(
      tagId: serializer.fromJson<String>(json['tagId']),
      tagTitle: serializer.fromJson<String>(json['tagTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<String>(tagId),
      'tagTitle': serializer.toJson<String>(tagTitle),
    };
  }

  @override
  TagOverviewRecordsCompanion createCompanion(bool nullToAbsent) {
    return TagOverviewRecordsCompanion(
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
      tagTitle: tagTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(tagTitle),
    );
  }

  TagOverviewRecord copyWith({String tagId, String tagTitle}) =>
      TagOverviewRecord(
        tagId: tagId ?? this.tagId,
        tagTitle: tagTitle ?? this.tagTitle,
      );
  @override
  String toString() {
    return (StringBuffer('TagOverviewRecord(')
          ..write('tagId: $tagId, ')
          ..write('tagTitle: $tagTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(tagId.hashCode, tagTitle.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TagOverviewRecord &&
          other.tagId == this.tagId &&
          other.tagTitle == this.tagTitle);
}

class TagOverviewRecordsCompanion extends UpdateCompanion<TagOverviewRecord> {
  final Value<String> tagId;
  final Value<String> tagTitle;
  const TagOverviewRecordsCompanion({
    this.tagId = const Value.absent(),
    this.tagTitle = const Value.absent(),
  });
  TagOverviewRecordsCompanion.insert({
    @required String tagId,
    @required String tagTitle,
  })  : tagId = Value(tagId),
        tagTitle = Value(tagTitle);
  TagOverviewRecordsCompanion copyWith(
      {Value<String> tagId, Value<String> tagTitle}) {
    return TagOverviewRecordsCompanion(
      tagId: tagId ?? this.tagId,
      tagTitle: tagTitle ?? this.tagTitle,
    );
  }
}

class $TagOverviewRecordsTable extends TagOverviewRecords
    with TableInfo<$TagOverviewRecordsTable, TagOverviewRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagOverviewRecordsTable(this._db, [this._alias]);
  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedTextColumn _tagId;
  @override
  GeneratedTextColumn get tagId => _tagId ??= _constructTagId();
  GeneratedTextColumn _constructTagId() {
    return GeneratedTextColumn(
      'tag_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _tagTitleMeta = const VerificationMeta('tagTitle');
  GeneratedTextColumn _tagTitle;
  @override
  GeneratedTextColumn get tagTitle => _tagTitle ??= _constructTagTitle();
  GeneratedTextColumn _constructTagTitle() {
    return GeneratedTextColumn(
      'tag_title',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [tagId, tagTitle];
  @override
  $TagOverviewRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tag_overview_records';
  @override
  final String actualTableName = 'tag_overview_records';
  @override
  VerificationContext validateIntegrity(TagOverviewRecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.tagId.present) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableValue(d.tagId.value, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (d.tagTitle.present) {
      context.handle(_tagTitleMeta,
          tagTitle.isAcceptableValue(d.tagTitle.value, _tagTitleMeta));
    } else if (isInserting) {
      context.missing(_tagTitleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  TagOverviewRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TagOverviewRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(TagOverviewRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.tagId.present) {
      map['tag_id'] = Variable<String, StringType>(d.tagId.value);
    }
    if (d.tagTitle.present) {
      map['tag_title'] = Variable<String, StringType>(d.tagTitle.value);
    }
    return map;
  }

  @override
  $TagOverviewRecordsTable createAlias(String alias) {
    return $TagOverviewRecordsTable(_db, alias);
  }
}

class ComparisonItemIdRecord extends DataClass
    implements Insertable<ComparisonItemIdRecord> {
  final String tagId;
  final String comparisonItemId;
  ComparisonItemIdRecord(
      {@required this.tagId, @required this.comparisonItemId});
  factory ComparisonItemIdRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return ComparisonItemIdRecord(
      tagId:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
    );
  }
  factory ComparisonItemIdRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return ComparisonItemIdRecord(
      tagId: serializer.fromJson<String>(json['tagId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<String>(tagId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
    };
  }

  @override
  ComparisonItemIdRecordsCompanion createCompanion(bool nullToAbsent) {
    return ComparisonItemIdRecordsCompanion(
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
      comparisonItemId: comparisonItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(comparisonItemId),
    );
  }

  ComparisonItemIdRecord copyWith({String tagId, String comparisonItemId}) =>
      ComparisonItemIdRecord(
        tagId: tagId ?? this.tagId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      );
  @override
  String toString() {
    return (StringBuffer('ComparisonItemIdRecord(')
          ..write('tagId: $tagId, ')
          ..write('comparisonItemId: $comparisonItemId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(tagId.hashCode, comparisonItemId.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ComparisonItemIdRecord &&
          other.tagId == this.tagId &&
          other.comparisonItemId == this.comparisonItemId);
}

class ComparisonItemIdRecordsCompanion
    extends UpdateCompanion<ComparisonItemIdRecord> {
  final Value<String> tagId;
  final Value<String> comparisonItemId;
  const ComparisonItemIdRecordsCompanion({
    this.tagId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
  });
  ComparisonItemIdRecordsCompanion.insert({
    @required String tagId,
    @required String comparisonItemId,
  })  : tagId = Value(tagId),
        comparisonItemId = Value(comparisonItemId);
  ComparisonItemIdRecordsCompanion copyWith(
      {Value<String> tagId, Value<String> comparisonItemId}) {
    return ComparisonItemIdRecordsCompanion(
      tagId: tagId ?? this.tagId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
    );
  }
}

class $ComparisonItemIdRecordsTable extends ComparisonItemIdRecords
    with TableInfo<$ComparisonItemIdRecordsTable, ComparisonItemIdRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $ComparisonItemIdRecordsTable(this._db, [this._alias]);
  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedTextColumn _tagId;
  @override
  GeneratedTextColumn get tagId => _tagId ??= _constructTagId();
  GeneratedTextColumn _constructTagId() {
    return GeneratedTextColumn(
      'tag_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  GeneratedTextColumn _comparisonItemId;
  @override
  GeneratedTextColumn get comparisonItemId =>
      _comparisonItemId ??= _constructComparisonItemId();
  GeneratedTextColumn _constructComparisonItemId() {
    return GeneratedTextColumn(
      'comparison_item_id',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [tagId, comparisonItemId];
  @override
  $ComparisonItemIdRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'comparison_item_id_records';
  @override
  final String actualTableName = 'comparison_item_id_records';
  @override
  VerificationContext validateIntegrity(ComparisonItemIdRecordsCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.tagId.present) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableValue(d.tagId.value, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (d.comparisonItemId.present) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableValue(
              d.comparisonItemId.value, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  ComparisonItemIdRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return ComparisonItemIdRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(ComparisonItemIdRecordsCompanion d) {
    final map = <String, Variable>{};
    if (d.tagId.present) {
      map['tag_id'] = Variable<String, StringType>(d.tagId.value);
    }
    if (d.comparisonItemId.present) {
      map['comparison_item_id'] =
          Variable<String, StringType>(d.comparisonItemId.value);
    }
    return map;
  }

  @override
  $ComparisonItemIdRecordsTable createAlias(String alias) {
    return $ComparisonItemIdRecordsTable(_db, alias);
  }
}

abstract class _$ComparisonItemDB extends GeneratedDatabase {
  _$ComparisonItemDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $ComparisonOverviewRecordsTable _comparisonOverviewRecords;
  $ComparisonOverviewRecordsTable get comparisonOverviewRecords =>
      _comparisonOverviewRecords ??= $ComparisonOverviewRecordsTable(this);
  $Way1MeritRecordsTable _way1MeritRecords;
  $Way1MeritRecordsTable get way1MeritRecords =>
      _way1MeritRecords ??= $Way1MeritRecordsTable(this);
  $Way1DemeritRecordsTable _way1DemeritRecords;
  $Way1DemeritRecordsTable get way1DemeritRecords =>
      _way1DemeritRecords ??= $Way1DemeritRecordsTable(this);
  $TagOverviewRecordsTable _tagOverviewRecords;
  $TagOverviewRecordsTable get tagOverviewRecords =>
      _tagOverviewRecords ??= $TagOverviewRecordsTable(this);
  $ComparisonItemIdRecordsTable _comparisonItemIdRecords;
  $ComparisonItemIdRecordsTable get comparisonItemIdRecords =>
      _comparisonItemIdRecords ??= $ComparisonItemIdRecordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        comparisonOverviewRecords,
        way1MeritRecords,
        way1DemeritRecords,
        tagOverviewRecords,
        comparisonItemIdRecords
      ];
}
