class SubjectAttendanceModel {
  String? _date;
  String? _dayType;
  bool? _present;
  bool? _facultyPresent;

  SubjectAttendanceModel(
      {String? date, String? dayType, bool? present, bool? facultyPresent}) {
    if (date != null) {
      _date = date;
    }
    if (dayType != null) {
      _dayType = dayType;
    }
    if (present != null) {
      _present = present;
    }
    if (facultyPresent != null) {
      _facultyPresent = facultyPresent;
    }
  }

  String? get date => _date;
  set date(String? date) => _date = date;
  String? get dayType => _dayType;
  set dayType(String? dayType) => _dayType = dayType;
  bool? get present => _present;
  set present(bool? present) => _present = present;
  bool? get facultyPresent => _facultyPresent;
  set facultyPresent(bool? facultyPresent) => _facultyPresent = facultyPresent;

  SubjectAttendanceModel.fromJson(Map<String, dynamic> json) {
    _date = json['date'];
    _dayType = json['dayType'];
    _present = json['present'];
    _facultyPresent = json['facultyPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = _date;
    data['dayType'] = _dayType;
    data['present'] = _present;
    data['facultyPresent'] = _facultyPresent;
    return data;
  }
}
