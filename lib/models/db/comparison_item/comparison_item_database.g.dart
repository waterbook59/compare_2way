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
  final int way1MeritEvaluate;
  final int way1DemeritEvaluate;
  final String way2Title;
  final int way2MeritEvaluate;
  final int way2DemeritEvaluate;
  final bool favorite;
  final String conclusion;
  final DateTime createdAt;
  ComparisonOverviewRecord(
      {@required this.dataId,
      @required this.comparisonItemId,
      @required this.itemTitle,
      @required this.way1Title,
      @required this.way1MeritEvaluate,
      @required this.way1DemeritEvaluate,
      @required this.way2Title,
      @required this.way2MeritEvaluate,
      @required this.way2DemeritEvaluate,
      @required this.favorite,
      this.conclusion,
      this.createdAt});
  factory ComparisonOverviewRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return ComparisonOverviewRecord(
      dataId:
          intType.mapFromDatabaseResponse(data['${effectivePrefix}data_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
      itemTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}item_title']),
      way1Title: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_title']),
      way1MeritEvaluate: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}way1_merit_evaluate']),
      way1DemeritEvaluate: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}way1_demerit_evaluate']),
      way2Title: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_title']),
      way2MeritEvaluate: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}way2_merit_evaluate']),
      way2DemeritEvaluate: intType.mapFromDatabaseResponse(
          data['${effectivePrefix}way2_demerit_evaluate']),
      favorite:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}favorite']),
      conclusion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}conclusion']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || dataId != null) {
      map['data_id'] = Variable<int>(dataId);
    }
    if (!nullToAbsent || comparisonItemId != null) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId);
    }
    if (!nullToAbsent || itemTitle != null) {
      map['item_title'] = Variable<String>(itemTitle);
    }
    if (!nullToAbsent || way1Title != null) {
      map['way1_title'] = Variable<String>(way1Title);
    }
    if (!nullToAbsent || way1MeritEvaluate != null) {
      map['way1_merit_evaluate'] = Variable<int>(way1MeritEvaluate);
    }
    if (!nullToAbsent || way1DemeritEvaluate != null) {
      map['way1_demerit_evaluate'] = Variable<int>(way1DemeritEvaluate);
    }
    if (!nullToAbsent || way2Title != null) {
      map['way2_title'] = Variable<String>(way2Title);
    }
    if (!nullToAbsent || way2MeritEvaluate != null) {
      map['way2_merit_evaluate'] = Variable<int>(way2MeritEvaluate);
    }
    if (!nullToAbsent || way2DemeritEvaluate != null) {
      map['way2_demerit_evaluate'] = Variable<int>(way2DemeritEvaluate);
    }
    if (!nullToAbsent || favorite != null) {
      map['favorite'] = Variable<bool>(favorite);
    }
    if (!nullToAbsent || conclusion != null) {
      map['conclusion'] = Variable<String>(conclusion);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  ComparisonOverviewRecordsCompanion toCompanion(bool nullToAbsent) {
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
      way1MeritEvaluate: way1MeritEvaluate == null && nullToAbsent
          ? const Value.absent()
          : Value(way1MeritEvaluate),
      way1DemeritEvaluate: way1DemeritEvaluate == null && nullToAbsent
          ? const Value.absent()
          : Value(way1DemeritEvaluate),
      way2Title: way2Title == null && nullToAbsent
          ? const Value.absent()
          : Value(way2Title),
      way2MeritEvaluate: way2MeritEvaluate == null && nullToAbsent
          ? const Value.absent()
          : Value(way2MeritEvaluate),
      way2DemeritEvaluate: way2DemeritEvaluate == null && nullToAbsent
          ? const Value.absent()
          : Value(way2DemeritEvaluate),
      favorite: favorite == null && nullToAbsent
          ? const Value.absent()
          : Value(favorite),
      conclusion: conclusion == null && nullToAbsent
          ? const Value.absent()
          : Value(conclusion),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
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
      way1MeritEvaluate: serializer.fromJson<int>(json['way1MeritEvaluate']),
      way1DemeritEvaluate:
          serializer.fromJson<int>(json['way1DemeritEvaluate']),
      way2Title: serializer.fromJson<String>(json['way2Title']),
      way2MeritEvaluate: serializer.fromJson<int>(json['way2MeritEvaluate']),
      way2DemeritEvaluate:
          serializer.fromJson<int>(json['way2DemeritEvaluate']),
      favorite: serializer.fromJson<bool>(json['favorite']),
      conclusion: serializer.fromJson<String>(json['conclusion']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
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
      'way1MeritEvaluate': serializer.toJson<int>(way1MeritEvaluate),
      'way1DemeritEvaluate': serializer.toJson<int>(way1DemeritEvaluate),
      'way2Title': serializer.toJson<String>(way2Title),
      'way2MeritEvaluate': serializer.toJson<int>(way2MeritEvaluate),
      'way2DemeritEvaluate': serializer.toJson<int>(way2DemeritEvaluate),
      'favorite': serializer.toJson<bool>(favorite),
      'conclusion': serializer.toJson<String>(conclusion),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ComparisonOverviewRecord copyWith(
          {int dataId,
          String comparisonItemId,
          String itemTitle,
          String way1Title,
          int way1MeritEvaluate,
          int way1DemeritEvaluate,
          String way2Title,
          int way2MeritEvaluate,
          int way2DemeritEvaluate,
          bool favorite,
          String conclusion,
          DateTime createdAt}) =>
      ComparisonOverviewRecord(
        dataId: dataId ?? this.dataId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        itemTitle: itemTitle ?? this.itemTitle,
        way1Title: way1Title ?? this.way1Title,
        way1MeritEvaluate: way1MeritEvaluate ?? this.way1MeritEvaluate,
        way1DemeritEvaluate: way1DemeritEvaluate ?? this.way1DemeritEvaluate,
        way2Title: way2Title ?? this.way2Title,
        way2MeritEvaluate: way2MeritEvaluate ?? this.way2MeritEvaluate,
        way2DemeritEvaluate: way2DemeritEvaluate ?? this.way2DemeritEvaluate,
        favorite: favorite ?? this.favorite,
        conclusion: conclusion ?? this.conclusion,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('ComparisonOverviewRecord(')
          ..write('dataId: $dataId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('itemTitle: $itemTitle, ')
          ..write('way1Title: $way1Title, ')
          ..write('way1MeritEvaluate: $way1MeritEvaluate, ')
          ..write('way1DemeritEvaluate: $way1DemeritEvaluate, ')
          ..write('way2Title: $way2Title, ')
          ..write('way2MeritEvaluate: $way2MeritEvaluate, ')
          ..write('way2DemeritEvaluate: $way2DemeritEvaluate, ')
          ..write('favorite: $favorite, ')
          ..write('conclusion: $conclusion, ')
          ..write('createdAt: $createdAt')
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
                      way1MeritEvaluate.hashCode,
                      $mrjc(
                          way1DemeritEvaluate.hashCode,
                          $mrjc(
                              way2Title.hashCode,
                              $mrjc(
                                  way2MeritEvaluate.hashCode,
                                  $mrjc(
                                      way2DemeritEvaluate.hashCode,
                                      $mrjc(
                                          favorite.hashCode,
                                          $mrjc(conclusion.hashCode,
                                              createdAt.hashCode))))))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is ComparisonOverviewRecord &&
          other.dataId == this.dataId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.itemTitle == this.itemTitle &&
          other.way1Title == this.way1Title &&
          other.way1MeritEvaluate == this.way1MeritEvaluate &&
          other.way1DemeritEvaluate == this.way1DemeritEvaluate &&
          other.way2Title == this.way2Title &&
          other.way2MeritEvaluate == this.way2MeritEvaluate &&
          other.way2DemeritEvaluate == this.way2DemeritEvaluate &&
          other.favorite == this.favorite &&
          other.conclusion == this.conclusion &&
          other.createdAt == this.createdAt);
}

class ComparisonOverviewRecordsCompanion
    extends UpdateCompanion<ComparisonOverviewRecord> {
  final Value<int> dataId;
  final Value<String> comparisonItemId;
  final Value<String> itemTitle;
  final Value<String> way1Title;
  final Value<int> way1MeritEvaluate;
  final Value<int> way1DemeritEvaluate;
  final Value<String> way2Title;
  final Value<int> way2MeritEvaluate;
  final Value<int> way2DemeritEvaluate;
  final Value<bool> favorite;
  final Value<String> conclusion;
  final Value<DateTime> createdAt;
  const ComparisonOverviewRecordsCompanion({
    this.dataId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.itemTitle = const Value.absent(),
    this.way1Title = const Value.absent(),
    this.way1MeritEvaluate = const Value.absent(),
    this.way1DemeritEvaluate = const Value.absent(),
    this.way2Title = const Value.absent(),
    this.way2MeritEvaluate = const Value.absent(),
    this.way2DemeritEvaluate = const Value.absent(),
    this.favorite = const Value.absent(),
    this.conclusion = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ComparisonOverviewRecordsCompanion.insert({
    this.dataId = const Value.absent(),
    @required String comparisonItemId,
    @required String itemTitle,
    @required String way1Title,
    this.way1MeritEvaluate = const Value.absent(),
    this.way1DemeritEvaluate = const Value.absent(),
    @required String way2Title,
    this.way2MeritEvaluate = const Value.absent(),
    this.way2DemeritEvaluate = const Value.absent(),
    this.favorite = const Value.absent(),
    this.conclusion = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : comparisonItemId = Value(comparisonItemId),
        itemTitle = Value(itemTitle),
        way1Title = Value(way1Title),
        way2Title = Value(way2Title);
  static Insertable<ComparisonOverviewRecord> custom({
    Expression<int> dataId,
    Expression<String> comparisonItemId,
    Expression<String> itemTitle,
    Expression<String> way1Title,
    Expression<int> way1MeritEvaluate,
    Expression<int> way1DemeritEvaluate,
    Expression<String> way2Title,
    Expression<int> way2MeritEvaluate,
    Expression<int> way2DemeritEvaluate,
    Expression<bool> favorite,
    Expression<String> conclusion,
    Expression<DateTime> createdAt,
  }) {
    return RawValuesInsertable({
      if (dataId != null) 'data_id': dataId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (itemTitle != null) 'item_title': itemTitle,
      if (way1Title != null) 'way1_title': way1Title,
      if (way1MeritEvaluate != null) 'way1_merit_evaluate': way1MeritEvaluate,
      if (way1DemeritEvaluate != null)
        'way1_demerit_evaluate': way1DemeritEvaluate,
      if (way2Title != null) 'way2_title': way2Title,
      if (way2MeritEvaluate != null) 'way2_merit_evaluate': way2MeritEvaluate,
      if (way2DemeritEvaluate != null)
        'way2_demerit_evaluate': way2DemeritEvaluate,
      if (favorite != null) 'favorite': favorite,
      if (conclusion != null) 'conclusion': conclusion,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ComparisonOverviewRecordsCompanion copyWith(
      {Value<int> dataId,
      Value<String> comparisonItemId,
      Value<String> itemTitle,
      Value<String> way1Title,
      Value<int> way1MeritEvaluate,
      Value<int> way1DemeritEvaluate,
      Value<String> way2Title,
      Value<int> way2MeritEvaluate,
      Value<int> way2DemeritEvaluate,
      Value<bool> favorite,
      Value<String> conclusion,
      Value<DateTime> createdAt}) {
    return ComparisonOverviewRecordsCompanion(
      dataId: dataId ?? this.dataId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      itemTitle: itemTitle ?? this.itemTitle,
      way1Title: way1Title ?? this.way1Title,
      way1MeritEvaluate: way1MeritEvaluate ?? this.way1MeritEvaluate,
      way1DemeritEvaluate: way1DemeritEvaluate ?? this.way1DemeritEvaluate,
      way2Title: way2Title ?? this.way2Title,
      way2MeritEvaluate: way2MeritEvaluate ?? this.way2MeritEvaluate,
      way2DemeritEvaluate: way2DemeritEvaluate ?? this.way2DemeritEvaluate,
      favorite: favorite ?? this.favorite,
      conclusion: conclusion ?? this.conclusion,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dataId.present) {
      map['data_id'] = Variable<int>(dataId.value);
    }
    if (comparisonItemId.present) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId.value);
    }
    if (itemTitle.present) {
      map['item_title'] = Variable<String>(itemTitle.value);
    }
    if (way1Title.present) {
      map['way1_title'] = Variable<String>(way1Title.value);
    }
    if (way1MeritEvaluate.present) {
      map['way1_merit_evaluate'] = Variable<int>(way1MeritEvaluate.value);
    }
    if (way1DemeritEvaluate.present) {
      map['way1_demerit_evaluate'] = Variable<int>(way1DemeritEvaluate.value);
    }
    if (way2Title.present) {
      map['way2_title'] = Variable<String>(way2Title.value);
    }
    if (way2MeritEvaluate.present) {
      map['way2_merit_evaluate'] = Variable<int>(way2MeritEvaluate.value);
    }
    if (way2DemeritEvaluate.present) {
      map['way2_demerit_evaluate'] = Variable<int>(way2DemeritEvaluate.value);
    }
    if (favorite.present) {
      map['favorite'] = Variable<bool>(favorite.value);
    }
    if (conclusion.present) {
      map['conclusion'] = Variable<String>(conclusion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComparisonOverviewRecordsCompanion(')
          ..write('dataId: $dataId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('itemTitle: $itemTitle, ')
          ..write('way1Title: $way1Title, ')
          ..write('way1MeritEvaluate: $way1MeritEvaluate, ')
          ..write('way1DemeritEvaluate: $way1DemeritEvaluate, ')
          ..write('way2Title: $way2Title, ')
          ..write('way2MeritEvaluate: $way2MeritEvaluate, ')
          ..write('way2DemeritEvaluate: $way2DemeritEvaluate, ')
          ..write('favorite: $favorite, ')
          ..write('conclusion: $conclusion, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
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

  final VerificationMeta _way1MeritEvaluateMeta =
      const VerificationMeta('way1MeritEvaluate');
  GeneratedIntColumn _way1MeritEvaluate;
  @override
  GeneratedIntColumn get way1MeritEvaluate =>
      _way1MeritEvaluate ??= _constructWay1MeritEvaluate();
  GeneratedIntColumn _constructWay1MeritEvaluate() {
    return GeneratedIntColumn('way1_merit_evaluate', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _way1DemeritEvaluateMeta =
      const VerificationMeta('way1DemeritEvaluate');
  GeneratedIntColumn _way1DemeritEvaluate;
  @override
  GeneratedIntColumn get way1DemeritEvaluate =>
      _way1DemeritEvaluate ??= _constructWay1DemeritEvaluate();
  GeneratedIntColumn _constructWay1DemeritEvaluate() {
    return GeneratedIntColumn('way1_demerit_evaluate', $tableName, false,
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

  final VerificationMeta _way2MeritEvaluateMeta =
      const VerificationMeta('way2MeritEvaluate');
  GeneratedIntColumn _way2MeritEvaluate;
  @override
  GeneratedIntColumn get way2MeritEvaluate =>
      _way2MeritEvaluate ??= _constructWay2MeritEvaluate();
  GeneratedIntColumn _constructWay2MeritEvaluate() {
    return GeneratedIntColumn('way2_merit_evaluate', $tableName, false,
        defaultValue: const Constant(0));
  }

  final VerificationMeta _way2DemeritEvaluateMeta =
      const VerificationMeta('way2DemeritEvaluate');
  GeneratedIntColumn _way2DemeritEvaluate;
  @override
  GeneratedIntColumn get way2DemeritEvaluate =>
      _way2DemeritEvaluate ??= _constructWay2DemeritEvaluate();
  GeneratedIntColumn _constructWay2DemeritEvaluate() {
    return GeneratedIntColumn('way2_demerit_evaluate', $tableName, false,
        defaultValue: const Constant(0));
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

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
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
        way1MeritEvaluate,
        way1DemeritEvaluate,
        way2Title,
        way2MeritEvaluate,
        way2DemeritEvaluate,
        favorite,
        conclusion,
        createdAt
      ];
  @override
  $ComparisonOverviewRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'comparison_overview_records';
  @override
  final String actualTableName = 'comparison_overview_records';
  @override
  VerificationContext validateIntegrity(
      Insertable<ComparisonOverviewRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('data_id')) {
      context.handle(_dataIdMeta,
          dataId.isAcceptableOrUnknown(data['data_id'], _dataIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id'], _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('item_title')) {
      context.handle(_itemTitleMeta,
          itemTitle.isAcceptableOrUnknown(data['item_title'], _itemTitleMeta));
    } else if (isInserting) {
      context.missing(_itemTitleMeta);
    }
    if (data.containsKey('way1_title')) {
      context.handle(_way1TitleMeta,
          way1Title.isAcceptableOrUnknown(data['way1_title'], _way1TitleMeta));
    } else if (isInserting) {
      context.missing(_way1TitleMeta);
    }
    if (data.containsKey('way1_merit_evaluate')) {
      context.handle(
          _way1MeritEvaluateMeta,
          way1MeritEvaluate.isAcceptableOrUnknown(
              data['way1_merit_evaluate'], _way1MeritEvaluateMeta));
    }
    if (data.containsKey('way1_demerit_evaluate')) {
      context.handle(
          _way1DemeritEvaluateMeta,
          way1DemeritEvaluate.isAcceptableOrUnknown(
              data['way1_demerit_evaluate'], _way1DemeritEvaluateMeta));
    }
    if (data.containsKey('way2_title')) {
      context.handle(_way2TitleMeta,
          way2Title.isAcceptableOrUnknown(data['way2_title'], _way2TitleMeta));
    } else if (isInserting) {
      context.missing(_way2TitleMeta);
    }
    if (data.containsKey('way2_merit_evaluate')) {
      context.handle(
          _way2MeritEvaluateMeta,
          way2MeritEvaluate.isAcceptableOrUnknown(
              data['way2_merit_evaluate'], _way2MeritEvaluateMeta));
    }
    if (data.containsKey('way2_demerit_evaluate')) {
      context.handle(
          _way2DemeritEvaluateMeta,
          way2DemeritEvaluate.isAcceptableOrUnknown(
              data['way2_demerit_evaluate'], _way2DemeritEvaluateMeta));
    }
    if (data.containsKey('favorite')) {
      context.handle(_favoriteMeta,
          favorite.isAcceptableOrUnknown(data['favorite'], _favoriteMeta));
    }
    if (data.containsKey('conclusion')) {
      context.handle(
          _conclusionMeta,
          conclusion.isAcceptableOrUnknown(
              data['conclusion'], _conclusionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || way1MeritId != null) {
      map['way1_merit_id'] = Variable<int>(way1MeritId);
    }
    if (!nullToAbsent || comparisonItemId != null) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId);
    }
    if (!nullToAbsent || way1MeritDesc != null) {
      map['way1_merit_desc'] = Variable<String>(way1MeritDesc);
    }
    return map;
  }

  Way1MeritRecordsCompanion toCompanion(bool nullToAbsent) {
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
  static Insertable<Way1MeritRecord> custom({
    Expression<int> way1MeritId,
    Expression<String> comparisonItemId,
    Expression<String> way1MeritDesc,
  }) {
    return RawValuesInsertable({
      if (way1MeritId != null) 'way1_merit_id': way1MeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way1MeritDesc != null) 'way1_merit_desc': way1MeritDesc,
    });
  }

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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (way1MeritId.present) {
      map['way1_merit_id'] = Variable<int>(way1MeritId.value);
    }
    if (comparisonItemId.present) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId.value);
    }
    if (way1MeritDesc.present) {
      map['way1_merit_desc'] = Variable<String>(way1MeritDesc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Way1MeritRecordsCompanion(')
          ..write('way1MeritId: $way1MeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way1MeritDesc: $way1MeritDesc')
          ..write(')'))
        .toString();
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
  VerificationContext validateIntegrity(Insertable<Way1MeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way1_merit_id')) {
      context.handle(
          _way1MeritIdMeta,
          way1MeritId.isAcceptableOrUnknown(
              data['way1_merit_id'], _way1MeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id'], _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way1_merit_desc')) {
      context.handle(
          _way1MeritDescMeta,
          way1MeritDesc.isAcceptableOrUnknown(
              data['way1_merit_desc'], _way1MeritDescMeta));
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || way1DemeritId != null) {
      map['way1_demerit_id'] = Variable<int>(way1DemeritId);
    }
    if (!nullToAbsent || comparisonItemId != null) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId);
    }
    if (!nullToAbsent || way1DemeritDesc != null) {
      map['way1_demerit_desc'] = Variable<String>(way1DemeritDesc);
    }
    return map;
  }

  Way1DemeritRecordsCompanion toCompanion(bool nullToAbsent) {
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
  static Insertable<Way1DemeritRecord> custom({
    Expression<int> way1DemeritId,
    Expression<String> comparisonItemId,
    Expression<String> way1DemeritDesc,
  }) {
    return RawValuesInsertable({
      if (way1DemeritId != null) 'way1_demerit_id': way1DemeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way1DemeritDesc != null) 'way1_demerit_desc': way1DemeritDesc,
    });
  }

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

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (way1DemeritId.present) {
      map['way1_demerit_id'] = Variable<int>(way1DemeritId.value);
    }
    if (comparisonItemId.present) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId.value);
    }
    if (way1DemeritDesc.present) {
      map['way1_demerit_desc'] = Variable<String>(way1DemeritDesc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Way1DemeritRecordsCompanion(')
          ..write('way1DemeritId: $way1DemeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way1DemeritDesc: $way1DemeritDesc')
          ..write(')'))
        .toString();
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
  VerificationContext validateIntegrity(Insertable<Way1DemeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way1_demerit_id')) {
      context.handle(
          _way1DemeritIdMeta,
          way1DemeritId.isAcceptableOrUnknown(
              data['way1_demerit_id'], _way1DemeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id'], _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way1_demerit_desc')) {
      context.handle(
          _way1DemeritDescMeta,
          way1DemeritDesc.isAcceptableOrUnknown(
              data['way1_demerit_desc'], _way1DemeritDescMeta));
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
  $Way1DemeritRecordsTable createAlias(String alias) {
    return $Way1DemeritRecordsTable(_db, alias);
  }
}

class Way2MeritRecord extends DataClass implements Insertable<Way2MeritRecord> {
  final int way2MeritId;
  final String comparisonItemId;
  final String way2MeritDesc;
  Way2MeritRecord(
      {@required this.way2MeritId,
      @required this.comparisonItemId,
      this.way2MeritDesc});
  factory Way2MeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Way2MeritRecord(
      way2MeritId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_merit_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
      way2MeritDesc: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_merit_desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || way2MeritId != null) {
      map['way2_merit_id'] = Variable<int>(way2MeritId);
    }
    if (!nullToAbsent || comparisonItemId != null) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId);
    }
    if (!nullToAbsent || way2MeritDesc != null) {
      map['way2_merit_desc'] = Variable<String>(way2MeritDesc);
    }
    return map;
  }

  Way2MeritRecordsCompanion toCompanion(bool nullToAbsent) {
    return Way2MeritRecordsCompanion(
      way2MeritId: way2MeritId == null && nullToAbsent
          ? const Value.absent()
          : Value(way2MeritId),
      comparisonItemId: comparisonItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(comparisonItemId),
      way2MeritDesc: way2MeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way2MeritDesc),
    );
  }

  factory Way2MeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way2MeritRecord(
      way2MeritId: serializer.fromJson<int>(json['way2MeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way2MeritDesc: serializer.fromJson<String>(json['way2MeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way2MeritId': serializer.toJson<int>(way2MeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way2MeritDesc': serializer.toJson<String>(way2MeritDesc),
    };
  }

  Way2MeritRecord copyWith(
          {int way2MeritId, String comparisonItemId, String way2MeritDesc}) =>
      Way2MeritRecord(
        way2MeritId: way2MeritId ?? this.way2MeritId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        way2MeritDesc: way2MeritDesc ?? this.way2MeritDesc,
      );
  @override
  String toString() {
    return (StringBuffer('Way2MeritRecord(')
          ..write('way2MeritId: $way2MeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way2MeritDesc: $way2MeritDesc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(way2MeritId.hashCode,
      $mrjc(comparisonItemId.hashCode, way2MeritDesc.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Way2MeritRecord &&
          other.way2MeritId == this.way2MeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way2MeritDesc == this.way2MeritDesc);
}

class Way2MeritRecordsCompanion extends UpdateCompanion<Way2MeritRecord> {
  final Value<int> way2MeritId;
  final Value<String> comparisonItemId;
  final Value<String> way2MeritDesc;
  const Way2MeritRecordsCompanion({
    this.way2MeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way2MeritDesc = const Value.absent(),
  });
  Way2MeritRecordsCompanion.insert({
    this.way2MeritId = const Value.absent(),
    @required String comparisonItemId,
    this.way2MeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  static Insertable<Way2MeritRecord> custom({
    Expression<int> way2MeritId,
    Expression<String> comparisonItemId,
    Expression<String> way2MeritDesc,
  }) {
    return RawValuesInsertable({
      if (way2MeritId != null) 'way2_merit_id': way2MeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way2MeritDesc != null) 'way2_merit_desc': way2MeritDesc,
    });
  }

  Way2MeritRecordsCompanion copyWith(
      {Value<int> way2MeritId,
      Value<String> comparisonItemId,
      Value<String> way2MeritDesc}) {
    return Way2MeritRecordsCompanion(
      way2MeritId: way2MeritId ?? this.way2MeritId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      way2MeritDesc: way2MeritDesc ?? this.way2MeritDesc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (way2MeritId.present) {
      map['way2_merit_id'] = Variable<int>(way2MeritId.value);
    }
    if (comparisonItemId.present) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId.value);
    }
    if (way2MeritDesc.present) {
      map['way2_merit_desc'] = Variable<String>(way2MeritDesc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Way2MeritRecordsCompanion(')
          ..write('way2MeritId: $way2MeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way2MeritDesc: $way2MeritDesc')
          ..write(')'))
        .toString();
  }
}

class $Way2MeritRecordsTable extends Way2MeritRecords
    with TableInfo<$Way2MeritRecordsTable, Way2MeritRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $Way2MeritRecordsTable(this._db, [this._alias]);
  final VerificationMeta _way2MeritIdMeta =
      const VerificationMeta('way2MeritId');
  GeneratedIntColumn _way2MeritId;
  @override
  GeneratedIntColumn get way2MeritId =>
      _way2MeritId ??= _constructWay2MeritId();
  GeneratedIntColumn _constructWay2MeritId() {
    return GeneratedIntColumn('way2_merit_id', $tableName, false,
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

  final VerificationMeta _way2MeritDescMeta =
      const VerificationMeta('way2MeritDesc');
  GeneratedTextColumn _way2MeritDesc;
  @override
  GeneratedTextColumn get way2MeritDesc =>
      _way2MeritDesc ??= _constructWay2MeritDesc();
  GeneratedTextColumn _constructWay2MeritDesc() {
    return GeneratedTextColumn(
      'way2_merit_desc',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [way2MeritId, comparisonItemId, way2MeritDesc];
  @override
  $Way2MeritRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'way2_merit_records';
  @override
  final String actualTableName = 'way2_merit_records';
  @override
  VerificationContext validateIntegrity(Insertable<Way2MeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way2_merit_id')) {
      context.handle(
          _way2MeritIdMeta,
          way2MeritId.isAcceptableOrUnknown(
              data['way2_merit_id'], _way2MeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id'], _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way2_merit_desc')) {
      context.handle(
          _way2MeritDescMeta,
          way2MeritDesc.isAcceptableOrUnknown(
              data['way2_merit_desc'], _way2MeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way2MeritId};
  @override
  Way2MeritRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Way2MeritRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $Way2MeritRecordsTable createAlias(String alias) {
    return $Way2MeritRecordsTable(_db, alias);
  }
}

class Way2DemeritRecord extends DataClass
    implements Insertable<Way2DemeritRecord> {
  final int way2DemeritId;
  final String comparisonItemId;
  final String way2DemeritDesc;
  Way2DemeritRecord(
      {@required this.way2DemeritId,
      @required this.comparisonItemId,
      this.way2DemeritDesc});
  factory Way2DemeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Way2DemeritRecord(
      way2DemeritId: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_demerit_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
      way2DemeritDesc: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_demerit_desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || way2DemeritId != null) {
      map['way2_demerit_id'] = Variable<int>(way2DemeritId);
    }
    if (!nullToAbsent || comparisonItemId != null) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId);
    }
    if (!nullToAbsent || way2DemeritDesc != null) {
      map['way2_demerit_desc'] = Variable<String>(way2DemeritDesc);
    }
    return map;
  }

  Way2DemeritRecordsCompanion toCompanion(bool nullToAbsent) {
    return Way2DemeritRecordsCompanion(
      way2DemeritId: way2DemeritId == null && nullToAbsent
          ? const Value.absent()
          : Value(way2DemeritId),
      comparisonItemId: comparisonItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(comparisonItemId),
      way2DemeritDesc: way2DemeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way2DemeritDesc),
    );
  }

  factory Way2DemeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way2DemeritRecord(
      way2DemeritId: serializer.fromJson<int>(json['way2DemeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way2DemeritDesc: serializer.fromJson<String>(json['way2DemeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way2DemeritId': serializer.toJson<int>(way2DemeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way2DemeritDesc': serializer.toJson<String>(way2DemeritDesc),
    };
  }

  Way2DemeritRecord copyWith(
          {int way2DemeritId,
          String comparisonItemId,
          String way2DemeritDesc}) =>
      Way2DemeritRecord(
        way2DemeritId: way2DemeritId ?? this.way2DemeritId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        way2DemeritDesc: way2DemeritDesc ?? this.way2DemeritDesc,
      );
  @override
  String toString() {
    return (StringBuffer('Way2DemeritRecord(')
          ..write('way2DemeritId: $way2DemeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way2DemeritDesc: $way2DemeritDesc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(way2DemeritId.hashCode,
      $mrjc(comparisonItemId.hashCode, way2DemeritDesc.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Way2DemeritRecord &&
          other.way2DemeritId == this.way2DemeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way2DemeritDesc == this.way2DemeritDesc);
}

class Way2DemeritRecordsCompanion extends UpdateCompanion<Way2DemeritRecord> {
  final Value<int> way2DemeritId;
  final Value<String> comparisonItemId;
  final Value<String> way2DemeritDesc;
  const Way2DemeritRecordsCompanion({
    this.way2DemeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way2DemeritDesc = const Value.absent(),
  });
  Way2DemeritRecordsCompanion.insert({
    this.way2DemeritId = const Value.absent(),
    @required String comparisonItemId,
    this.way2DemeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  static Insertable<Way2DemeritRecord> custom({
    Expression<int> way2DemeritId,
    Expression<String> comparisonItemId,
    Expression<String> way2DemeritDesc,
  }) {
    return RawValuesInsertable({
      if (way2DemeritId != null) 'way2_demerit_id': way2DemeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way2DemeritDesc != null) 'way2_demerit_desc': way2DemeritDesc,
    });
  }

  Way2DemeritRecordsCompanion copyWith(
      {Value<int> way2DemeritId,
      Value<String> comparisonItemId,
      Value<String> way2DemeritDesc}) {
    return Way2DemeritRecordsCompanion(
      way2DemeritId: way2DemeritId ?? this.way2DemeritId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      way2DemeritDesc: way2DemeritDesc ?? this.way2DemeritDesc,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (way2DemeritId.present) {
      map['way2_demerit_id'] = Variable<int>(way2DemeritId.value);
    }
    if (comparisonItemId.present) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId.value);
    }
    if (way2DemeritDesc.present) {
      map['way2_demerit_desc'] = Variable<String>(way2DemeritDesc.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Way2DemeritRecordsCompanion(')
          ..write('way2DemeritId: $way2DemeritId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('way2DemeritDesc: $way2DemeritDesc')
          ..write(')'))
        .toString();
  }
}

class $Way2DemeritRecordsTable extends Way2DemeritRecords
    with TableInfo<$Way2DemeritRecordsTable, Way2DemeritRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $Way2DemeritRecordsTable(this._db, [this._alias]);
  final VerificationMeta _way2DemeritIdMeta =
      const VerificationMeta('way2DemeritId');
  GeneratedIntColumn _way2DemeritId;
  @override
  GeneratedIntColumn get way2DemeritId =>
      _way2DemeritId ??= _constructWay2DemeritId();
  GeneratedIntColumn _constructWay2DemeritId() {
    return GeneratedIntColumn('way2_demerit_id', $tableName, false,
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

  final VerificationMeta _way2DemeritDescMeta =
      const VerificationMeta('way2DemeritDesc');
  GeneratedTextColumn _way2DemeritDesc;
  @override
  GeneratedTextColumn get way2DemeritDesc =>
      _way2DemeritDesc ??= _constructWay2DemeritDesc();
  GeneratedTextColumn _constructWay2DemeritDesc() {
    return GeneratedTextColumn(
      'way2_demerit_desc',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [way2DemeritId, comparisonItemId, way2DemeritDesc];
  @override
  $Way2DemeritRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'way2_demerit_records';
  @override
  final String actualTableName = 'way2_demerit_records';
  @override
  VerificationContext validateIntegrity(Insertable<Way2DemeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way2_demerit_id')) {
      context.handle(
          _way2DemeritIdMeta,
          way2DemeritId.isAcceptableOrUnknown(
              data['way2_demerit_id'], _way2DemeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id'], _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way2_demerit_desc')) {
      context.handle(
          _way2DemeritDescMeta,
          way2DemeritDesc.isAcceptableOrUnknown(
              data['way2_demerit_desc'], _way2DemeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way2DemeritId};
  @override
  Way2DemeritRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Way2DemeritRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $Way2DemeritRecordsTable createAlias(String alias) {
    return $Way2DemeritRecordsTable(_db, alias);
  }
}

class TagRecord extends DataClass implements Insertable<TagRecord> {
  final int tagId;
  final String comparisonItemId;
  final String tagTitle;
  TagRecord(
      {this.tagId, @required this.comparisonItemId, @required this.tagTitle});
  factory TagRecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return TagRecord(
      tagId: intType.mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
      comparisonItemId: stringType.mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id']),
      tagTitle: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_title']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<int>(tagId);
    }
    if (!nullToAbsent || comparisonItemId != null) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId);
    }
    if (!nullToAbsent || tagTitle != null) {
      map['tag_title'] = Variable<String>(tagTitle);
    }
    return map;
  }

  TagRecordsCompanion toCompanion(bool nullToAbsent) {
    return TagRecordsCompanion(
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
      comparisonItemId: comparisonItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(comparisonItemId),
      tagTitle: tagTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(tagTitle),
    );
  }

  factory TagRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TagRecord(
      tagId: serializer.fromJson<int>(json['tagId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      tagTitle: serializer.fromJson<String>(json['tagTitle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<int>(tagId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'tagTitle': serializer.toJson<String>(tagTitle),
    };
  }

  TagRecord copyWith({int tagId, String comparisonItemId, String tagTitle}) =>
      TagRecord(
        tagId: tagId ?? this.tagId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        tagTitle: tagTitle ?? this.tagTitle,
      );
  @override
  String toString() {
    return (StringBuffer('TagRecord(')
          ..write('tagId: $tagId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('tagTitle: $tagTitle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      tagId.hashCode, $mrjc(comparisonItemId.hashCode, tagTitle.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is TagRecord &&
          other.tagId == this.tagId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.tagTitle == this.tagTitle);
}

class TagRecordsCompanion extends UpdateCompanion<TagRecord> {
  final Value<int> tagId;
  final Value<String> comparisonItemId;
  final Value<String> tagTitle;
  const TagRecordsCompanion({
    this.tagId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.tagTitle = const Value.absent(),
  });
  TagRecordsCompanion.insert({
    this.tagId = const Value.absent(),
    @required String comparisonItemId,
    @required String tagTitle,
  })  : comparisonItemId = Value(comparisonItemId),
        tagTitle = Value(tagTitle);
  static Insertable<TagRecord> custom({
    Expression<int> tagId,
    Expression<String> comparisonItemId,
    Expression<String> tagTitle,
  }) {
    return RawValuesInsertable({
      if (tagId != null) 'tag_id': tagId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (tagTitle != null) 'tag_title': tagTitle,
    });
  }

  TagRecordsCompanion copyWith(
      {Value<int> tagId,
      Value<String> comparisonItemId,
      Value<String> tagTitle}) {
    return TagRecordsCompanion(
      tagId: tagId ?? this.tagId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      tagTitle: tagTitle ?? this.tagTitle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (comparisonItemId.present) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId.value);
    }
    if (tagTitle.present) {
      map['tag_title'] = Variable<String>(tagTitle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagRecordsCompanion(')
          ..write('tagId: $tagId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('tagTitle: $tagTitle')
          ..write(')'))
        .toString();
  }
}

class $TagRecordsTable extends TagRecords
    with TableInfo<$TagRecordsTable, TagRecord> {
  final GeneratedDatabase _db;
  final String _alias;
  $TagRecordsTable(this._db, [this._alias]);
  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  GeneratedIntColumn _tagId;
  @override
  GeneratedIntColumn get tagId => _tagId ??= _constructTagId();
  GeneratedIntColumn _constructTagId() {
    return GeneratedIntColumn(
      'tag_id',
      $tableName,
      true,
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
  List<GeneratedColumn> get $columns => [tagId, comparisonItemId, tagTitle];
  @override
  $TagRecordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'tag_records';
  @override
  final String actualTableName = 'tag_records';
  @override
  VerificationContext validateIntegrity(Insertable<TagRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id'], _tagIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id'], _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('tag_title')) {
      context.handle(_tagTitleMeta,
          tagTitle.isAcceptableOrUnknown(data['tag_title'], _tagTitleMeta));
    } else if (isInserting) {
      context.missing(_tagTitleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagId};
  @override
  TagRecord map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return TagRecord.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $TagRecordsTable createAlias(String alias) {
    return $TagRecordsTable(_db, alias);
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
  $Way2MeritRecordsTable _way2MeritRecords;
  $Way2MeritRecordsTable get way2MeritRecords =>
      _way2MeritRecords ??= $Way2MeritRecordsTable(this);
  $Way2DemeritRecordsTable _way2DemeritRecords;
  $Way2DemeritRecordsTable get way2DemeritRecords =>
      _way2DemeritRecords ??= $Way2DemeritRecordsTable(this);
  $TagRecordsTable _tagRecords;
  $TagRecordsTable get tagRecords => _tagRecords ??= $TagRecordsTable(this);
  ComparisonItemDao _comparisonItemDao;
  ComparisonItemDao get comparisonItemDao =>
      _comparisonItemDao ??= ComparisonItemDao(this as ComparisonItemDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        comparisonOverviewRecords,
        way1MeritRecords,
        way1DemeritRecords,
        way2MeritRecords,
        way2DemeritRecords,
        tagRecords
      ];
}
