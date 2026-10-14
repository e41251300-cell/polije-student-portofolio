import 'package:flutter/material.dart';

class TechDropdown extends StatelessWidget {
  final String selectedTech;
  final List<String> technologies;
  final ValueChanged<String?> onChanged;

  const TechDropdown({
    super.key,
    required this.selectedTech,
    required this.technologies,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: DropdownButtonFormField<String>(
            initialValue: selectedTech,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.layers, color: Color(0xFF2979FF)),
              labelText: 'Teknologi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            ),
            items: technologies.map((String tech) {
              return DropdownMenuItem<String>(value: tech, child: Text(tech));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
