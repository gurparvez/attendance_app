import 'package:attendance_app/src/models/teacher.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherNotifier extends Notifier<TeacherModel?> {
  @override
  TeacherModel? build() {
    return null;
  }

  void setTeacher(TeacherModel teacher) {
    state = teacher;
  }
}

final teacherProvider =
    NotifierProvider<TeacherNotifier, TeacherModel?>(TeacherNotifier.new);
