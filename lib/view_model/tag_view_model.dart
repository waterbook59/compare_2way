import 'package:compare_2way/data_models/tag.dart';
import 'package:compare_2way/models/repository/compare_repository.dart';
import 'package:flutter/material.dart';

class TagViewModel extends ChangeNotifier{

  TagViewModel({
    CompareRepository compareRepository,
  }) : _compareRepository = compareRepository;

  final CompareRepository _compareRepository;

  List<Tag> _tagList = <Tag>[];
  List<Tag> get tagList => _tagList;

  ///TagPageのFutureBuilder用
  Future<List<Tag>> getAllTagList() async {
    _tagList = await _compareRepository.getAllTagList();
        print('viewModel.getTagAllList:${_tagList.map((e) => e.tagTitle)}');
    return _tagList;

  }


}