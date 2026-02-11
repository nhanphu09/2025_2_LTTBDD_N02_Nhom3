import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../utils/app_localizations.dart';
import '../screens/login_screen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Cài đặt chung",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(AppLocalizations.t(context, 'dark_mode')),
                secondary: const Icon(Icons.dark_mode, color: Colors.blue),
                value: appState.isDark,
                onChanged: appState.toggleTheme,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.blue),
                title: Text(AppLocalizations.t(context, 'language')),
                trailing: DropdownButton<String>(
                  value: appState.locale.languageCode,
                  underline: Container(),
                  items: const [
                    DropdownMenuItem(value: 'vi', child: Text("Tiếng Việt")),
                    DropdownMenuItem(value: 'en', child: Text("English")),
                  ],
                  onChanged: (val) {
                    if (val != null) appState.changeLanguage(val);
                  },
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app, color: Colors.red),
                title: Text(
                  AppLocalizations.t(context, 'logout'),
                  style: const TextStyle(color: Colors.red),
                ),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: Text(AppLocalizations.t(context, 'logout')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
