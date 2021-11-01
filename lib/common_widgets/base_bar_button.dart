import 'package:flutter/material.dart';

class BaseBarButton extends StatelessWidget {
  final String name;
  final void Function() onPress;
  final OutlinedBorder? shapeBorder;
  BaseBarButton({required this.name, required this.onPress, this.shapeBorder});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(
        name,
      ),
    );
  }
}
