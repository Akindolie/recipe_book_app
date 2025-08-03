import 'package:flutter/material.dart';

import '../models/user_preference.dart';

// Settings screen that returns data
class SettingsScreen extends StatefulWidget {
  final UserPreferences currentPreferences;

  const SettingsScreen({super.key, required this.currentPreferences});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool isDarkMode;
  late String language;
  late bool enableNotifications;
  late double fontSize;

  @override
  void initState() {
    super.initState();
    // Initialize with current values
    isDarkMode = widget.currentPreferences.isDarkMode;
    language = widget.currentPreferences.language;
    enableNotifications = widget.currentPreferences.enableNotifications;
    fontSize = widget.currentPreferences.fontSize;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [TextButton(onPressed: _saveSettings, child: Text('Save'))],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // Dark mode toggle
          SwitchListTile(
            title: Text('Dark Mode'),
            subtitle: Text('Use dark theme throughout the app'),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),

          // Language selection
          ListTile(
            title: Text('Language'),
            subtitle: Text(language),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: _selectLanguage,
          ),

          // Notifications toggle
          SwitchListTile(
            title: Text('Notifications'),
            subtitle: Text('Receive push notifications'),
            value: enableNotifications,
            onChanged: (value) {
              setState(() {
                enableNotifications = value;
              });
            },
          ),

          // Font size slider
          ListTile(
            title: Text('Font Size'),
            subtitle: Slider(
              value: fontSize,
              min: 12.0,
              max: 24.0,
              divisions: 6,
              label: fontSize.round().toString(),
              onChanged: (value) {
                setState(() {
                  fontSize = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectLanguage() async {
    final selectedLanguage = await showDialog<String>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Select Language'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'English'),
            child: Text('English'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'Spanish'),
            child: Text('Spanish'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'French'),
            child: Text('French'),
          ),
        ],
      ),
    );

    if (selectedLanguage != null) {
      setState(() {
        language = selectedLanguage;
      });
    }
  }

  void _saveSettings() {
    // Create updated preferences
    final updatedPreferences = UserPreferences(
      isDarkMode: isDarkMode,
      language: language,
      enableNotifications: enableNotifications,
      fontSize: fontSize,
    );

    // Return the data to the calling screen
    Navigator.pop(context, updatedPreferences);
  }
}
