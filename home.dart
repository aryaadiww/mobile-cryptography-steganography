import 'package:enkridekrib_app/contents/dashboard/widgets/buttonnext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Future<bool> showExitConfirmationDialog(BuildContext context) async {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Ya'),
            ),
          ],
        ),
      );

      return result ?? false;
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final shouldPop = await showExitConfirmationDialog(context);
        if (shouldPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Container(
          width: width,
          height: height,
          color: const Color(0xFF8B83FA),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ButtonNextMenu(route: 'encrypt'),
              SizedBox(height: height / 3),
              const ButtonNextMenu(route: 'decrypt'),
            ],
          ),
        ),
      ),
    );
  }
}
