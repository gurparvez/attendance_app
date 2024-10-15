class ChangeAttendanceModel {
  String? _date;
  String? _subjectId;
  String? _studentId;
  String? _sId;
  String? _createdAt;
  String? _updatedAt;
  int? _iV;

  ChangeAttendanceModel({
    String? date,
    String? subjectId,
    String? studentId,
    String? sId,
    String? createdAt,
    String? updatedAt,
    int? iV,
  }) {
    if (date != null) {
      _date = date;
    }
    if (subjectId != null) {
      _subjectId = subjectId;
    }
    if (studentId != null) {
      _studentId = studentId;
    }
    if (sId != null) {
      _sId = sId;
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

  String? get date => _date;
  set date(String? date) => _date = date;
  String? get subjectId => _subjectId;
  set subjectId(String? subjectId) => _subjectId = subjectId;
  String? get studentId => _studentId;
  set studentId(String? studentId) => _studentId = studentId;
  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;

  ChangeAttendanceModel.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _subjectId = json['subjectId'];
    _studentId = json['studentId'];
    _sId = json['_id'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = _date;
    data['subjectId'] = _subjectId;
    data['studentId'] = _studentId;
    data['_id'] = _sId;
    data['createdAt'] = _createdAt;
    data['updatedAt'] = _updatedAt;
    data['__v'] = _iV;
    return data;
  }
}
