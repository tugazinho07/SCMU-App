import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scmu/provider/provider.dart';
import 'package:scmu/components/bottomNavigator.dart';
import 'package:scmu/components/box.dart';




class settingsPage extends StatelessWidget {
  const settingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UiProvider>(
          builder: (context, UiProvider notifier, child) {
            return Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text("Dark theme"),
                  trailing: Switch(
                      value: notifier.isDark,
                      onChanged: (value)=>notifier.changeTheme()
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}


