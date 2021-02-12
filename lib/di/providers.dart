import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:compare_2way/view_model/add_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> globalProviders = [
  ...independentModels,
  ...dependentModels,
  ...viewModels,
];

List<SingleChildWidget> independentModels =[
//  Provider<CompareListDB>(
//    create(_) => CompareListDB(),
//    dispose: (_, db) => db.close(),
//  ),
  ];

List<SingleChildWidget> dependentModels =[
//  ProxyProvider<CompareListDB,CompareListDao>(
//    update: (_,db,dao)=>CompareListDao(db),
//  ),
  ];

List<SingleChildWidget> viewModels =[
ChangeNotifierProvider<AddViewModel>(
  create: (context)=>AddViewModel(
    compareRepository: Provider.of<CompareRepository>(context,listen: false),
  ),
)
  ];