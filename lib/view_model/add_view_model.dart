import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';

class AddViewModel extends ChangeNotifier{
  AddViewModel({
    CompareRepository compareRepository,
}):_compareRepository =compareRepository;

  final CompareRepository _compareRepository;

}

