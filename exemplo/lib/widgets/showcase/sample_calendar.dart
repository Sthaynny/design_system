import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class SampleCalendarShowcase extends StatefulWidget {
  const SampleCalendarShowcase({super.key});

  @override
  State<SampleCalendarShowcase> createState() => _SampleCalendarShowcaseState();
}

class _SampleCalendarShowcaseState extends State<SampleCalendarShowcase> {
  final today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(
        title: 'Calendar Showcase',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DSCalendar(
              selected: today,
              fromMonth: DateTime(today.year - 1),
              toMonth: DateTime(today.year, 12),
            ),
            const Divider(color: DSColors.neutralDarkCity),
            DSCalendar.multiple(
              numberOfMonths: 2,
              fromMonth: DateTime(today.year),
              toMonth: DateTime(today.year + 1, 12),
              min: 5,
              max: 10,
            ),
            const Divider(color: DSColors.neutralDarkCity),
            DSCalendar.range(
              min: 2,
              max: 5,
            )
          ],
        ),
      ),
    );
  }
}
