// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comparison_item_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class ComparisonOverviewRecord extends DataClass
    implements Insertable<ComparisonOverviewRecord> {
  final int dataId;
  final String comparisonItemId;
  final String itemTitle;

  ///way1
  final String way1Title;
  final int way1MeritEvaluate;
  final int way1DemeritEvaluate;

  ///way2
  final String way2Title;
  final int way2MeritEvaluate;
  final int way2DemeritEvaluate;
  final bool favorite;
  final String? conclusion;
  final DateTime? createdAt;
  ComparisonOverviewRecord(
      {required this.dataId,
      required this.comparisonItemId,
      required this.itemTitle,
      required this.way1Title,
      required this.way1MeritEvaluate,
      required this.way1DemeritEvaluate,
      required this.way2Title,
      required this.way2MeritEvaluate,
      required this.way2DemeritEvaluate,
      required this.favorite,
      this.conclusion,
      this.createdAt});
  factory ComparisonOverviewRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ComparisonOverviewRecord(
      dataId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data_id'])!,
      comparisonItemId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id'])!,
      itemTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}item_title'])!,
      way1Title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_title'])!,
      way1MeritEvaluate: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}way1_merit_evaluate'])!,
      way1DemeritEvaluate: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}way1_demerit_evaluate'])!,
      way2Title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_title'])!,
      way2MeritEvaluate: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}way2_merit_evaluate'])!,
      way2DemeritEvaluate: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}way2_demerit_evaluate'])!,
      favorite: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}favorite'])!,
      conclusion: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}conclusion']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['data_id'] = Variable<int>(dataId);
    map['comparison_item_id'] = Variable<String>(comparisonItemId);
    map['item_title'] = Variable<String>(itemTitle);
    map['way1_title'] = Variable<String>(way1Title);
    map['way1_merit_evaluate'] = Variable<int>(way1MeritEvaluate);
    map['way1_demerit_evaluate'] = Variable<int>(way1DemeritEvaluate);
    map['way2_title'] = Variable<String>(way2Title);
    map['way2_merit_evaluate'] = Variable<int>(way2MeritEvaluate);
    map['way2_demerit_evaluate'] = Variable<int>(way2DemeritEvaluate);
    map['favorite'] = Variable<bool>(favorite);
    if (!nullToAbsent || conclusion != null) {
      map['conclusion'] = Variable<String?>(conclusion);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime?>(createdAt);
    }
    return map;
  }

  ComparisonOverviewRecordsCompanion toCompanion(bool nullToAbsent) {
    return ComparisonOverviewRecordsCompanion(
      dataId: Value(dataId),
      comparisonItemId: Value(comparisonItemId),
      itemTitle: Value(itemTitle),
      way1Title: Value(way1Title),
      way1MeritEvaluate: Value(way1MeritEvaluate),
      way1DemeritEvaluate: Value(way1DemeritEvaluate),
      way2Title: Value(way2Title),
      way2MeritEvaluate: Value(way2MeritEvaluate),
      way2DemeritEvaluate: Value(way2DemeritEvaluate),
      favorite: Value(favorite),
      conclusion: conclusion == null && nullToAbsent
          ? const Value.absent()
          : Value(conclusion),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
    );
  }

  factory ComparisonOverviewRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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
      conclusion: serializer.fromJson<String?>(json['conclusion']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
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
      'conclusion': serializer.toJson<String?>(conclusion),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  ComparisonOverviewRecord copyWith(
          {int? dataId,
          String? comparisonItemId,
          String? itemTitle,
          String? way1Title,
          int? way1MeritEvaluate,
          int? way1DemeritEvaluate,
          String? way2Title,
          int? way2MeritEvaluate,
          int? way2DemeritEvaluate,
          bool? favorite,
          String? conclusion,
          DateTime? createdAt}) =>
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
  int get hashCode => Object.hash(
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
      createdAt);
  @override
  bool operator ==(Object other) =>
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
  final Value<String?> conclusion;
  final Value<DateTime?> createdAt;
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
    required String comparisonItemId,
    required String itemTitle,
    required String way1Title,
    this.way1MeritEvaluate = const Value.absent(),
    this.way1DemeritEvaluate = const Value.absent(),
    required String way2Title,
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
    Expression<int>? dataId,
    Expression<String>? comparisonItemId,
    Expression<String>? itemTitle,
    Expression<String>? way1Title,
    Expression<int>? way1MeritEvaluate,
    Expression<int>? way1DemeritEvaluate,
    Expression<String>? way2Title,
    Expression<int>? way2MeritEvaluate,
    Expression<int>? way2DemeritEvaluate,
    Expression<bool>? favorite,
    Expression<String?>? conclusion,
    Expression<DateTime?>? createdAt,
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
      {Value<int>? dataId,
      Value<String>? comparisonItemId,
      Value<String>? itemTitle,
      Value<String>? way1Title,
      Value<int>? way1MeritEvaluate,
      Value<int>? way1DemeritEvaluate,
      Value<String>? way2Title,
      Value<int>? way2MeritEvaluate,
      Value<int>? way2DemeritEvaluate,
      Value<bool>? favorite,
      Value<String?>? conclusion,
      Value<DateTime?>? createdAt}) {
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
      map['conclusion'] = Variable<String?>(conclusion.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime?>(createdAt.value);
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
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComparisonOverviewRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _dataIdMeta = const VerificationMeta('dataId');
  @override
  late final GeneratedColumn<int?> dataId = GeneratedColumn<int?>(
      'data_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  @override
  late final GeneratedColumn<String?> comparisonItemId =
      GeneratedColumn<String?>('comparison_item_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _itemTitleMeta = const VerificationMeta('itemTitle');
  @override
  late final GeneratedColumn<String?> itemTitle = GeneratedColumn<String?>(
      'item_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _way1TitleMeta = const VerificationMeta('way1Title');
  @override
  late final GeneratedColumn<String?> way1Title = GeneratedColumn<String?>(
      'way1_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _way1MeritEvaluateMeta =
      const VerificationMeta('way1MeritEvaluate');
  @override
  late final GeneratedColumn<int?> way1MeritEvaluate = GeneratedColumn<int?>(
      'way1_merit_evaluate', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _way1DemeritEvaluateMeta =
      const VerificationMeta('way1DemeritEvaluate');
  @override
  late final GeneratedColumn<int?> way1DemeritEvaluate = GeneratedColumn<int?>(
      'way1_demerit_evaluate', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _way2TitleMeta = const VerificationMeta('way2Title');
  @override
  late final GeneratedColumn<String?> way2Title = GeneratedColumn<String?>(
      'way2_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _way2MeritEvaluateMeta =
      const VerificationMeta('way2MeritEvaluate');
  @override
  late final GeneratedColumn<int?> way2MeritEvaluate = GeneratedColumn<int?>(
      'way2_merit_evaluate', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _way2DemeritEvaluateMeta =
      const VerificationMeta('way2DemeritEvaluate');
  @override
  late final GeneratedColumn<int?> way2DemeritEvaluate = GeneratedColumn<int?>(
      'way2_demerit_evaluate', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _favoriteMeta = const VerificationMeta('favorite');
  @override
  late final GeneratedColumn<bool?> favorite = GeneratedColumn<bool?>(
      'favorite', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (favorite IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _conclusionMeta = const VerificationMeta('conclusion');
  @override
  late final GeneratedColumn<String?> conclusion = GeneratedColumn<String?>(
      'conclusion', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
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
  String get aliasedName => _alias ?? 'comparison_overview_records';
  @override
  String get actualTableName => 'comparison_overview_records';
  @override
  VerificationContext validateIntegrity(
      Insertable<ComparisonOverviewRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('data_id')) {
      context.handle(_dataIdMeta,
          dataId.isAcceptableOrUnknown(data['data_id']!, _dataIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id']!, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('item_title')) {
      context.handle(_itemTitleMeta,
          itemTitle.isAcceptableOrUnknown(data['item_title']!, _itemTitleMeta));
    } else if (isInserting) {
      context.missing(_itemTitleMeta);
    }
    if (data.containsKey('way1_title')) {
      context.handle(_way1TitleMeta,
          way1Title.isAcceptableOrUnknown(data['way1_title']!, _way1TitleMeta));
    } else if (isInserting) {
      context.missing(_way1TitleMeta);
    }
    if (data.containsKey('way1_merit_evaluate')) {
      context.handle(
          _way1MeritEvaluateMeta,
          way1MeritEvaluate.isAcceptableOrUnknown(
              data['way1_merit_evaluate']!, _way1MeritEvaluateMeta));
    }
    if (data.containsKey('way1_demerit_evaluate')) {
      context.handle(
          _way1DemeritEvaluateMeta,
          way1DemeritEvaluate.isAcceptableOrUnknown(
              data['way1_demerit_evaluate']!, _way1DemeritEvaluateMeta));
    }
    if (data.containsKey('way2_title')) {
      context.handle(_way2TitleMeta,
          way2Title.isAcceptableOrUnknown(data['way2_title']!, _way2TitleMeta));
    } else if (isInserting) {
      context.missing(_way2TitleMeta);
    }
    if (data.containsKey('way2_merit_evaluate')) {
      context.handle(
          _way2MeritEvaluateMeta,
          way2MeritEvaluate.isAcceptableOrUnknown(
              data['way2_merit_evaluate']!, _way2MeritEvaluateMeta));
    }
    if (data.containsKey('way2_demerit_evaluate')) {
      context.handle(
          _way2DemeritEvaluateMeta,
          way2DemeritEvaluate.isAcceptableOrUnknown(
              data['way2_demerit_evaluate']!, _way2DemeritEvaluateMeta));
    }
    if (data.containsKey('favorite')) {
      context.handle(_favoriteMeta,
          favorite.isAcceptableOrUnknown(data['favorite']!, _favoriteMeta));
    }
    if (data.containsKey('conclusion')) {
      context.handle(
          _conclusionMeta,
          conclusion.isAcceptableOrUnknown(
              data['conclusion']!, _conclusionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dataId};
  @override
  ComparisonOverviewRecord map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return ComparisonOverviewRecord.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ComparisonOverviewRecordsTable createAlias(String alias) {
    return $ComparisonOverviewRecordsTable(attachedDatabase, alias);
  }
}

class Way1MeritRecord extends DataClass implements Insertable<Way1MeritRecord> {
  final int way1MeritId;
  final String comparisonItemId;
  final String? way1MeritDesc;
  Way1MeritRecord(
      {required this.way1MeritId,
      required this.comparisonItemId,
      this.way1MeritDesc});
  factory Way1MeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Way1MeritRecord(
      way1MeritId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_merit_id'])!,
      comparisonItemId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id'])!,
      way1MeritDesc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_merit_desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['way1_merit_id'] = Variable<int>(way1MeritId);
    map['comparison_item_id'] = Variable<String>(comparisonItemId);
    if (!nullToAbsent || way1MeritDesc != null) {
      map['way1_merit_desc'] = Variable<String?>(way1MeritDesc);
    }
    return map;
  }

  Way1MeritRecordsCompanion toCompanion(bool nullToAbsent) {
    return Way1MeritRecordsCompanion(
      way1MeritId: Value(way1MeritId),
      comparisonItemId: Value(comparisonItemId),
      way1MeritDesc: way1MeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way1MeritDesc),
    );
  }

  factory Way1MeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way1MeritRecord(
      way1MeritId: serializer.fromJson<int>(json['way1MeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way1MeritDesc: serializer.fromJson<String?>(json['way1MeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way1MeritId': serializer.toJson<int>(way1MeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way1MeritDesc': serializer.toJson<String?>(way1MeritDesc),
    };
  }

  Way1MeritRecord copyWith(
          {int? way1MeritId,
          String? comparisonItemId,
          String? way1MeritDesc}) =>
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
  int get hashCode => Object.hash(way1MeritId, comparisonItemId, way1MeritDesc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Way1MeritRecord &&
          other.way1MeritId == this.way1MeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way1MeritDesc == this.way1MeritDesc);
}

class Way1MeritRecordsCompanion extends UpdateCompanion<Way1MeritRecord> {
  final Value<int> way1MeritId;
  final Value<String> comparisonItemId;
  final Value<String?> way1MeritDesc;
  const Way1MeritRecordsCompanion({
    this.way1MeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way1MeritDesc = const Value.absent(),
  });
  Way1MeritRecordsCompanion.insert({
    this.way1MeritId = const Value.absent(),
    required String comparisonItemId,
    this.way1MeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  static Insertable<Way1MeritRecord> custom({
    Expression<int>? way1MeritId,
    Expression<String>? comparisonItemId,
    Expression<String?>? way1MeritDesc,
  }) {
    return RawValuesInsertable({
      if (way1MeritId != null) 'way1_merit_id': way1MeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way1MeritDesc != null) 'way1_merit_desc': way1MeritDesc,
    });
  }

  Way1MeritRecordsCompanion copyWith(
      {Value<int>? way1MeritId,
      Value<String>? comparisonItemId,
      Value<String?>? way1MeritDesc}) {
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
      map['way1_merit_desc'] = Variable<String?>(way1MeritDesc.value);
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
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Way1MeritRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _way1MeritIdMeta =
      const VerificationMeta('way1MeritId');
  @override
  late final GeneratedColumn<int?> way1MeritId = GeneratedColumn<int?>(
      'way1_merit_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  @override
  late final GeneratedColumn<String?> comparisonItemId =
      GeneratedColumn<String?>('comparison_item_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _way1MeritDescMeta =
      const VerificationMeta('way1MeritDesc');
  @override
  late final GeneratedColumn<String?> way1MeritDesc = GeneratedColumn<String?>(
      'way1_merit_desc', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [way1MeritId, comparisonItemId, way1MeritDesc];
  @override
  String get aliasedName => _alias ?? 'way1_merit_records';
  @override
  String get actualTableName => 'way1_merit_records';
  @override
  VerificationContext validateIntegrity(Insertable<Way1MeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way1_merit_id')) {
      context.handle(
          _way1MeritIdMeta,
          way1MeritId.isAcceptableOrUnknown(
              data['way1_merit_id']!, _way1MeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id']!, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way1_merit_desc')) {
      context.handle(
          _way1MeritDescMeta,
          way1MeritDesc.isAcceptableOrUnknown(
              data['way1_merit_desc']!, _way1MeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way1MeritId};
  @override
  Way1MeritRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Way1MeritRecord.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $Way1MeritRecordsTable createAlias(String alias) {
    return $Way1MeritRecordsTable(attachedDatabase, alias);
  }
}

class Way1DemeritRecord extends DataClass
    implements Insertable<Way1DemeritRecord> {
  final int way1DemeritId;
  final String comparisonItemId;
  final String? way1DemeritDesc;
  Way1DemeritRecord(
      {required this.way1DemeritId,
      required this.comparisonItemId,
      this.way1DemeritDesc});
  factory Way1DemeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Way1DemeritRecord(
      way1DemeritId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_demerit_id'])!,
      comparisonItemId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id'])!,
      way1DemeritDesc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way1_demerit_desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['way1_demerit_id'] = Variable<int>(way1DemeritId);
    map['comparison_item_id'] = Variable<String>(comparisonItemId);
    if (!nullToAbsent || way1DemeritDesc != null) {
      map['way1_demerit_desc'] = Variable<String?>(way1DemeritDesc);
    }
    return map;
  }

  Way1DemeritRecordsCompanion toCompanion(bool nullToAbsent) {
    return Way1DemeritRecordsCompanion(
      way1DemeritId: Value(way1DemeritId),
      comparisonItemId: Value(comparisonItemId),
      way1DemeritDesc: way1DemeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way1DemeritDesc),
    );
  }

  factory Way1DemeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way1DemeritRecord(
      way1DemeritId: serializer.fromJson<int>(json['way1DemeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way1DemeritDesc: serializer.fromJson<String?>(json['way1DemeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way1DemeritId': serializer.toJson<int>(way1DemeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way1DemeritDesc': serializer.toJson<String?>(way1DemeritDesc),
    };
  }

  Way1DemeritRecord copyWith(
          {int? way1DemeritId,
          String? comparisonItemId,
          String? way1DemeritDesc}) =>
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
  int get hashCode =>
      Object.hash(way1DemeritId, comparisonItemId, way1DemeritDesc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Way1DemeritRecord &&
          other.way1DemeritId == this.way1DemeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way1DemeritDesc == this.way1DemeritDesc);
}

class Way1DemeritRecordsCompanion extends UpdateCompanion<Way1DemeritRecord> {
  final Value<int> way1DemeritId;
  final Value<String> comparisonItemId;
  final Value<String?> way1DemeritDesc;
  const Way1DemeritRecordsCompanion({
    this.way1DemeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way1DemeritDesc = const Value.absent(),
  });
  Way1DemeritRecordsCompanion.insert({
    this.way1DemeritId = const Value.absent(),
    required String comparisonItemId,
    this.way1DemeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  static Insertable<Way1DemeritRecord> custom({
    Expression<int>? way1DemeritId,
    Expression<String>? comparisonItemId,
    Expression<String?>? way1DemeritDesc,
  }) {
    return RawValuesInsertable({
      if (way1DemeritId != null) 'way1_demerit_id': way1DemeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way1DemeritDesc != null) 'way1_demerit_desc': way1DemeritDesc,
    });
  }

  Way1DemeritRecordsCompanion copyWith(
      {Value<int>? way1DemeritId,
      Value<String>? comparisonItemId,
      Value<String?>? way1DemeritDesc}) {
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
      map['way1_demerit_desc'] = Variable<String?>(way1DemeritDesc.value);
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
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Way1DemeritRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _way1DemeritIdMeta =
      const VerificationMeta('way1DemeritId');
  @override
  late final GeneratedColumn<int?> way1DemeritId = GeneratedColumn<int?>(
      'way1_demerit_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  @override
  late final GeneratedColumn<String?> comparisonItemId =
      GeneratedColumn<String?>('comparison_item_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _way1DemeritDescMeta =
      const VerificationMeta('way1DemeritDesc');
  @override
  late final GeneratedColumn<String?> way1DemeritDesc =
      GeneratedColumn<String?>('way1_demerit_desc', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [way1DemeritId, comparisonItemId, way1DemeritDesc];
  @override
  String get aliasedName => _alias ?? 'way1_demerit_records';
  @override
  String get actualTableName => 'way1_demerit_records';
  @override
  VerificationContext validateIntegrity(Insertable<Way1DemeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way1_demerit_id')) {
      context.handle(
          _way1DemeritIdMeta,
          way1DemeritId.isAcceptableOrUnknown(
              data['way1_demerit_id']!, _way1DemeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id']!, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way1_demerit_desc')) {
      context.handle(
          _way1DemeritDescMeta,
          way1DemeritDesc.isAcceptableOrUnknown(
              data['way1_demerit_desc']!, _way1DemeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way1DemeritId};
  @override
  Way1DemeritRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Way1DemeritRecord.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $Way1DemeritRecordsTable createAlias(String alias) {
    return $Way1DemeritRecordsTable(attachedDatabase, alias);
  }
}

class Way2MeritRecord extends DataClass implements Insertable<Way2MeritRecord> {
  final int way2MeritId;
  final String comparisonItemId;
  final String? way2MeritDesc;
  Way2MeritRecord(
      {required this.way2MeritId,
      required this.comparisonItemId,
      this.way2MeritDesc});
  factory Way2MeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Way2MeritRecord(
      way2MeritId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_merit_id'])!,
      comparisonItemId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id'])!,
      way2MeritDesc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_merit_desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['way2_merit_id'] = Variable<int>(way2MeritId);
    map['comparison_item_id'] = Variable<String>(comparisonItemId);
    if (!nullToAbsent || way2MeritDesc != null) {
      map['way2_merit_desc'] = Variable<String?>(way2MeritDesc);
    }
    return map;
  }

  Way2MeritRecordsCompanion toCompanion(bool nullToAbsent) {
    return Way2MeritRecordsCompanion(
      way2MeritId: Value(way2MeritId),
      comparisonItemId: Value(comparisonItemId),
      way2MeritDesc: way2MeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way2MeritDesc),
    );
  }

  factory Way2MeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way2MeritRecord(
      way2MeritId: serializer.fromJson<int>(json['way2MeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way2MeritDesc: serializer.fromJson<String?>(json['way2MeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way2MeritId': serializer.toJson<int>(way2MeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way2MeritDesc': serializer.toJson<String?>(way2MeritDesc),
    };
  }

  Way2MeritRecord copyWith(
          {int? way2MeritId,
          String? comparisonItemId,
          String? way2MeritDesc}) =>
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
  int get hashCode => Object.hash(way2MeritId, comparisonItemId, way2MeritDesc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Way2MeritRecord &&
          other.way2MeritId == this.way2MeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way2MeritDesc == this.way2MeritDesc);
}

class Way2MeritRecordsCompanion extends UpdateCompanion<Way2MeritRecord> {
  final Value<int> way2MeritId;
  final Value<String> comparisonItemId;
  final Value<String?> way2MeritDesc;
  const Way2MeritRecordsCompanion({
    this.way2MeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way2MeritDesc = const Value.absent(),
  });
  Way2MeritRecordsCompanion.insert({
    this.way2MeritId = const Value.absent(),
    required String comparisonItemId,
    this.way2MeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  static Insertable<Way2MeritRecord> custom({
    Expression<int>? way2MeritId,
    Expression<String>? comparisonItemId,
    Expression<String?>? way2MeritDesc,
  }) {
    return RawValuesInsertable({
      if (way2MeritId != null) 'way2_merit_id': way2MeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way2MeritDesc != null) 'way2_merit_desc': way2MeritDesc,
    });
  }

  Way2MeritRecordsCompanion copyWith(
      {Value<int>? way2MeritId,
      Value<String>? comparisonItemId,
      Value<String?>? way2MeritDesc}) {
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
      map['way2_merit_desc'] = Variable<String?>(way2MeritDesc.value);
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
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Way2MeritRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _way2MeritIdMeta =
      const VerificationMeta('way2MeritId');
  @override
  late final GeneratedColumn<int?> way2MeritId = GeneratedColumn<int?>(
      'way2_merit_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  @override
  late final GeneratedColumn<String?> comparisonItemId =
      GeneratedColumn<String?>('comparison_item_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _way2MeritDescMeta =
      const VerificationMeta('way2MeritDesc');
  @override
  late final GeneratedColumn<String?> way2MeritDesc = GeneratedColumn<String?>(
      'way2_merit_desc', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [way2MeritId, comparisonItemId, way2MeritDesc];
  @override
  String get aliasedName => _alias ?? 'way2_merit_records';
  @override
  String get actualTableName => 'way2_merit_records';
  @override
  VerificationContext validateIntegrity(Insertable<Way2MeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way2_merit_id')) {
      context.handle(
          _way2MeritIdMeta,
          way2MeritId.isAcceptableOrUnknown(
              data['way2_merit_id']!, _way2MeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id']!, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way2_merit_desc')) {
      context.handle(
          _way2MeritDescMeta,
          way2MeritDesc.isAcceptableOrUnknown(
              data['way2_merit_desc']!, _way2MeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way2MeritId};
  @override
  Way2MeritRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Way2MeritRecord.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $Way2MeritRecordsTable createAlias(String alias) {
    return $Way2MeritRecordsTable(attachedDatabase, alias);
  }
}

class Way2DemeritRecord extends DataClass
    implements Insertable<Way2DemeritRecord> {
  final int way2DemeritId;
  final String comparisonItemId;
  final String? way2DemeritDesc;
  Way2DemeritRecord(
      {required this.way2DemeritId,
      required this.comparisonItemId,
      this.way2DemeritDesc});
  factory Way2DemeritRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Way2DemeritRecord(
      way2DemeritId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_demerit_id'])!,
      comparisonItemId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id'])!,
      way2DemeritDesc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}way2_demerit_desc']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['way2_demerit_id'] = Variable<int>(way2DemeritId);
    map['comparison_item_id'] = Variable<String>(comparisonItemId);
    if (!nullToAbsent || way2DemeritDesc != null) {
      map['way2_demerit_desc'] = Variable<String?>(way2DemeritDesc);
    }
    return map;
  }

  Way2DemeritRecordsCompanion toCompanion(bool nullToAbsent) {
    return Way2DemeritRecordsCompanion(
      way2DemeritId: Value(way2DemeritId),
      comparisonItemId: Value(comparisonItemId),
      way2DemeritDesc: way2DemeritDesc == null && nullToAbsent
          ? const Value.absent()
          : Value(way2DemeritDesc),
    );
  }

  factory Way2DemeritRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Way2DemeritRecord(
      way2DemeritId: serializer.fromJson<int>(json['way2DemeritId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      way2DemeritDesc: serializer.fromJson<String?>(json['way2DemeritDesc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'way2DemeritId': serializer.toJson<int>(way2DemeritId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'way2DemeritDesc': serializer.toJson<String?>(way2DemeritDesc),
    };
  }

  Way2DemeritRecord copyWith(
          {int? way2DemeritId,
          String? comparisonItemId,
          String? way2DemeritDesc}) =>
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
  int get hashCode =>
      Object.hash(way2DemeritId, comparisonItemId, way2DemeritDesc);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Way2DemeritRecord &&
          other.way2DemeritId == this.way2DemeritId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.way2DemeritDesc == this.way2DemeritDesc);
}

class Way2DemeritRecordsCompanion extends UpdateCompanion<Way2DemeritRecord> {
  final Value<int> way2DemeritId;
  final Value<String> comparisonItemId;
  final Value<String?> way2DemeritDesc;
  const Way2DemeritRecordsCompanion({
    this.way2DemeritId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.way2DemeritDesc = const Value.absent(),
  });
  Way2DemeritRecordsCompanion.insert({
    this.way2DemeritId = const Value.absent(),
    required String comparisonItemId,
    this.way2DemeritDesc = const Value.absent(),
  }) : comparisonItemId = Value(comparisonItemId);
  static Insertable<Way2DemeritRecord> custom({
    Expression<int>? way2DemeritId,
    Expression<String>? comparisonItemId,
    Expression<String?>? way2DemeritDesc,
  }) {
    return RawValuesInsertable({
      if (way2DemeritId != null) 'way2_demerit_id': way2DemeritId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (way2DemeritDesc != null) 'way2_demerit_desc': way2DemeritDesc,
    });
  }

  Way2DemeritRecordsCompanion copyWith(
      {Value<int>? way2DemeritId,
      Value<String>? comparisonItemId,
      Value<String?>? way2DemeritDesc}) {
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
      map['way2_demerit_desc'] = Variable<String?>(way2DemeritDesc.value);
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
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Way2DemeritRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _way2DemeritIdMeta =
      const VerificationMeta('way2DemeritId');
  @override
  late final GeneratedColumn<int?> way2DemeritId = GeneratedColumn<int?>(
      'way2_demerit_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  @override
  late final GeneratedColumn<String?> comparisonItemId =
      GeneratedColumn<String?>('comparison_item_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _way2DemeritDescMeta =
      const VerificationMeta('way2DemeritDesc');
  @override
  late final GeneratedColumn<String?> way2DemeritDesc =
      GeneratedColumn<String?>('way2_demerit_desc', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [way2DemeritId, comparisonItemId, way2DemeritDesc];
  @override
  String get aliasedName => _alias ?? 'way2_demerit_records';
  @override
  String get actualTableName => 'way2_demerit_records';
  @override
  VerificationContext validateIntegrity(Insertable<Way2DemeritRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('way2_demerit_id')) {
      context.handle(
          _way2DemeritIdMeta,
          way2DemeritId.isAcceptableOrUnknown(
              data['way2_demerit_id']!, _way2DemeritIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id']!, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('way2_demerit_desc')) {
      context.handle(
          _way2DemeritDescMeta,
          way2DemeritDesc.isAcceptableOrUnknown(
              data['way2_demerit_desc']!, _way2DemeritDescMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {way2DemeritId};
  @override
  Way2DemeritRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Way2DemeritRecord.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $Way2DemeritRecordsTable createAlias(String alias) {
    return $Way2DemeritRecordsTable(attachedDatabase, alias);
  }
}

class TagRecord extends DataClass implements Insertable<TagRecord> {
  final int? tagId;
  final String comparisonItemId;
  final String tagTitle;
  final DateTime? createdAt;
  final String createAtToString;
  TagRecord(
      {this.tagId,
      required this.comparisonItemId,
      required this.tagTitle,
      this.createdAt,
      required this.createAtToString});
  factory TagRecord.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TagRecord(
      tagId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_id']),
      comparisonItemId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}comparison_item_id'])!,
      tagTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_title'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      createAtToString: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}create_at_to_string'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || tagId != null) {
      map['tag_id'] = Variable<int?>(tagId);
    }
    map['comparison_item_id'] = Variable<String>(comparisonItemId);
    map['tag_title'] = Variable<String>(tagTitle);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime?>(createdAt);
    }
    map['create_at_to_string'] = Variable<String>(createAtToString);
    return map;
  }

  TagRecordsCompanion toCompanion(bool nullToAbsent) {
    return TagRecordsCompanion(
      tagId:
          tagId == null && nullToAbsent ? const Value.absent() : Value(tagId),
      comparisonItemId: Value(comparisonItemId),
      tagTitle: Value(tagTitle),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      createAtToString: Value(createAtToString),
    );
  }

  factory TagRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TagRecord(
      tagId: serializer.fromJson<int?>(json['tagId']),
      comparisonItemId: serializer.fromJson<String>(json['comparisonItemId']),
      tagTitle: serializer.fromJson<String>(json['tagTitle']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      createAtToString: serializer.fromJson<String>(json['createAtToString']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<int?>(tagId),
      'comparisonItemId': serializer.toJson<String>(comparisonItemId),
      'tagTitle': serializer.toJson<String>(tagTitle),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'createAtToString': serializer.toJson<String>(createAtToString),
    };
  }

  TagRecord copyWith(
          {int? tagId,
          String? comparisonItemId,
          String? tagTitle,
          DateTime? createdAt,
          String? createAtToString}) =>
      TagRecord(
        tagId: tagId ?? this.tagId,
        comparisonItemId: comparisonItemId ?? this.comparisonItemId,
        tagTitle: tagTitle ?? this.tagTitle,
        createdAt: createdAt ?? this.createdAt,
        createAtToString: createAtToString ?? this.createAtToString,
      );
  @override
  String toString() {
    return (StringBuffer('TagRecord(')
          ..write('tagId: $tagId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('tagTitle: $tagTitle, ')
          ..write('createdAt: $createdAt, ')
          ..write('createAtToString: $createAtToString')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      tagId, comparisonItemId, tagTitle, createdAt, createAtToString);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagRecord &&
          other.tagId == this.tagId &&
          other.comparisonItemId == this.comparisonItemId &&
          other.tagTitle == this.tagTitle &&
          other.createdAt == this.createdAt &&
          other.createAtToString == this.createAtToString);
}

class TagRecordsCompanion extends UpdateCompanion<TagRecord> {
  final Value<int?> tagId;
  final Value<String> comparisonItemId;
  final Value<String> tagTitle;
  final Value<DateTime?> createdAt;
  final Value<String> createAtToString;
  const TagRecordsCompanion({
    this.tagId = const Value.absent(),
    this.comparisonItemId = const Value.absent(),
    this.tagTitle = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.createAtToString = const Value.absent(),
  });
  TagRecordsCompanion.insert({
    this.tagId = const Value.absent(),
    required String comparisonItemId,
    required String tagTitle,
    this.createdAt = const Value.absent(),
    required String createAtToString,
  })  : comparisonItemId = Value(comparisonItemId),
        tagTitle = Value(tagTitle),
        createAtToString = Value(createAtToString);
  static Insertable<TagRecord> custom({
    Expression<int?>? tagId,
    Expression<String>? comparisonItemId,
    Expression<String>? tagTitle,
    Expression<DateTime?>? createdAt,
    Expression<String>? createAtToString,
  }) {
    return RawValuesInsertable({
      if (tagId != null) 'tag_id': tagId,
      if (comparisonItemId != null) 'comparison_item_id': comparisonItemId,
      if (tagTitle != null) 'tag_title': tagTitle,
      if (createdAt != null) 'created_at': createdAt,
      if (createAtToString != null) 'create_at_to_string': createAtToString,
    });
  }

  TagRecordsCompanion copyWith(
      {Value<int?>? tagId,
      Value<String>? comparisonItemId,
      Value<String>? tagTitle,
      Value<DateTime?>? createdAt,
      Value<String>? createAtToString}) {
    return TagRecordsCompanion(
      tagId: tagId ?? this.tagId,
      comparisonItemId: comparisonItemId ?? this.comparisonItemId,
      tagTitle: tagTitle ?? this.tagTitle,
      createdAt: createdAt ?? this.createdAt,
      createAtToString: createAtToString ?? this.createAtToString,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagId.present) {
      map['tag_id'] = Variable<int?>(tagId.value);
    }
    if (comparisonItemId.present) {
      map['comparison_item_id'] = Variable<String>(comparisonItemId.value);
    }
    if (tagTitle.present) {
      map['tag_title'] = Variable<String>(tagTitle.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime?>(createdAt.value);
    }
    if (createAtToString.present) {
      map['create_at_to_string'] = Variable<String>(createAtToString.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagRecordsCompanion(')
          ..write('tagId: $tagId, ')
          ..write('comparisonItemId: $comparisonItemId, ')
          ..write('tagTitle: $tagTitle, ')
          ..write('createdAt: $createdAt, ')
          ..write('createAtToString: $createAtToString')
          ..write(')'))
        .toString();
  }
}

class $TagRecordsTable extends TagRecords
    with TableInfo<$TagRecordsTable, TagRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int?> tagId = GeneratedColumn<int?>(
      'tag_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _comparisonItemIdMeta =
      const VerificationMeta('comparisonItemId');
  @override
  late final GeneratedColumn<String?> comparisonItemId =
      GeneratedColumn<String?>('comparison_item_id', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tagTitleMeta = const VerificationMeta('tagTitle');
  @override
  late final GeneratedColumn<String?> tagTitle = GeneratedColumn<String?>(
      'tag_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _createAtToStringMeta =
      const VerificationMeta('createAtToString');
  @override
  late final GeneratedColumn<String?> createAtToString =
      GeneratedColumn<String?>('create_at_to_string', aliasedName, false,
          type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [tagId, comparisonItemId, tagTitle, createdAt, createAtToString];
  @override
  String get aliasedName => _alias ?? 'tag_records';
  @override
  String get actualTableName => 'tag_records';
  @override
  VerificationContext validateIntegrity(Insertable<TagRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    }
    if (data.containsKey('comparison_item_id')) {
      context.handle(
          _comparisonItemIdMeta,
          comparisonItemId.isAcceptableOrUnknown(
              data['comparison_item_id']!, _comparisonItemIdMeta));
    } else if (isInserting) {
      context.missing(_comparisonItemIdMeta);
    }
    if (data.containsKey('tag_title')) {
      context.handle(_tagTitleMeta,
          tagTitle.isAcceptableOrUnknown(data['tag_title']!, _tagTitleMeta));
    } else if (isInserting) {
      context.missing(_tagTitleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('create_at_to_string')) {
      context.handle(
          _createAtToStringMeta,
          createAtToString.isAcceptableOrUnknown(
              data['create_at_to_string']!, _createAtToStringMeta));
    } else if (isInserting) {
      context.missing(_createAtToStringMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagId};
  @override
  TagRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TagRecord.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TagRecordsTable createAlias(String alias) {
    return $TagRecordsTable(attachedDatabase, alias);
  }
}

class TagChartRecord extends DataClass implements Insertable<TagChartRecord> {
  final int dataId;
  final String tagTitle;
  final int? tagAmount;
  TagChartRecord(
      {required this.dataId, required this.tagTitle, this.tagAmount});
  factory TagChartRecord.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TagChartRecord(
      dataId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data_id'])!,
      tagTitle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_title'])!,
      tagAmount: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag_amount']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['data_id'] = Variable<int>(dataId);
    map['tag_title'] = Variable<String>(tagTitle);
    if (!nullToAbsent || tagAmount != null) {
      map['tag_amount'] = Variable<int?>(tagAmount);
    }
    return map;
  }

  TagChartRecordsCompanion toCompanion(bool nullToAbsent) {
    return TagChartRecordsCompanion(
      dataId: Value(dataId),
      tagTitle: Value(tagTitle),
      tagAmount: tagAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(tagAmount),
    );
  }

  factory TagChartRecord.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return TagChartRecord(
      dataId: serializer.fromJson<int>(json['dataId']),
      tagTitle: serializer.fromJson<String>(json['tagTitle']),
      tagAmount: serializer.fromJson<int?>(json['tagAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dataId': serializer.toJson<int>(dataId),
      'tagTitle': serializer.toJson<String>(tagTitle),
      'tagAmount': serializer.toJson<int?>(tagAmount),
    };
  }

  TagChartRecord copyWith({int? dataId, String? tagTitle, int? tagAmount}) =>
      TagChartRecord(
        dataId: dataId ?? this.dataId,
        tagTitle: tagTitle ?? this.tagTitle,
        tagAmount: tagAmount ?? this.tagAmount,
      );
  @override
  String toString() {
    return (StringBuffer('TagChartRecord(')
          ..write('dataId: $dataId, ')
          ..write('tagTitle: $tagTitle, ')
          ..write('tagAmount: $tagAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dataId, tagTitle, tagAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagChartRecord &&
          other.dataId == this.dataId &&
          other.tagTitle == this.tagTitle &&
          other.tagAmount == this.tagAmount);
}

class TagChartRecordsCompanion extends UpdateCompanion<TagChartRecord> {
  final Value<int> dataId;
  final Value<String> tagTitle;
  final Value<int?> tagAmount;
  const TagChartRecordsCompanion({
    this.dataId = const Value.absent(),
    this.tagTitle = const Value.absent(),
    this.tagAmount = const Value.absent(),
  });
  TagChartRecordsCompanion.insert({
    this.dataId = const Value.absent(),
    required String tagTitle,
    this.tagAmount = const Value.absent(),
  }) : tagTitle = Value(tagTitle);
  static Insertable<TagChartRecord> custom({
    Expression<int>? dataId,
    Expression<String>? tagTitle,
    Expression<int?>? tagAmount,
  }) {
    return RawValuesInsertable({
      if (dataId != null) 'data_id': dataId,
      if (tagTitle != null) 'tag_title': tagTitle,
      if (tagAmount != null) 'tag_amount': tagAmount,
    });
  }

  TagChartRecordsCompanion copyWith(
      {Value<int>? dataId, Value<String>? tagTitle, Value<int?>? tagAmount}) {
    return TagChartRecordsCompanion(
      dataId: dataId ?? this.dataId,
      tagTitle: tagTitle ?? this.tagTitle,
      tagAmount: tagAmount ?? this.tagAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dataId.present) {
      map['data_id'] = Variable<int>(dataId.value);
    }
    if (tagTitle.present) {
      map['tag_title'] = Variable<String>(tagTitle.value);
    }
    if (tagAmount.present) {
      map['tag_amount'] = Variable<int?>(tagAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagChartRecordsCompanion(')
          ..write('dataId: $dataId, ')
          ..write('tagTitle: $tagTitle, ')
          ..write('tagAmount: $tagAmount')
          ..write(')'))
        .toString();
  }
}

class $TagChartRecordsTable extends TagChartRecords
    with TableInfo<$TagChartRecordsTable, TagChartRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagChartRecordsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _dataIdMeta = const VerificationMeta('dataId');
  @override
  late final GeneratedColumn<int?> dataId = GeneratedColumn<int?>(
      'data_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _tagTitleMeta = const VerificationMeta('tagTitle');
  @override
  late final GeneratedColumn<String?> tagTitle = GeneratedColumn<String?>(
      'tag_title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _tagAmountMeta = const VerificationMeta('tagAmount');
  @override
  late final GeneratedColumn<int?> tagAmount = GeneratedColumn<int?>(
      'tag_amount', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [dataId, tagTitle, tagAmount];
  @override
  String get aliasedName => _alias ?? 'tag_chart_records';
  @override
  String get actualTableName => 'tag_chart_records';
  @override
  VerificationContext validateIntegrity(Insertable<TagChartRecord> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('data_id')) {
      context.handle(_dataIdMeta,
          dataId.isAcceptableOrUnknown(data['data_id']!, _dataIdMeta));
    }
    if (data.containsKey('tag_title')) {
      context.handle(_tagTitleMeta,
          tagTitle.isAcceptableOrUnknown(data['tag_title']!, _tagTitleMeta));
    } else if (isInserting) {
      context.missing(_tagTitleMeta);
    }
    if (data.containsKey('tag_amount')) {
      context.handle(_tagAmountMeta,
          tagAmount.isAcceptableOrUnknown(data['tag_amount']!, _tagAmountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dataId};
  @override
  TagChartRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TagChartRecord.fromData(data, attachedDatabase,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TagChartRecordsTable createAlias(String alias) {
    return $TagChartRecordsTable(attachedDatabase, alias);
  }
}

abstract class _$ComparisonItemDB extends GeneratedDatabase {
  _$ComparisonItemDB(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $ComparisonOverviewRecordsTable comparisonOverviewRecords =
      $ComparisonOverviewRecordsTable(this);
  late final $Way1MeritRecordsTable way1MeritRecords =
      $Way1MeritRecordsTable(this);
  late final $Way1DemeritRecordsTable way1DemeritRecords =
      $Way1DemeritRecordsTable(this);
  late final $Way2MeritRecordsTable way2MeritRecords =
      $Way2MeritRecordsTable(this);
  late final $Way2DemeritRecordsTable way2DemeritRecords =
      $Way2DemeritRecordsTable(this);
  late final $TagRecordsTable tagRecords = $TagRecordsTable(this);
  late final $TagChartRecordsTable tagChartRecords =
      $TagChartRecordsTable(this);
  late final ComparisonItemDao comparisonItemDao =
      ComparisonItemDao(this as ComparisonItemDB);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        comparisonOverviewRecords,
        way1MeritRecords,
        way1DemeritRecords,
        way2MeritRecords,
        way2DemeritRecords,
        tagRecords,
        tagChartRecords
      ];
}
