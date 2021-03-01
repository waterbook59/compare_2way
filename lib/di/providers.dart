import 'package:compare_2way/models/db/comparison_item/comparison_item_dao.dart';
import 'package:compare_2way/models/db/comparison_item/comparison_item_database.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:compare_2way/view_model/compare_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels =[
  Provider<ComparisonItemDB>(
    create:(_) => ComparisonItemDB(),
    dispose: (_, db) => db.close(),
  ),
  ];

List<SingleChildWidget> dependentModels =[
  ProxyProvider<ComparisonItemDB,ComparisonItemDao>(
    update: (_,db,dao)=>ComparisonItemDao(db),
  ),
  ProxyProvider<ComparisonItemDao,CompareRepository>(
    update: (_,dao,repository)=>CompareRepository(comparisonItemDao: dao),
  ),

  ];

List<SingleChildWidget> viewModels =[
//  ChangeNotifierProvider<ListViewModel>(
//    create: (context)=>ListViewModel(
//      compareRepository: Provider.of<CompareRepository>(context,listen: false),
//    ),
//  ),
  ChangeNotifierProvider<AddViewModel>(
  create: (context)=>AddViewModel(
    compareRepository: Provider.of<CompareRepository>(context,listen: false),
    ),
  ),
  ChangeNotifierProvider<CompareViewModel>(
    create: (context)=>CompareViewModel(
      compareRepository: Provider.of<CompareRepository>(context,listen: false),
    ),
  )
  ];