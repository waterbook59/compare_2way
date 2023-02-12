class ComparisonOverview {
  ComparisonOverview(
      {this.dataId,
        required this.comparisonItemId,
        required this.itemTitle,
        required this.way1Title,
        required this.way1MeritEvaluate,
        required this.way1DemeritEvaluate,
        required this.way2Title,
        required this.way2MeritEvaluate,
        required this.way2DemeritEvaluate,
        this.way3Title,
        this.way3MeritEvaluate,
        this.way3DemeritEvaluate,
        this.favorite,
        this.conclusion,
      required this.createdAt});

  final int? dataId;
  final String comparisonItemId;
  final String itemTitle;

  final String way1Title;
  final int way1MeritEvaluate;
  final int way1DemeritEvaluate;

  final String way2Title;
  final int way2MeritEvaluate;
  final int way2DemeritEvaluate;

  final String? way3Title;
  final int? way3MeritEvaluate;
  final int? way3DemeritEvaluate;

  final bool? favorite;
  final String? conclusion;
  final DateTime createdAt;
}
