import 'package:flutter/material.dart';

class ButtonNextMenu extends StatelessWidget {
  final String route;
  const ButtonNextMenu({
    super.key,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3,
            vertical: MediaQuery.of(context).size.height / 50,
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          const Color(0xFF6860D7),
        ),
      ),
      child: Text(
        route,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
