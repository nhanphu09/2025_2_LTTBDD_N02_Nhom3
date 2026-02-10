class Student {
  String id;
  String name;
  String mssv;
  String major;
  String department;
  String year;
  String dob;
  String phone;

  Student({
    required this.id,
    required this.name,
    required this.mssv,
    required this.major,
    required this.department,
    required this.year,
    required this.dob,
    required this.phone,
  });
}

class GroupMember {
  final String name;
  final String mssv;
  final String hometown;
  GroupMember({required this.name, required this.mssv, required this.hometown});
}
