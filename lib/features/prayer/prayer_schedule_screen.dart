import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/mock_database_service.dart';

class PrayerScheduleScreen extends StatelessWidget {
  const PrayerScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<MockDatabaseService>();
    final p = db.prayerTimes;

    return Scaffold(
      appBar: AppBar(title: const Text('Prayer Schedule')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.access_time, size: 48, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(p.location, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(p.date, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Column(
                children: [
                  ListTile(title: const Text('Fajr'), trailing: Text(p.fajr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  const Divider(height: 1),
                  ListTile(title: const Text('Dhuhr'), trailing: Text(p.dhuhr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  const Divider(height: 1),
                  ListTile(title: const Text('Asr'), trailing: Text(p.asr, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  const Divider(height: 1),
                  ListTile(title: const Text('Maghrib'), trailing: Text(p.maghrib, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  const Divider(height: 1),
                  ListTile(title: const Text('Isha'), trailing: Text(p.isha, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
