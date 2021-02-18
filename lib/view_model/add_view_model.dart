import 'package:compare_2way/data_models/comparison_item.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddViewModel extends ChangeNotifier{
  AddViewModel({
    CompareRepository compareRepository,
}):_compareRepository = compareRepository;

  final CompareRepository _compareRepository;

  TextEditingController get way1Controller=> _way1Controller ;
  TextEditingController get way2Controller => _way2Controller;
  //the getter 'text' was called on null flutterエラーがでたら
  // TextEditingController();必要
  // It looks like you have not initialized your TextEditingController.
  TextEditingController _way1Controller =TextEditingController();
  TextEditingController _way2Controller = TextEditingController();


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

}

