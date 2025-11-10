// GK ⟡GK⟡ • GKCI-2025-7F3A2E • “Leave the world lighter.”

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';
import 'ruler_window.dart';

class WindowConfig {
  List<Offset?> positions = [null, null];
  bool visible = true;
  Map<String, dynamic> toJson() => {
        'positions': positions
            .map((p) => p == null ? null : {'x': p.dx, 'y': p.dy})
            .toList(),
        'visible': visible
      };
  static WindowConfig fromJson(Map<String, dynamic> j) {
    final c = WindowConfig();
    c.positions = (j['positions'] as List)
        .map((p) => p == null
            ? null
            : Offset((p['x'] ?? 0.0).toDouble(), (p['y'] ?? 0.0).toDouble()))
        .toList();
    c.visible = j['visible'] ?? true;
    return c;
  }
}

class WindowService {
  late File cfg;

  Future<WindowConfig> load() async {
    final dir = await getApplicationSupportDirectory();
    final path = '${dir.path}\\MyRulers';
    await Directory(path).create(recursive: true);
    cfg = File('$path\\settings.json');
    if (!await cfg.exists()) {
      await cfg.writeAsString(jsonEncode(WindowConfig().toJson()));
    }
    final j = jsonDecode(await cfg.readAsString());
    return WindowConfig.fromJson(j);
  }

  Future<void> spawnRuler(int id, Offset pos) async {
    await windowManager.waitUntilReadyToShow(
      const WindowOptions(
        size: Size(600, 40),
        center: false,
        skipTaskbar: true,
        backgroundColor: Color(0xFF1E1E1E),
        titleBarStyle: TitleBarStyle.hidden,
        alwaysOnTop: true,
      ),
      () async {
        await windowManager.setAsFrameless();
        await windowManager.setPosition(pos);
        await windowManager.show();

        // Mount a ruler widget into the existing window
        WidgetsBinding.instance.addPostFrameCallback((_) {
          runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            home: RulerWindow(id: id, startPos: pos),
          ));
        });
      },
    );
  }

  Future<void> toggleVisibility() async {
    final visible = !(await windowManager.isVisible());
    if (visible) {
      await windowManager.show();
    } else {
      await windowManager.hide();
    }
  }
}
