// GK ⟡GK⟡ • GKCI-2025-7F3A2E • “Leave the world lighter.”

import 'package:flutter/material.dart';
import 'sync_controller.dart';

class RulerWidget extends StatefulWidget {
  final int id;
  final SyncController controller;
  const RulerWidget({super.key, required this.id, required this.controller});

  @override
  State<RulerWidget> createState() => _RulerWidgetState();
}

class _RulerWidgetState extends State<RulerWidget> {
  Offset offset = const Offset(100, 100);
  double width = 600;
  double height = 40;
  bool focused = true;

  @override
  void initState() {
    super.initState();
    final state = widget.controller.stateFor(widget.id);
    if (state != null) {
      offset = state.position;
      width = state.width;
      height = state.height;
    }
  }

  void _toggleFocus() => setState(() => focused = !focused);

  void _toggleLink() => setState(() {
    widget.controller.toggleLink();
  });

  void _close() => setState(() {
    widget.controller.hide(widget.id);
  });

  @override
  Widget build(BuildContext context) {
    if (!widget.controller.isVisible(widget.id)) return const SizedBox();
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (d) {
          setState(() => offset += d.delta);
          widget.controller.updatePosition(widget.id, offset);
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.grey.shade900.withOpacity(0.98),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: focused
                  ? Colors.lightBlueAccent.withOpacity(0.7)
                  : Colors.black54,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _iconButton(
                Icons.pan_tool_alt_rounded,
                _toggleFocus,
                tooltip: "Click-through",
              ),
              _iconButton(
                widget.controller.linked ? Icons.link : Icons.link_off_outlined,
                _toggleLink,
                tooltip: "Link rulers",
              ),
              _iconButton(Icons.close, _close, tooltip: "Hide ruler"),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(
    IconData icon,
    VoidCallback onTap, {
    required String tooltip,
  }) {
    return InkWell(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(icon, size: 18, color: Colors.white70),
        ),
      ),
    );
  }
}
