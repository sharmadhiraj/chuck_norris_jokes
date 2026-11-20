import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    required this.categories,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<String> categories;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildChip(label: "Random", category: null),
          for (final String category in categories)
            _buildChip(label: _capitalize(category), category: category),
        ],
      ),
    );
  }

  String _capitalize(String text) => text[0].toUpperCase() + text.substring(1);

  Widget _buildChip({required String label, required String? category}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Semantics(
        button: true,
        label: "Category $label",
        child: ChoiceChip(
          label: Text(label),
          selected: selected == category,
          showCheckmark: false,
          onSelected: (_) => onSelected(category),
        ),
      ),
    );
  }
}
