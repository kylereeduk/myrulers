// GK ⟡GK⟡ • GKCI-2025-7F3A2E • “Leave the world lighter.”

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class RulerState {
  Offset position;
  double width;
  double height;
  bool visible;
  RulerState({
    required this.position,
    required this.width,
    required this.height,
    required this.visible,
  });
  Map<String, dynamic> toJson() => {
    'x': position.dx,
    'y': position.dy,
    'w': width,
    'h': height,
    'v': visible,
  };
  static RulerState fromJson(Map<String, dynamic> j) => RulerState(
    position: Offset(j['x'], j['y']),
    width: j['w'],
    height: j['h'],
    visible: j['v'],
  );
}

class SyncController {
  final Map<int, RulerState> rulers = {
    1: RulerState(
      position: const Offset(100, 100),
      width: 600,
      height: 40,
      visible: true,
    ),
    2: RulerState(
      position: const Offset(100, 200),
      width: 600,
      height: 40,
      visible: true,
    ),
  };
  bool linked = true;
  late File cfgFile;

  static Future<SyncController> init() async {
    final c = SyncController();
    final dir = await getApplicationSupportDirectory();
    final path = '${dir.path}\\MyRulers';
    await Directory(path).create(recursive: true);
    c.cfgFile = File('$path\\settings.json');
    if (await c.cfgFile.exists()) {
      final j = jsonDecode(await c.cfgFile.readAsString());
      for (final k in ['1', '2']) {
        if (j.containsKey(k)) {
          c.rulers[int.parse(k)] = RulerState.fromJson(j[k]);
        }
      }
      c.linked = j['linked'] ?? true;
    }
    return c;
  }

  RulerState? stateFor(int id) => rulers[id];

  bool isVisible(int id) => rulers[id]?.visible ?? false;

  void updatePosition(int id, Offset pos) {
    rulers[id]?.position = pos;
    if (linked) {
      final other = id == 1 ? 2 : 1;
      rulers[other]?.position = Offset(
        pos.dx,
        rulers[other]!.position.dy,
      ); // mirror X only
    }
  }

  void toggleLink() => linked = !linked;

  void hide(int id) => rulers[id]?.visible = false;

  void toggleVisibility(bool vis) {
    for (var r in rulers.values) {
      r.visible = vis;
    }
  }

  Future<void> saveState() async {
    final data = {
      '1': rulers[1]!.toJson(),
      '2': rulers[2]!.toJson(),
      'linked': linked,
    };
    await cfgFile.writeAsString(
      const JsonEncoder.withIndent('  ').convert(data),
    );
  }
}
