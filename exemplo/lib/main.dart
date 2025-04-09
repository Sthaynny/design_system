import 'package:design_system/design_system.dart';
import 'package:exemplo/widgets/showcase/sample_user_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/showcase/sample_button.dart';
import 'widgets/showcase/sample_header.dart';
import 'widgets/showcase/sample_radio.dart';
import 'widgets/showcase/sample_switch.dart';
import 'widgets/showcase/sample_text_style.dart';

Future<void> main() async {
  await DSColors.inicialize(secundaryColor: Colors.amber);
  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Design System Showcase',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<String> _translations;

  @override
  void initState() {
    super.initState();
    _translations = rootBundle.loadString('assets/ds_localization.json');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DSHeader(
        title: 'Design System Showcase',
      ),
      body: FutureBuilder<String>(
          future: _translations,
          builder: (_, snapshot) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const SampleUserAvatarShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    const SampleTextStyleShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    const SampleButtonShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    const SampleSwitchShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    SampleRadioShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                    const SampleHeaderShowcase(),
                    const Divider(color: DSColors.neutralDarkCity),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
