// GK ⟡GK⟡ • GKCI-2025-7F3A2E • “Leave the world lighter.”

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class RulerWindow extends StatefulWidget {
  final int id;
  final Offset startPos;
  const RulerWindow({super.key, required this.id, required this.startPos});

  @override
  State<RulerWindow> createState() => _RulerWindowState();
}

class _RulerWindowState extends State<RulerWindow> with WindowListener {
  Offset offset = Offset.zero;
  bool linked = true;

  @override
  void initState() {
    super.initState();
    offset = widget.startPos;
    _initWindow();
  }

  Future<void> _initWindow() async {
    await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
    await windowManager.setAsFrameless();
    await windowManager.setSize(const Size(600, 40));
    await windowManager.setPosition(offset);
    await windowManager.setAlwaysOnTop(true);
    await windowManager.show();
  }

  Offset? startMouse;
  Offset? startWindow;

  void _onPanStart(DragStartDetails details) async {
    startMouse = details.globalPosition;
    startWindow = await windowManager.getPosition();
  }

  void _onPanUpdate(DragUpdateDetails details) async {
    if (startMouse == null || startWindow == null) return;
    final delta = details.globalPosition - startMouse!;
    await windowManager.setPosition(startWindow! + delta);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black54)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                linked ? Icons.link : Icons.link_off,
                size: 16,
                color: Colors.white70,
              ),
              onPressed: () => setState(() => linked = !linked),
              tooltip: linked ? 'Unlink' : 'Link',
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 16, color: Colors.white70),
              onPressed: () async => await windowManager.hide(),
              tooltip: 'Hide ruler',
            ),
            const SizedBox(width: 6)
          ],
        ),
      ),
    );
  }
}
