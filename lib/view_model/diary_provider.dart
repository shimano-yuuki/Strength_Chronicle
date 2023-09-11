
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/diary/diary_repository.dart';
import '../model/diary/diary_service.dart';
import '../model/diary/diary_state.dart';

final diaryProvider = FutureProvider<List<Diary>>((ref) async {
  final service = DiaryService(repository: DiaryRepository());
  return await service.getUsersInfo();
});

