import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Center(
        child: CupertinoSwitch(
          value: context.read<ThemeProvider>().isDarkMode,
          onChanged: (value) => context.read<ThemeProvider>().toggleTheme(),
        ),
      ),
    );
  }
}
