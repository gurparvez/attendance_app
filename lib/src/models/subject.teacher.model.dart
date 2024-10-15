class SubjectTeacherModel {
  String? _sId;
  String? _name;
  String? _courseId;
  String? _facultyId;
  String? _createdAt;
  String? _updatedAt;
  int? _iV;
  List<Course>? _course;

  SubjectTeacherModel({
    String? sId,
    String? name,
    String? courseId,
    String? facultyId,
    String? createdAt,
    String? updatedAt,
    int? iV,
    List<Course>? course,
  }) {
    if (sId != null) {
      _sId = sId;
    }
    if (name != null) {
      _name = name;
    }
    if (courseId != null) {
      _courseId = courseId;
    }
    if (facultyId != null) {
      _facultyId = facultyId;
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
    if (course != null) {
      _course = course;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get courseId => _courseId;
  set courseId(String? courseId) => _courseId = courseId;
  String? get facultyId => _facultyId;
  set facultyId(String? facultyId) => _facultyId = facultyId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;
  List<Course>? get course => _course;
  set course(List<Course>? course) => _course = course;

  SubjectTeacherModel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _name = json['name'];
    _courseId = json['courseId'];
    _facultyId = json['facultyId'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _iV = json['__v'];
    if (json['course'] != null) {
      _course = <Course>[];
      json['course'].forEach((v) {
        _course!.add(Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = _sId;
    data['name'] = _name;
    data['courseId'] = _courseId;
    data['facultyId'] = _facultyId;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['__v'] = _iV;
    if (_course != null) {
      data['course'] = _course!.map((v) => v.toJson()).toList();
    }
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
