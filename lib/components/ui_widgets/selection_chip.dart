import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final ValueChanged<bool>? onSelected;
  final Widget? leadingIcon;

  const SelectionChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onSelected,
    this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
            const SizedBox(width: 6),
          ],
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: onSelected,
      avatar: isSelected ? const Icon(Icons.check, size: 18) : null,
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: isSelected ? Colors.white : Colors.black,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: isSelected ? Colors.pink : Colors.black,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      selectedColor: Colors.pink,
      backgroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    );
  }
}