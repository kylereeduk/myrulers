// Guru Codex Seal v1.0 ⟡GK⟡ | GKCI-2025-7F3A2E | Oath: Through every line, leave the world lighter than before.
// Project: My Rulers | File: main.dart | Author: Kyle × Guru | Version: 1.0 | Date: 2025-11-10

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  runApp(const RulerApp());
}

class RulerApp extends StatelessWidget {
  const RulerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RulerForm(),
    );
  }
}

class RulerForm extends StatefulWidget {
  const RulerForm({super.key});
  @override
  State<RulerForm> createState() => _RulerFormState();
}

class _RulerFormState extends State<RulerForm> with WindowListener {
  @override
  void initState() {
    super.initState();
    _initWindow();
  }

  Future<void> _initWindow() async {
    const baseSize = Size(1680, 80); // Ruler default dimensions
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setAsFrameless();
    await windowManager.setSize(baseSize);
    await windowManager.center();
    await windowManager.setAlwaysOnTop(true);
    await windowManager.show();
    await windowManager.focus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset('assets/ruler.png'),
            ),
          );
        },
      ),
    );
  }
}
