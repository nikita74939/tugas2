import 'package:flutter/material.dart';
import '../../models/lap_data.dart';

class LapList extends StatelessWidget {
  final List<LapData> laps;
  final String Function(Duration) formatDuration;

  const LapList({
    super.key,
    required this.laps,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: laps.length,
      itemBuilder: (context, i) {
        final lap = laps[i];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Count ${lap.index}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    formatDuration(lap.split),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                formatDuration(lap.total),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        );
      },
    );
  }
}