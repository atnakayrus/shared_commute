import 'package:flutter/material.dart';
import 'package:shared_commute/views/widgets/sc_info_widget.dart';
import 'package:shared_commute/views/widgets/widget_builders.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: scAppBar('F A Q s'),
      body: const ScInfoWidget(
          icon: Icons.question_mark,
          text: 'This section will be included in future updates'),
    );
  }
}
