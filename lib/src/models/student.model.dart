class StudentModel {
  String? _sId;
  User? _user;
  Course? _course;
  Department? _department;

  StudentModel(
      {String? sId, User? user, Course? course, Department? department}) {
    if (sId != null) {
      this._sId = sId;
    }
    if (user != null) {
      this._user = user;
    }
    if (course != null) {
      this._course = course;
    }
    if (department != null) {
      this._department = department;
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
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _course =
    json['course'] != null ? new Course.fromJson(json['course']) : null;
    _department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    if (this._course != null) {
      data['course'] = this._course!.toJson();
    }
    if (this._department != null) {
      data['department'] = this._department!.toJson();
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
      this._sId = sId;
    }
    if (auid != null) {
      this._auid = auid;
    }
    if (name != null) {
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (role != null) {
      this._role = role;
    }
    if (departmentId != null) {
      this._departmentId = departmentId;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (iV != null) {
      this._iV = iV;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['auid'] = this._auid;
    data['name'] = this._name;
    data['email'] = this._email;
    data['role'] = this._role;
    data['departmentId'] = this._departmentId;
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['__v'] = this._iV;
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
      this._sId = sId;
    }
    if (name != null) {
      this._name = name;
    }
    if (semester != null) {
      this._semester = semester;
    }
    if (departmentId != null) {
      this._departmentId = departmentId;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (iV != null) {
      this._iV = iV;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['semester'] = this._semester;
    data['departmentId'] = this._departmentId;
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['__v'] = this._iV;
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
      this._sId = sId;
    }
    if (name != null) {
      this._name = name;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (iV != null) {
      this._iV = iV;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this._sId;
    data['name'] = this._name;
    data['createdAt'] = this._createdAt;
    data['updatedAt'] = this._updatedAt;
    data['__v'] = this._iV;
    return data;
  }
}
