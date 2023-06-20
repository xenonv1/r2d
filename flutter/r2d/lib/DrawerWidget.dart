import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  final String version = '0.0.1';

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
              onTap: () => context.go('/')),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(
              height: 1.0,
              thickness: 0.5,
            ),
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
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(
              height: 1.0,
              thickness: 0.5,
            ),
          ),
          const ListTile(
            title: Text('D2R-Modules'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Divider(
              height: 1.0,
              thickness: 0.5,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.mobile_screen_share),
            title: const Text('Video'),
            onTap: () => context.go('/video'),
          ),
          ListTile(
            leading: const Icon(Icons.numbers_rounded),
            title: Row(
              children: [
                const Text('Version: '),
                Text(version),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
