class StudentModel {
  String? _sId;
  User? _user;
  Course? _course;
  Department? _department;

  StudentModel(
      {String? sId, User? user, Course? course, Department? department}) {
    if (sId != null) {
      _sId = sId;
    }
    if (user != null) {
      _user = user;
    }
    if (course != null) {
      _course = course;
    }
    if (department != null) {
      _department = department;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  User? get user => _user;
  set user(User? user) => _user = user;
  Course? get course => _course;
  set course(Course? course) => _course = course;
  Department? get department => _department;
  set department(Department? department) => _department = department;

  StudentModel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _course =
    json['course'] != null ? Course.fromJson(json['course']) : null;
    _department = json['department'] != null
        ? Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    if (_course != null) {
      data['course'] = _course!.toJson();
    }
    if (_department != null) {
      data['department'] = _department!.toJson();
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

class Course {
  String? _sId;
  String? _name;
  int? _semester;
  String? _departmentId;
  String? _createdAt;
  String? _updatedAt;
  int? _iV;

  Course(
      {String? sId,
        String? name,
        int? semester,
        String? departmentId,
        String? createdAt,
        String? updatedAt,
        int? iV}) {
    if (sId != null) {
      _sId = sId;
    }
    if (name != null) {
      _name = name;
    }
    if (semester != null) {
      _semester = semester;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get semester => _semester;
  set semester(int? semester) => _semester = semester;
  String? get departmentId => _departmentId;
  set departmentId(String? departmentId) => _departmentId = departmentId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;

  Course.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _semester = json['semester'];
    _departmentId = json['departmentId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['name'] = _name;
    data['semester'] = _semester;
    data['departmentId'] = _departmentId;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['__v'] = _iV;
    return data;
  }
}

class Department {
  String? _sId;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  int? _iV;

  Department(
      {String? sId,
        String? name,
        String? createdAt,
        String? updatedAt,
        int? iV}) {
    if (sId != null) {
      _sId = sId;
    }
    if (name != null) {
      _name = name;
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
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;

  Department.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['name'] = _name;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['__v'] = _iV;
    return data;
  }
}
