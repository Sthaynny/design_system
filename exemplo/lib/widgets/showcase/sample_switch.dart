import 'package:design_system/design_system.dart';
import 'package:exemplo/controllers/sample_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SampleSwitchShowcase extends StatelessWidget {
  const SampleSwitchShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    SampleSwitchController controller = Get.put(SampleSwitchController());

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Obx(
          () => DSSwitchTile(
            value: controller.onSwitchTile.value,
            onChanged: (value) => controller.toggleSwitchTile(),
            title: DSBodyText(
              'Label switch',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => DSSwitchTile(
            isEnabled: false,
            value: controller.onSwitchTileDisabled.value,
            onChanged: (value) => controller.onSwitchTileDisabled,
            title: DSBodyText(
              'Label switch is overflow text sadasd asd asd ',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => DSSwitch(
            onChanged: (value) => controller.toggleSwitch(),
            value: controller.onSwitch.value,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
