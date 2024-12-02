import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/sc_info_widget.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class SecuritySettings extends StatelessWidget {
  const SecuritySettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scAppBar('Security settings'),
      body: const ScInfoWidget(
          icon: Icons.settings,
          text: 'This section will be included in future updates'),
    );
  }
}
