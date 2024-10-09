class IsTeacherPresentModel {
  String? _sId;
  String? _facultyId;
  String? _subjectId;
  String? _date;
  int? _iV;

  IsTeacherPresentModel(
      {String? sId,
        String? facultyId,
        String? subjectId,
        String? date,
        int? iV}) {
    if (sId != null) {
      _sId = sId;
    }
    if (facultyId != null) {
      _facultyId = facultyId;
    }
    if (subjectId != null) {
      _subjectId = subjectId;
    }
    if (date != null) {
      _date = date;
    }
    if (iV != null) {
      _iV = iV;
    }
  }

  String? get sId => _sId;
  set sId(String? sId) => _sId = sId;
  String? get facultyId => _facultyId;
  set facultyId(String? facultyId) => _facultyId = facultyId;
  String? get subjectId => _subjectId;
  set subjectId(String? subjectId) => _subjectId = subjectId;
  String? get date => _date;
  set date(String? date) => _date = date;
  int? get iV => _iV;
  set iV(int? iV) => _iV = iV;

  IsTeacherPresentModel.fromJson(Map<String, dynamic> json) {
    _sId = json['_id'];
    _facultyId = json['facultyId'];
    _subjectId = json['subjectId'];
    _date = json['date'];
    _iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = _sId;
    data['facultyId'] = _facultyId;
    data['subjectId'] = _subjectId;
    data['date'] = _date;
    data['__v'] = _iV;
    return data;
  }
}
