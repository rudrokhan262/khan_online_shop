import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final surahs = db.quranSurahs;

    return Scaffold(
      appBar: AppBar(title: const Text("Al-Qur'an al-Kareem")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: surahs.length,
        itemBuilder: (context, index) {
          final s = surahs[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green.shade100,
                child: Text('${s.number}', style: const TextStyle(color: Color(0xFF1B5E20), fontWeight: FontWeight.bold)),
              ),
              title: Text(s.englishName, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${s.englishNameTranslation} • ${s.numberOfAyahs} Ayahs (${s.revelationType})'),
              trailing: Text(s.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'serif')),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(s.englishName),
                    content: Text('Surah ${s.name} (${s.englishNameTranslation}) has ${s.numberOfAyahs} ayahs revealed in ${s.revelationType}. Ready for reading presentation.'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
