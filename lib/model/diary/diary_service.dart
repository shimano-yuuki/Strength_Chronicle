import 'package:workout_app/model/diary/diary_state.dart';

import 'diary_repository.dart';

class DiaryService {
  const DiaryService({
    required DiaryRepository repository,
  }) : _repository = repository;
  final DiaryRepository _repository;

  Future<List<Diary>> getUsersInfo() {
    return _repository.getDiaryInfo();
  }
}