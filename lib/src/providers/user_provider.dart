import 'package:attendance_app/src/models/user.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends Notifier<UserModel?> {
  @override
  UserModel? build() {
    return null;
  }

  void setUser(UserModel user) {
    state = user;
  }
}

final userProvider =
NotifierProvider<UserNotifier, UserModel?>(UserNotifier.new);
