class StudentModel {
  User? _user;
  Student? _student;

  StudentModel({User? user, Student? student}) {
    if (user != null) {
      _user = user;
    }
    if (student != null) {
      _student = student;
    }
  }

  User? get user => _user;

  set user(User? user) => _user = user;

  Student? get student => _student;

  set student(Student? student) => _student = student;

  StudentModel.fromJson(Map<String, dynamic> json) {
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _student =
        json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    if (_student != null) {
      data['student'] = _student!.toJson();
    }
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

  User({
    String? sId,
    String? auid,
    String? name,
    String? email,
    String? role,
    String? departmentId,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) {
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

class Student {
  String? _sId;
  String? _userId;
  String? _courseId;
  String? _createdAt;
  String? _updatedAt;
  int? _iV;

  Student(
      {String? sId,
      String? userId,
      String? courseId,
      String? createdAt,
      String? updatedAt,
      int? iV}) {
    if (sId != null) {
      _sId = sId;
    }
    if (userId != null) {
      _userId = userId;
    }
    if (courseId != null) {
      _courseId = courseId;
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

  String? get userId => _userId;

  set userId(String? userId) => _userId = userId;

  String? get courseId => _courseId;

  set courseId(String? courseId) => _courseId = courseId;

  String? get createdAt => _createdAt;

  set createdAt(String? createdAt) => _createdAt = createdAt;

  String? get updatedAt => _updatedAt;

  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  int? get iV => _iV;

  set iV(int? iV) => _iV = iV;

  Student.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _userId = json['userId'];
    _courseId = json['courseId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['userId'] = _userId;
    data['courseId'] = _courseId;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['__v'] = _iV;
    return data;
  }
}
