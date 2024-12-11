import 'package:attendance_app/src/models/teacher.model.dart';
import 'package:attendance_app/src/models/student.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

sealed class AppUser {
  final dynamic user;

  const AppUser({required this.user});
}

class StudentUser extends AppUser {
  final StudentModel student;

  StudentUser({required this.student}) : super(user: student.user);
}

class TeacherUser extends AppUser {
  final TeacherModel teacher;

  TeacherUser({required this.teacher}) : super(user: teacher.user);
}

class UserNotifier extends StateNotifier<AppUser?> {
  UserNotifier() : super(null);

  void setUser(dynamic user) {
    if (user is StudentModel) {
      state = StudentUser(student: user);
    } else if (user is TeacherModel) {
      state = TeacherUser(teacher: user);
    }
    debugPrint("state: $state");
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, AppUser?>((ref) {
  return UserNotifier();
});
