class StudentsAttendanceModel {
  String? _subject;
  List<Students>? _students;

  StudentsAttendanceModel({String? subject, List<Students>? students}) {
    if (subject != null) {
      _subject = subject;
    }
    if (students != null) {
      _students = students;
    }
  }

  String? get subject => _subject;
  set subject(String? subject) => _subject = subject;
  List<Students>? get students => _students;
  set students(List<Students>? students) => _students = students;

  StudentsAttendanceModel.fromJson(Map<String, dynamic> json) {
    _subject = json['subject'];
    if (json['students'] != null) {
      _students = <Students>[];
      json['students'].forEach((v) {
        _students!.add(Students.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subject'] = _subject;
    if (_students != null) {
      data['students'] = _students!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Students {
  String? _sId;
  User? _user;
  bool? _present;

  Students({String? sId, User? user, bool? present}) {
    if (sId != null) {
      _sId = sId;
    }
    if (user != null) {
      _user = user;
    }
    if (present != null) {
      _present = present;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  User? get user => _user;
  set user(User? user) => _user = user;
  bool? get present => _present;
  set present(bool? present) => _present = present;

  Students.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _present = json['present'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    data['present'] = _present;
    return data;
  }
}

class User {
  String? _sId;
  String? _auid;
  String? _name;
  String? _email;
  String? _role;
  String? _departmentId;
  String? _createdAt;
  String? _updatedAt;
  int? _iV;

  User(
      {String? sId,
        String? auid,
        String? name,
        String? email,
        String? role,
        String? departmentId,
        String? createdAt,
        String? updatedAt,
        int? iV}) {
    if (sId != null) {
      _sId = sId;
    }
    if (auid != null) {
      _auid = auid;
    }
    if (name != null) {
      _name = name;
    }
    if (email != null) {
      _email = email;
    }
    if (role != null) {
      _role = role;
    }
    if (departmentId != null) {
      _departmentId = departmentId;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (iV != null) {
      _iV = iV;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get auid => _auid;
  set auid(String? auid) => _auid = auid;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get departmentId => _departmentId;
  set departmentId(String? departmentId) => _departmentId = departmentId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;

  User.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _auid = json['auid'];
    _name = json['name'];
    _email = json['email'];
    _role = json['role'];
    _departmentId = json['departmentId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['auid'] = _auid;
    data['name'] = _name;
    data['email'] = _email;
    data['role'] = _role;
    data['departmentId'] = _departmentId;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['__v'] = _iV;
    return data;
  }
}
