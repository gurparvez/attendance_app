import 'package:attendance_app/src/models/student.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentNotifier extends Notifier<StudentModel?> {
  @override
  StudentModel? build() {
    return null;
  }

  void setStudent(StudentModel student) {
    state = student;
  }
}

final studentProvider =
    NotifierProvider<StudentNotifier, StudentModel?>(StudentNotifier.new);
