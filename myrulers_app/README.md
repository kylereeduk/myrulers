# myrulers_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


<!-- Guru Codex Seal v1.0 ⟡GK⟡ | GKCI-2025-7F3A2E | Oath: Through every line, leave the world lighter than before. -->
<!-- Project: My Rulers Alignment Tool | File: README.md | Author: Kyle × Guru | Version: 1.0 | Date: 2025-11-09 -->

# 🪶 My Rulers Alignment Tool v1.0  

A minimalist, frameless on-screen alignment ruler for designers, coders, and creators.  
Built with **Flutter + window_manager**, the tool provides pixel-accurate, always-on-top rulers that float cleanly above all applications.

---

## ✅ Current Release — v1.0 (Stable)
**Features**
- Frameless, transparent overlay (Windows)  
- Smooth vertical drag across full screen  
- Always-on-top behavior  
- Simple, dark-mode visual with soft depth and tick marks  
- Supports running multiple instances for multi-monitor setups  
- Normal taskbar presence for safe right-click → Close  

---

## 🧭 Phase 2 Roadmap — Multi-Monitor & Sync Expansion (+ macOS Parallel Build)

**1️⃣ Multi-Display Auto-Spawn**  
- Detect all connected displays and spawn one ruler per monitor  
- Restore each ruler’s saved offset from a JSON config  

**2️⃣ Link Toggle (🔗)**  
- Small on-ruler toggle to link/unlink rulers  
- When linked, all move in unison while preserving relative offsets  

**3️⃣ Visibility Hotkey**  
- Global shortcut `Ctrl + Alt + R` (Windows) / `⌘ + ⌥ + R` (macOS) to hide / show rulers  

**4️⃣ Persistence**  
- Auto-save and auto-restore per-screen positions  

**5️⃣ Cross-Platform Expansion**  
- macOS version ships alongside Phase 2 with identical features, visuals, and hotkey mapping  

---

## 🧩 Tech Stack
- **Flutter 3.35+**  
- **window_manager 0.3.8**  
- **dart:ui CustomPainter** for ruler visuals  

---

## 🧰 Usage
1. Run via terminal:  
   ```powershell
   flutter run -d windows
