class ComparisonOverview {
  ComparisonOverview(
      {this.dataId,
        this.comparisonItemId,
        this.itemTitle,
        this.way1Title,
        this.way1Evaluate,
        this.way2Title,
        this.way2Evaluate,
        this.way3Title,
        this.way3Evaluate,
        this.favorite,
        this.conclusion});

  final int dataId;
  final String comparisonItemId;
  final String itemTitle;

  final String way1Title;
  final int way1Evaluate;

  final String way2Title;
  final int way2Evaluate;

  final String way3Title;
  final int way3Evaluate;

  final bool favorite;
  final String conclusion;
}
