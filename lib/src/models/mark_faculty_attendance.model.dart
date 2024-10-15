class MarkFacultyAttendanceModel {
  String? _facultyId;
  String? _subjectId;
  String? _date;
  String? _sId;
  int? _iV;

  MarkFacultyAttendanceModel(
      {String? facultyId,
        String? subjectId,
        String? date,
        String? sId,
        int? iV}) {
    if (facultyId != null) {
      _facultyId = facultyId;
    }
    if (subjectId != null) {
      _subjectId = subjectId;
    }
    if (date != null) {
      _date = date;
    }
    if (sId != null) {
      _sId = sId;
    }
    if (iV != null) {
      _iV = iV;
    }
  }

  String? get facultyId => _facultyId;
  set facultyId(String? facultyId) => _facultyId = facultyId;
  String? get subjectId => _subjectId;
  set subjectId(String? subjectId) => _subjectId = subjectId;
  String? get date => _date;
  set date(String? date) => _date = date;
  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;

  MarkFacultyAttendanceModel.fromJson(Map<String, dynamic> json) {
    _facultyId = json['facultyId'];
    _subjectId = json['subjectId'];
    _date = json['date'];
    _sId = json['_id'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facultyId'] = _facultyId;
    data['subjectId'] = _subjectId;
    data['date'] = _date;
    data['_id'] = _sId;
    data['__v'] = _iV;
    return data;
  }
}
