import 'package:flutter/material.dart';
import '../models/student.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'sub': 'Lập Trình Mobile',
        'time': '07:30 - 09:00',
        'room': 'A6-503',
        'date': 'Thứ 2',
      },
      {
        'sub': 'Cấu trúc dữ liệu',
        'time': '09:10 - 10:40',
        'room': 'A6-504',
        'date': 'Thứ 3',
      },
      {
        'sub': 'Hệ Điều Hành',
        'time': '13:00 - 14:30',
        'room': 'A6-305',
        'date': 'Thứ 4',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (ctx, i) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            items[i]['sub']!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text("Time: ${items[i]['time']}"),
              Text("Room: ${items[i]['room']}"),
              Text(
                items[i]['date']!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          trailing: const Icon(Icons.access_time_filled, color: Colors.blue),
        ),
      ),
    );
  }
}

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
