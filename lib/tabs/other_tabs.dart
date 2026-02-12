import 'package:flutter/material.dart';
import '../models/student.dart';

// --- 1. ScheduleTab: Có tính năng Lọc ---
class ScheduleTab extends StatefulWidget {
  const ScheduleTab({super.key});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  // Trạng thái lọc hiện tại
  String _selectedDay = 'Tất cả';

  // Danh sách các ngày để chọn
  final List<String> _days = [
    'Tất cả',
    'Thứ 2',
    'Thứ 3',
    'Thứ 4',
    'Thứ 5',
    'Thứ 6',
    'Thứ 7',
    'Chủ nhật',
  ];

  // Dữ liệu mẫu phong phú hơn để hiển thị đẹp như thiết kế
  final List<Map<String, String>> _allClasses = [
    {
      'sub': 'Lập Trình Mobile',
      'time': '07:30 - 09:00',
      'teacher': 'Hà Thị Kim Dung',
      'room': 'A6-503 (PC)',
      'date': 'Thứ 2',
      'fullDate': '04/03/2025',
    },
    {
      'sub': 'Cấu trúc dữ liệu',
      'time': '09:10 - 10:40',
      'teacher': 'Trần Văn A',
      'room': 'A6-504 (PC)',
      'date': 'Thứ 3',
      'fullDate': '05/03/2025',
    },
    {
      'sub': 'Hệ Điều Hành',
      'time': '13:00 - 14:30',
      'teacher': 'Nguyễn Thị C',
      'room': 'A6-305',
      'date': 'Thứ 4',
      'fullDate': '06/03/2025',
    },
    // Thêm một môn Thứ 2 nữa để test bộ lọc
    {
      'sub': 'Tiếng Anh Chuyên Ngành',
      'time': '09:10 - 11:00',
      'teacher': 'Ms. Emily',
      'room': 'B1-101',
      'date': 'Thứ 2',
      'fullDate': '04/03/2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Logic lọc danh sách
    final filteredList = _selectedDay == 'Tất cả'
        ? _allClasses
        : _allClasses.where((item) => item['date'] == _selectedDay).toList();

    return Column(
      children: [
        // Phần Header và Bộ lọc
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Thời Khóa Biểu",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              // Menu chọn ngày
              PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    _selectedDay = value;
                  });
                },
                itemBuilder: (BuildContext context) {
                  return _days.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Text(
                        _selectedDay,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.filter_list,
                        size: 18,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Danh sách môn học
        Expanded(
          child: filteredList.isEmpty
              ? const Center(
                  child: Text(
                    "Không có lịch học",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: filteredList.length,
                  itemBuilder: (ctx, i) {
                    final item = filteredList[i];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    item['sub']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    item['date']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(),
                            _buildInfoRow(
                              Icons.access_time,
                              "Thời gian:",
                              item['time']!,
                            ),
                            const SizedBox(height: 6),
                            _buildInfoRow(
                              Icons.person,
                              "Giảng viên:",
                              item['teacher']!,
                            ),
                            const SizedBox(height: 6),
                            _buildInfoRow(Icons.room, "Phòng:", item['room']!),
                            const SizedBox(height: 6),
                            _buildInfoRow(
                              Icons.calendar_today,
                              "Ngày:",
                              item['fullDate']!,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text("$label ", style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// --- 2. ExamScheduleTab (Giữ nguyên) ---
class ExamScheduleTab extends StatelessWidget {
  const ExamScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'sub': 'Lập Trình Mobile', 'type': 'Trắc nghiệm', 'date': '15/04/2026'},
      {'sub': 'Cấu trúc dữ liệu', 'type': 'Thực hành', 'date': '25/04/2026'},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (ctx, i) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: const Icon(
            Icons.calendar_month,
            color: Colors.redAccent,
            size: 40,
          ),
          title: Text(
            items[i]['sub']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("${items[i]['type']} - Ngày: ${items[i]['date']}"),
        ),
      ),
    );
  }
}

// --- 3. GroupInfoTab (Cập nhật dữ liệu của bạn) ---
class GroupInfoTab extends StatelessWidget {
  const GroupInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      GroupMember(
        name: 'Nguyễn Văn Phú',
        mssv: '22010801',
        hometown: 'Thái Bình',
      ),
      GroupMember(
        name: 'Nguyễn Tuấn Anh',
        mssv: '23010800',
        hometown: 'Bắc Ninh',
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            "Nhóm 3 - LTTBDD N02",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: members
                .map(
                  (m) => Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.purple,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              m.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "MSSV: ${m.mssv}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Quê: ${m.hometown}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
