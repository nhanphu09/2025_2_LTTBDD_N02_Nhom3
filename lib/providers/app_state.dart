import 'package:flutter/material.dart';
import '../models/student.dart';

class AppState extends ChangeNotifier {
  bool _isDark = false;
  Locale _locale = const Locale('vi');

  bool get isDark => _isDark;
  Locale get locale => _locale;

  void toggleTheme(bool value) {
    _isDark = value;
    notifyListeners();
  }

  void changeLanguage(String langCode) {
    _locale = Locale(langCode);
    notifyListeners();
  }

  // Mock Data
  final List<Student> _students = [
    Student(
      id: '1',
      name: 'Nguyễn Văn A',
      mssv: '22010088',
      major: 'CNTT',
      department: 'Công Nghệ Thông Tin',
      year: '2022-2026',
      dob: '01/01/2004',
      phone: '0123456789',
    ),
    Student(
      id: '2',
      name: 'Trần Thị B',
      mssv: '22010089',
      major: 'Kinh Tế',
      department: 'Quản Trị Kinh Doanh',
      year: '2021-2025',
      dob: '02/02/2003',
      phone: '0987654321',
    ),
  ];

  List<Student> get students => _students;

  void addStudent(Student s) {
    _students.add(s);
    notifyListeners();
  }

  void updateStudent(Student s) {
    int index = _students.indexWhere((element) => element.id == s.id);
    if (index != -1) {
      _students[index] = s;
      notifyListeners();
    }
  }

  void deleteStudent(String id) {
    _students.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    return true;
  }
}
