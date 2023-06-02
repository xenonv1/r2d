import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'NavigatorTestRoute.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
                'ASE Navigation'),
              ),
          ),
          ListTile(
            leading: const Icon(Icons.house_rounded),
            title: const Text('Homescreen'),
            onTap: () => context.go('/')
          ),
          ListTile(
            leading: const Icon(Icons.image_search_rounded),
            title: const Text('Objektklassifizierung'),
            onTap: () => context.go('/object-classification'),
          ),
          ListTile(
            leading: const Icon(Icons.mic_rounded),
            title: const Text('Audiorekorder'),
            onTap: () => context.go('/audio-recorder'),
            ),
            ListTile(
             leading: const Icon(Icons.camera_alt_rounded),
             title: const Text('Kamera'),
             onTap: () => context.go('/camera'),
            ),
            ListTile(
             leading: const Icon(Icons.manage_search_rounded),
             title: const Text('Texterkennung (OCR)'),
             onTap: () => context.go('/ocr'),
            ),
        ],
      ),
    );
  }
}
