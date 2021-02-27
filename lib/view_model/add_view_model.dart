import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddViewModel extends ChangeNotifier{
  AddViewModel({
    CompareRepository compareRepository,
}):_compareRepository = compareRepository;

  final CompareRepository _compareRepository;

//  TextEditingController _titleController =TextEditingController();
//  TextEditingController get titleController=> _titleController ;
  String title ='';
  TextEditingController _way1Controller =TextEditingController();
  TextEditingController get way1Controller=> _way1Controller ;
  String way1Title='';
  TextEditingController _way2Controller = TextEditingController();
  TextEditingController get way2Controller => _way2Controller;
  String way2Title='';

  //テキスト入力してるかどうか
  bool  isCreateItemEnabled = false;
//  bool  _isCreateItemEnabled = false;
//  bool get isCreateItemEnabled => _isCreateItemEnabled;


  Future<void> createComparisonItems(ComparisonItem comparisonItem) async{

    await _compareRepository.createComparisonItems(comparisonItem);
    print('DBへ登録');
    notifyListeners();

  }

  Future<void> initializeController() async{
    _way1Controller.text ='';
    _way2Controller.text ='';
    notifyListeners();
  }

//todo 登録・更新時createdAtをDateTime.now()に変更
  //todo textControllerを破棄

}

