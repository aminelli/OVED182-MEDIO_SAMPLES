import 'package:flutter/material.dart';
import 'package:my_awesome_namer/components/change_theme_segmented_button.dart';

/// [SettingsScreen] is the Widget that shows the settings screen.
/// For now it shows the [ChangeThemeSegmentedButton] Widget.
///
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Settings", style: Theme.of(context).textTheme.headlineLarge),
        FittedBox(child: ChangeThemeSegmentedButton()),
      ],
    );
  }
}
