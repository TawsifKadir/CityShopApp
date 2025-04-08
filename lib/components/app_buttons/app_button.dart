import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grs/constants/colors.dart';

import '../../enum/enums.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final ButtonVariant variant;
  final Widget? leadingIcon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isFullWidth = true,
    this.variant = ButtonVariant.primary,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (leadingIcon != null) ...[
          leadingIcon!,
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: variant == ButtonVariant.primary
          ? ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: pink,
          foregroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: buttonChild,
      )
          : OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: pink,
          side: const BorderSide(color: pink),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: buttonChild,
      ),
    );
  }
}

