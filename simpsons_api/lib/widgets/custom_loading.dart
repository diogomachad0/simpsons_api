import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final ValueListenable listenable;
  final String textButton;
  final VoidCallback action;
  final Color textColor;

  const CustomLoading({
    super.key,
    required this.listenable,
    required this.textButton,
    required this.action,
    this.textColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: listenable,
      builder: (context, isLoading, _) {
        return ElevatedButton(
          onPressed: isLoading ? null : action,
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor,
          ),
          child: !isLoading
              ? Text(
                  textButton,
                  style: TextStyle(color: textColor),
                )
              : const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                ),
        );
      },
    );
  }
}
