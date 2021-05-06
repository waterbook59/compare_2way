import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';

class TagViewModel extends ChangeNotifier{

  TagViewModel({
    CompareRepository compareRepository,
  }) : _compareRepository = compareRepository;

  final CompareRepository _compareRepository;

}