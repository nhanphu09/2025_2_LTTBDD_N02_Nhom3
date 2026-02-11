import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/student.dart';
import '../providers/app_state.dart';
import '../utils/app_localizations.dart';

class StudentListTab extends StatefulWidget {
  const StudentListTab({super.key});
  @override
  State<StudentListTab> createState() => _StudentListTabState();
}

class _StudentListTabState extends State<StudentListTab> {
  String _searchQuery = "";

  void _showStudentDialog(BuildContext context, {Student? student}) {
    final nameCtrl = TextEditingController(text: student?.name ?? "");
    final mssvCtrl = TextEditingController(text: student?.mssv ?? "");
    final majorCtrl = TextEditingController(text: student?.major ?? "");
    final deptCtrl = TextEditingController(text: student?.department ?? "");
    final yearCtrl = TextEditingController(text: student?.year ?? "");
    final dobCtrl = TextEditingController(text: student?.dob ?? "");
    final phoneCtrl = TextEditingController(text: student?.phone ?? "");

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          student == null
              ? AppLocalizations.t(ctx, 'add_student')
              : AppLocalizations.t(ctx, 'edit_student'),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogInput(ctx, nameCtrl, 'name', Icons.person),
              _buildDialogInput(ctx, mssvCtrl, 'mssv', Icons.badge),
              _buildDialogInput(ctx, majorCtrl, 'major', Icons.school),
              _buildDialogInput(ctx, deptCtrl, 'dept', Icons.apartment),
              _buildDialogInput(ctx, yearCtrl, 'school_year', Icons.timeline),
              _buildDialogInput(ctx, dobCtrl, 'dob', Icons.calendar_month),
              _buildDialogInput(ctx, phoneCtrl, 'phone', Icons.phone),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              AppLocalizations.t(ctx, 'cancel'),
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              final newStudent = Student(
                id: student?.id ?? DateTime.now().toString(),
                name: nameCtrl.text,
                mssv: mssvCtrl.text,
                major: majorCtrl.text,
                department: deptCtrl.text,
                year: yearCtrl.text,
                dob: dobCtrl.text,
                phone: phoneCtrl.text,
              );

              if (student == null) {
                Provider.of<AppState>(
                  context,
                  listen: false,
                ).addStudent(newStudent);
              } else {
                Provider.of<AppState>(
                  context,
                  listen: false,
                ).updateStudent(newStudent);
              }
              Navigator.pop(ctx);
            },
            child: Text(AppLocalizations.t(ctx, 'save')),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogInput(
    BuildContext ctx,
    TextEditingController ctrl,
    String labelKey,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          labelText: AppLocalizations.t(ctx, labelKey),
          prefixIcon: Icon(icon, size: 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          isDense: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final filtered = appState.students
        .where(
          (s) =>
              s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              s.mssv.contains(_searchQuery),
        )
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStudentDialog(context),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[100],
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: AppLocalizations.t(context, 'search'),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final s = filtered[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            s.name.substring(0, 1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "MSSV: ${s.mssv}",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                "${AppLocalizations.t(context, 'major')}: ${s.major}",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                s.year,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () =>
                              _showStudentDialog(context, student: s),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => appState.deleteStudent(s.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
