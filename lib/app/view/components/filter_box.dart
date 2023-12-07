import 'package:flutter/material.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lime.shade600,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
          bottom: Radius.circular(25),
        ),
      ),
      child: const Text('People'),
    );
  }
}
